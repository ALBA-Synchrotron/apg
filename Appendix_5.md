# Appendix 5. Get upstream tarball

This appendix gives tips on how to download/generate tarballs to be used as
the upstream source for packaging.

## For python projects with a proper setup.py

Use `python setup.py sdist`

## For autotools-based projects

Use `make dist`

## Fallback for git projects 

For git-hosted projects that do not provide a standard way of creating the 
source tarball (i.e., they do not use setup.py or autotools, or equivalent), 
you can use:

```
mkdir -p /somewhere/else ?# IMPORTANT to have a pristine clone
git clone YOUR_PROJECT
git archive master | tar -x -C /somewhere/else
```

## Fallback for svn projects 

For svn-hosted projects that do not provide a standard way of creating the 
source tarball (i.e., they do not use setup.py or autotools, or equivalent), 
you can use:

```
svn export [-r REV] URL [PATH]
# create a tar file
```
