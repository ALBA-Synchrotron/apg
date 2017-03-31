# ALBA Packaging Guide (by CTGenSoft)

## Introduction

There are many ways of creating debian packages and too many resources on the 
internet. Due to the dynamic nature of the packaging rules, some docs may be 
contradictory, so it is worth focusing on the following two authoritative 
sources for **generic Debian** packaging:

- [The Debian Policy Manual](https://www.debian.org/doc/debian-policy/)
- [The Debian New Maintainers Guide](https://www.debian.org/doc/manuals/maint-guide/index.en.html)

But still, those docs offer too much choice, so we wrote this *ALBA Packaging 
Guide* to describe the specific workflows and tools that have been chosen for 
packaging for ALBA.
If some instruction in this document contradicts what you read in a more generic
document, please contact someone from ctgensoft to check if this is a mistake on
our procedures or a deliberate choice.

Also, a set of practical examples have been documented. These are intended as 
very specific implementation examples of the *ALBA Packaging Guide* workflows, 
and should be used **together with the guide**.


## Workflows

When packaging for ALBA, you will likely be in one of the following cases :


### Workflow A - Maintaining an existing alba package (i.e. for which a packaging git repo exists):

1 - [Get the debpack Docker](recipe.Get_the_debpack_Docker.md)
2 - Clone the packaging repo from git.cells.es/ctpkg/<name>
3 - Update upstream if needed
4 - Edit the Debian Folder Files as needed
5 - Test the package building
6 - Update changelog, build the package, tag it, and push
7 - Upload artifacts to ALBA repo

### Workflow B - Re-packaging (backporting) an existing debian package that does not yet exist in the Alba repo

1 - Get a debpack:alba docker container running and log into it
2 - Download the debian source package
3 - Create the local gbp repo with `gbp import-dsc`
4 - Create the remote git repo
5 - Push to the remote git repo 
6 - Proceed as in Workflow A-4 and next

### Workflow C - Packaging a setuptools-based python code for which no alba or debian package already exist.

1 - Get a debpack:alba docker container running and log into it
2 - Get the python module upstream source and cd into it
3 - Generate the debian source (with python setup.py sdist_dsc ... ) 
4 - Proceed as in Workflow B-3 and next

### Workflow D - Packaging non-setuptools based code (e.g. C++ code) for which no alba or debian package already exist.

1 - Get a debpack:alba docker container running and log into it
2 - Get the source tarball
3 - Create local packaging git repo with dh_make
4 - Proceed as in Workflow B-4 and next
