# pybootstrap.sh

This script works best with a project that looks like this:

```
projectroot/
    .gitignore
    README.md
    requirements.txt
    dev-requirements.txt
    pybootstrap.sh
```

## Usage

Copy this script into the root of your Python project to help get started wtih virtualenv
and pip very quickly.  The usage is as follows:

```sh
Usage: $ [source] ./bootstrap.sh [OPTIONS]

Optionally source this script to activate virtual env in your shell.
    -d             use dev requirements
    -f             force reinstall of packages
    -h             show help
    -p             use python version 2 or 3, e.g. "-p 3"
```

Use `source` to activate virtual env in your shell, for instance:

```
$ source ./pybootstrap.sh -d
```

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

Running `source ./pybootstrap.sh` will install **flask** and **sqlalchemy** as defined in "requirements.txt".

Running `source ./pybootstrap.sh -d` will install **nose**, **mock** and **httpretty** as well as
the dependencies defined in requirements.txt
