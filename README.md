# brew-go

[![Gem version](https://img.shields.io/gem/v/brew-go.svg)](https://rubygems.org/gems/brew-go)

Manage Go tools via Homebrew. Don't clutter your `$GOPATH` anymore.

Internally brew-go still relies on `go get`, but puts things into
`/usr/local/Cellar/brew-go-*`, builds the binary, removes everything else that
was needed for building, and links the binary to `/usr/local/bin/*`. All in one
go.

The gem was inspired by [this blog post](https://blog.filippo.io/cleaning-up-my-gopath-with-homebrew).

## Installation

    $ gem install brew-go

## Usage

See `brew go` for all available commands.

Example:

    $ brew go get guru golang.org/x/perf/cmd/benchstat
    [✓] benchstat (golang.org/x/perf/cmd/benchstat)
    [✓] guru (golang.org/x/tools/cmd/guru)

    $ which benchstat guru
    /usr/local/bin/guru
    /usr/local/bin/benchstat

    $ brew go list
    benchstat (golang.org/x/perf/cmd/benchstat)
    guru      (golang.org/x/tools/cmd/guru)

    $ brew go list guru
    /usr/local/Cellar/brew-go-guru/golang.org#x#tools#cmd#guru/bin/guru

    $ brew go update guru
    [✓] brew-go-guru (golang.org/x/tools/cmd/guru)

    $ brew go rm guru
    Uninstalling /usr/local/Cellar/brew-go-guru/golang.org#x#tools#cmd#guru... (7.8MB)

    $ brew uninstall brew-go-benchstat
    Uninstalling /usr/local/Cellar/brew-go-benchstat/golang.org#x#perf#cmd#benchstat... (3.6MB)
