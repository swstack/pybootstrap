# pybootstrap.sh

Use this script to bootstrap a python project with the following directory structure:

```
projectroot/
    README.md
    requirements.txt
    dev-requirements.txt
    pybootstrap.sh
```

## Usage

Copy this script into the root of your Python project to help get started wtih virtualenv
and pip very quickly.  The usage is as follows:

```
Usage: $ [source] ./bootstrap.sh [OPTIONS]

Optionally source this script to activate virtual env in your shell.

    -d             use dev requirements
    -f             force reinstall of packages
    -h             show help
```

As you can see from the usage, sourcing this script will activate virtual env in
your shell, and not just for the duration of the script execution.

**`requirements.txt` vs `dev-requirements.txt`:**

The difference here is that `dev-requirements.txt` should ONLY contain dependencies
that developers will need on the project and `requirements.txt` should ONLY
contain dependencies that are needed to run or build the application/project.

**Example**:

dev-requirements.txt
```
nose
mock
httpretty
```

requirements.txt
```
flask
sqlalchemy
```

Running `./pybootstrap.sh -d` will install **nose**, **mock** and **httpretty** and
running `./pybootstrap` will install **flask** and **sqlalchemy**.
