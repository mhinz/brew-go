# brew-go

Manage Go tools via Homebrew. Don't clutter your `$GOPATH` anymore.

Internally brew-go still relies on `go get`, but puts things into
`/usr/local/Cellar/brew-go-*`, builds the binary, removes everything else that
was needed for building, and links the binary to `/usr/local/bin/*`. All in one
go.

## Installation

    $ gem install brew-go

## Usage

See `brew go` for all available commands.

Example:

    $ brew go get guru golang.org/x/perf/cmd/benchstat
    [✓] benchstat (golang.org/x/perf/cmd/benchstat)
    [✓] guru (golang.org/x/tools/cmd/guru)

    $ brew go list
    benchstat (golang.org/x/perf/cmd/benchstat)
    guru      (golang.org/x/tools/cmd/guru)

    $ brew go list guru
    /usr/local/Cellar/brew-go-guru/golang.org#x#tools#cmd#guru/bin/guru

    $ brew go update guru
    [✓] brew-go-guru (golang.org/x/tools/cmd/guru)
