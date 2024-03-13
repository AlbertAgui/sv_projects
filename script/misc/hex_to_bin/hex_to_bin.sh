#!/bin/bash

RED='\033[0;31m'
NC='\033[0m' # No Color

warning_exit() {
    if [ ! "$#" -eq 1 ]; then
        echo "Usage: invalid argument number: $#, valid is 1\nUse format echo_warning_exit message"
    else
        echo "$1"
    fi
}

echo_warning_exit () {
    warning_message() {
        echo -e "${RED}'$1'${NC}"
    }

    warning_message "$(warning_exit "$1")"

    #verbosity
    if [ VB == 1 ]; then
        exit 1
    fi
}

dependencies () {
    #does test assert repo exists?
    if [ -d "assert" ]; then
        #update repo
        echo "Dependencies updated"
        cd assert
        git pull
        cd -
    else
        #clone repo
        echo "Dependencies cloned"
        git clone https://github.com/torokmark/assert.sh.git assert
    fi
}

has_sufix () {
    if [ ! "$#" -eq 1 ]; then
        echo_warning_exit "Usage: invalid argument number: $#, valid is 1\nUse format has_sufix message"
    else
        #if [[ $1 == *.*]]; then
        #    echo 1
        #else
        #    echo 0 
        #fi

        echo $($1 == *.*)
    fi
}

#erase_extension () {
#    if [ "$#" ]
#    return ${a.x##*.}
#}

convert () {
    has_sufix $1
    #riscv64-unknown-elf-objcopy -I ihex -O binary $1 output.bin
}

assert_eq () {
    if [ ! "$#" -eq 3 ]; then
        echo_warning_exit "Usage: invalid argument number: $#, valid is 3\nUse format assert_eq "string" EXPRESSION testid"
    fi
    
    if [[ "$1" != $2 ]]; then
        echo_warning_exit "Test $3: Wrong, $1 != $2"
    else 
        echo "Test $3: Passed!"
    fi
}

assert_neq () {
    if [ ! "$#" -eq 3 ]; then
        echo_warning_exit "Usage: invalid argument number: $#, valid is 3\nUse format assert_eq "string" EXPRESSION testid"
    fi
    
    if [[ "$1" == $2 ]]; then
        echo_warning_exit "Test $3: Wrong, $1 == $2"
    else 
        echo "Test $3: Passed!"
    fi
}

test () {
    #source 'assert/assert.sh'
    
    T1=$(warning_exit)
    assert_eq "$T1" Usage:* 1

    T2=$(warning_exit a)
    assert_eq "$T2" "a" 2

    T3=$(warning_exit ab)
    assert_neq "$T3" "a" 3
}

temp () {
    echo $0
    echo $1
    echo "rtl/lagarto_ox_tile/fpga/common/rtl/ox_bootrom.sv"
    echo $(pwd)
    echo $(git rev-parse --show-toplevel)
}

#run

#USAGE

VB=1 #verbosity

OUTPUT=invalid.hex

if [ "$#" -lt 1  ] || [ "$#" -gt 2 ]; then
    echo_warning_exit "Usage: invalid argument number: $#, valid is 1 or 2\nUse format: hex_to_bin.sh input_bin [output.hex]"
fi

if [ ! -f $1 ]; then
    echo_warning_exit "Usage: file $1 doesn't exist\nUse format: hex_to_bin.sh input_bin [output.hex]"
fi

#if [ "$#" -eq 2 ]; then 
#    OUTPUT=$1.hex
#else
#    OUTPUT=
#fi

VB=0 #verbosity

#dependencies
test

VB=1 #verbosity

convert $1 $OUTPUT
