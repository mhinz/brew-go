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

If you're not a Ruby user, chances are that you use the system's `/usr/bin/gem`,
which tries installing to a directory that isn't writable by the user. Assuming
you have a local bin directory in $PATH, e.g. `~/bin`, use this instead:

    $ gem install --user-install -n ~/bin brew-go

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

    $ brew go common
    Here are a few commonly used tools. The names can be used as shortcuts:
      $ brew go get guru

    benchstat    (golang.org/x/perf/cmd/benchstat)
    dlv          (github.com/derekparker/delve/cmd/dlv)
    errcheck     (github.com/kisielk/errcheck)
    fillstruct   (github.com/davidrjenni/reftools/cmd/fillstruct)
    gocode       (github.com/nsf/gocode)
    godef        (github.com/rogpeppe/godef)
    goimports    (golang.org/x/tools/cmd/goimports)
    golint       (github.com/golang/lint/golint)
    gometalinter (github.com/alecthomas/gometalinter)
    gorename     (golang.org/x/tools/cmd/gorename)
    gotags       (github.com/jstemmer/gotags)
    guru         (golang.org/x/tools/cmd/guru)
    impl         (github.com/josharian/impl)
    interfacer   (mvdan.cc/interfacer)
    staticcheck  (honnef.co/go/tools/cmd/staticcheck)
    unused       (honnef.co/go/tools/cmd/unused)
