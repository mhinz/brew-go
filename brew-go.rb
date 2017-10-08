#!/usr/bin/env ruby

def helpme
  puts <<~HEREDOC
    Usage:
      brew go get <url to package> ...
    Examples:
      brew go get golang.org/x/perf/cmd/benchstat
  HEREDOC
  exit 1
end

def cmd_get(packages)
  date = Date.today

  packages.each do |url|
    name = File.basename url
    gopath = "#{HOMEBREW_PREFIX}/Cellar/brew-go-#{name}/#{date}"

    ENV["GOPATH"] = gopath
    ENV.delete "GOBIN"

    system "go get #{url}"
    exit 1 unless $?.success?

    FileUtils.remove_dir "#{gopath}/pkg", true
    FileUtils.remove_dir "#{gopath}/src", true

    IO.write "#{gopath}/url", "#{url}\n"

    system "brew unlink brew-go-#{name}"
    system "brew link brew-go-#{name}"
  end
end

def cmd_list
  Dir.chdir "#{HOMEBREW_PREFIX}/Cellar" do
    puts Dir["brew-go-*"]
  end
end

case ARGV.shift
when 'get'
  helpme if ARGV.empty?
  cmd_get ARGV
when 'list'
  cmd_list
else
  helpme
end
