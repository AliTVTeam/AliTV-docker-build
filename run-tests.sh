#!/bin/sh
# Run the test suites of the AliTV repositories.
#
# Usage: alitv-run-tests [viewer|perl] <directory>
set -eu

case "${1:-}" in
    viewer)
        cd "$2"
        npm ci
        npm test
        ;;
    perl)
        cd "$2"
        prove -lr t
        ;;
    *)
        echo "Usage: $0 [viewer|perl] <directory>" >&2
        exit 2
        ;;
esac
