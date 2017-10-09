#!/usr/bin/env ruby

def helpme
  puts <<~HEREDOC
    Manage Go packages via brew.

    Usage:
      brew go get <url to package> ...
      brew go list [keg]

    Examples:
      brew go get golang.org/x/perf/cmd/benchstat
      brew list brew-go-benchstat
  HEREDOC
  exit 1
end

def cmd_get(packages)
  packages.each do |url|
    name = File.basename url
    gopath = "#{HOMEBREW_CELLAR}/brew-go-#{name}/#{url.gsub('/', '#')}"

    ENV["GOPATH"] = gopath
    ENV.delete "GOBIN"

    system "go get #{url}"
    exit 1 unless $?.success?

    FileUtils.remove_dir "#{gopath}/pkg", true
    FileUtils.remove_dir "#{gopath}/src", true

    system "brew unlink brew-go-#{name}"
    system "brew link brew-go-#{name}"
  end
end

def cmd_list(name)
  if name.nil?
    puts Dir["#{HOMEBREW_CELLAR}/brew-go-*"].map { |dir| File.basename dir }
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

case ARGV.shift
when 'get', 'ge', 'g'
  helpme if ARGV.empty?
  cmd_get ARGV
when 'list', 'lis', 'li', 'l'
  cmd_list ARGV.first
else
  helpme
end
