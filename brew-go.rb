#!/usr/bin/env ruby

@commons = {
  "benchstat" => "golang.org/x/perf/cmd/benchstat",
  "dlv" => "github.com/derekparker/delve/cmd/dlv",
  "guru" => "golang.org/x/tools/cmd/guru",
}

def helpme
  puts <<~HEREDOC
    Manage Go packages via Homebrew.

    Usage:
      $ brew go get <url to package> ...
      $ brew go list [name]
      $ brew go update [name] ...
      $ brew go common

    Examples:
      $ brew go get golang.org/x/tools/cmd/guru
      $ brew go get guru
      $ brew go list
      $ brew go list brew-go-guru
      $ brew go list guru
      $ brew go update
      $ brew go update guru
  HEREDOC
  exit 1
end

def cmd_common
  puts <<~HEREDOC
  Here are a few commonly used tools. The names can be used as shortcuts:
    $ brew go get guru

  HEREDOC
  print_formatted_list(@commons)
end

def cmd_get(packages)
  threads = []
  packages = resolve_common_packages packages

  packages.each do |url|
    threads << Thread.new do
      name = File.basename url
      cellarpath = "#{HOMEBREW_CELLAR}/brew-go-#{name}"
      gopath = "#{cellarpath}/#{url.gsub('/', '#')}"

      ENV["GOPATH"] = gopath
      ENV.delete "GOBIN"

      system "go get #{url}"
      unless $?.success?
        puts "[\x1b[31;1m✗\x1b[0m] #{url}"
        FileUtils.remove_dir "#{cellarpath}", true
        Thread.exit
      end

      puts "[\x1b[32;1m✓\x1b[0m] \x1b[1mbrew-go-#{name}\x1b[0m (#{url})"

      FileUtils.remove_dir "#{gopath}/pkg", true
      FileUtils.remove_dir "#{gopath}/src", true

      system "brew unlink brew-go-#{name}", out: File::NULL
      system "brew link brew-go-#{name}", out: File::NULL
    end
  end
  threads.each { |thr| thr.join }
end

def cmd_list(name)
  if name.nil?
    installed = {}
    Dir["#{HOMEBREW_CELLAR}/brew-go-*/*"].each do |path|
      name = File.basename(Pathname(path).parent.to_s).sub("brew-go-", "")
      url = get_url_from_cellar_path(path)
      installed[name] = url
    end
    print_formatted_list(installed)
    return
  end

  path = "#{HOMEBREW_CELLAR}/#{name}"
  if Dir.exist? path
    puts Dir["#{path}/**/*"].select { |f| File.file? f }
  else
    puts "No such keg: #{path}"
    exit 1
  end
end

def cmd_update(names)
  names = names.map { |name| name.start_with?("brew-go-") ? name : "brew-go-#{name}" }
  urls = if names.empty?
           Dir["#{HOMEBREW_CELLAR}/brew-go-*/*"].map do |path|
             get_url_from_cellar_path path
           end
         else
           names.map do |name|
             get_url_from_cellar_path Dir["#{HOMEBREW_CELLAR}/#{name}/*"].first
           end
         end
  cmd_get urls
end

def get_url_from_cellar_path(path)
  File.basename(path).gsub '#', '/'
end

def resolve_common_packages(packages)
  packages.map { |p| @commons[p] || p }
end

def print_formatted_list(packages)
  maxlen = packages.keys.map(&:length).max
  packages.each do |name, url|
    puts "\x1b[1m#{name.ljust(maxlen)}\x1b[0m (#{url})"
  end
end

case ARGV.shift
when 'common', 'commo', 'comm', 'com', 'co', 'c'
  cmd_common
when 'get', 'ge', 'g'
  ARGV.empty? ? cmd_common : cmd_get(ARGV)
when 'list', 'lis', 'li', 'l'
  cmd_list ARGV.first
when 'update', 'updat', 'upda', 'upd', 'up', 'u'
  cmd_update ARGV
else
  helpme
end
