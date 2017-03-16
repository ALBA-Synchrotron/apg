# ALBA Packaging Guide (by CTGenSoft)


There are many ways of creating debian packages, and general docs may be confusing. 
This document intends to describe the workflows and tools that have been chosen for packaging for ALBA.
If some instruction in this document contradicts what you read in a more generic document, please contact 
someone from ctgensoft to check if this is a mistake on our procedures or a deliberate choice.

In general the most authoritative sources of info in case of doubt are:

- [The Debian Policy Manual](https://www.debian.org/doc/debian-policy/)
- [The Debian New Maintainers Guide](https://www.debian.org/doc/manuals/maint-guide/index.en.html)


## Workflows
When packaging for ALBA, you will likely be in one of the following cases (see the “recipes” section for details on 
how to perform each step):

### Workflow A - Maintaining an existing alba package (i.e. for which a packaging git repo exists):

1. Get a debpack:alba docker container running and log into it
2. Clone the packaging repo from git.cells.es/ctpkg/<name>
3. Edit the Debian Folder Files as needed
4. Test the package building 
5. Update changelog, build the package, tag it, and push
6. Upload artifacts to ALBA repo

### Workflow B - Re-packaging (backporting) an existing debian package that does not yet exist in the Alba repo

1. Get a debpack:alba docker container running and log into it
2. Download the debian source package
3. Create the local gbp repo with `gbp import-dsc`
4. Create the remote git repo
5. Push to the remote git repo 
6. Proceed as in Workflow A-3 and next

### Workflow C - Packaging a setuptools-based python code for which no alba or debian package already exist.

1. Get a debpack:alba docker container running and log into it
2. Get the python module upstream source and cd into it
3. Generate the debian source (with python setup.py sdist_dsc ... ) 
4. Proceed as in Workflow B-3 and next

### Workflow D - Packaging non-setuptools based code (e.g. C++ code) for which no alba or debian package already exist.

1. Get a debpack:alba docker container running and log into it
2. Get the source tarball
3. Create local packaging git repo with dh_make
4. Proceed as in Workflow B-4 and next