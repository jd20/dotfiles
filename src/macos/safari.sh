#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../script/helper/utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_json_formatter() {

    local -r extUrl="https://github.com/downloads/rfletcher/safari-json-formatter/JSON_Formatter-1.1.safariextz"
    local -r dest="/tmp/JSON_Formatter-1.1.safariextz"
    
    download $extUrl $dest && open $dest
    print_result $? "Download JSON Formatter extension" "true"

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n   Safari\n\n"
    install_json_formatter

}

main
