#!/bin/bash

#Bash shell path relative to current script
	full_path=$(realpath $0)
	script_path=$(dirname $full_path)

	echo "pwd:"
	echo $(pwd)
	echo "realpath pwd"
	echo $(realpath $(pwd))

	echo "full path actual file"
	echo $full_path
	echo "realpath: full path actual file"
	echo $script_path

	exec 3> /dev/tty # open fd 3 and point to controlling terminal
	echo "Start simulation" >&3
	exec 3>&-

	exec 0> out.txt
	echo "hey"


