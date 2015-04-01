#!/usr/bin/env sh

# Run virtualenv if env/ doesn't exist
if [ ! -d "./env" ]; then
    virtualenv env
fi

# Parse command line arguments
print_usage() {
	cat <<_EOF_

Usage: $ [source] ./bootstrap.sh [OPTIONS]

Optionally source this script to activate virtual env in your shell.

    -d             use dev requirements
    -f             force reinstall of packages
    -h             show help
_EOF_
}

get_args() {
    local OPTIND
    opt_d=0
    opt_f=0
    while getopts "dfh" opt; do
      case $opt in
        h)
          print_usage
          return 0
          ;;
        d)
          opt_d=1
          ;;
        f)
          opt_f=1
          ;;
        \?)
          ;;
      esac
    done
}

get_args $@

# Activate virtualenv
. ./env/bin/activate

# Build install command string
install_dependencies() {
    local install_cmd

    install_cmd="./env/bin/pip install -i http://pypi.digi.com/simple"
    if [ $opt_f -eq 1 ]; then
        install_cmd=$(printf "%s --force-reinstall" $install_cmd)
    fi

    if [ $opt_d -eq 1 ]; then
        install_cmd=$(printf "%s -r dev-requirements.txt" $install_cmd)
    else
        install_cmd=$(printf "%s -r requirements.txt" $install_cmd)
    fi

    echo $install_cmd
#    eval $install_cmd
}

install_dependencies
