#!/usr/bin/env ruby

if ARGV.empty?
  puts "usage: brew go golang.org/x/perf/cmd/benchstat"
  exit 1
end

date = Date.today

ARGV.each do |url|
  name = File.basename url
  brewpath = "#{HOMEBREW_PREFIX}/Cellar/brew-go-#{name}"
  gopath = "#{brewpath}/#{date}"

  ENV["GOPATH"] = gopath
  ENV.delete "GOBIN"

  system "go get #{url}"

  FileUtils.remove_dir "#{gopath}/pkg", true
  FileUtils.remove_dir "#{gopath}/src", true

  IO.write "#{brewpath}/url", "#{url}\n"

  system "brew unlink brew-go-#{name}"
  system "brew link brew-go-#{name}"
end
