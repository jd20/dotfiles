#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && source "../script/helper/utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    ./run_shellcheck.sh

}

main
