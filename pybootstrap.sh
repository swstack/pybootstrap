#!/usr/bin/env sh

# Parse command line arguments
print_usage() {
	cat <<_EOF_

Usage: $ [source] ./bootstrap.sh [OPTIONS]

Optionally source this script to activate virtual env in your shell.

    -d             use dev requirements
    -f             force reinstall of packages
    -h             show help
    -p             use python version 2 or 3, e.g. "-p 3"
_EOF_
}

get_args() {
    local OPTIND
    dash_d=0
    dash_f=0
    pyversion=2
    while getopts "dfhp:" opt; do
      case $opt in
        h)
          print_usage
          return 0
          ;;
        d)
          dash_d=1
          ;;
        f)
          dash_f=1
          ;;
	p)
          pyversion=$OPTARG
          ;;
        \?)
          ;;
      esac
    done
}

# Build install command string
install_dependencies() {
    IFS="%"  # Preserve whitespace in variables by changing inter field separator
    install_cmd="./env/bin/pip install -i http://pypi.digi.com/simple"
    if [ $dash_f -eq 1 ]; then
        # reinstall packages
	echo "Force reinstalling packages..."
        install_cmd=$(printf "%s --force-reinstall" $install_cmd )
    fi

    if [ $dash_d -eq 1 ]; then
        # use dev-requirements.txt
        install_cmd=$(printf " %s -r dev-requirements.txt" $install_cmd)
    else
        # use requirements.txt
        install_cmd=$(printf "%s -r requirements.txt" $install_cmd)
    fi

    eval $install_cmd
    unset IFS
}

get_args $@

# Make virtualenv for py2
if [ ! -d "./env" ]; then
    virtualenv env
else
    echo "Virtual env for python 2 already found..."
fi

# Make virtualenv for py3
if [ ! -d "./env3" ]; then
    virtualenv -p /usr/bin/python3 env3
else
    echo "Virtual env for python 3 already found..."
fi

# Activate appropriate virtualenv
if [ $pyversion -eq 3 ]; then
    . ./env3/bin/activate
else
    . ./env/bin/activate
fi


if [ $dash_d -eq 1 ] && [ -f "dev-requirements.txt" ]; then
    echo "Installing development requirements..."
    install_dependencies
elif [ -f "requirements.txt" ]; then
    echo "Installing requirements..."
    install_dependencies
else
    echo "No requirements found..."
fi

