# Create the local packaging git repo with dh_make

**Important:** Attempting to package a code that does not use some standard 
distribution mechanism (e.g. [setuptools](https://setuptools.readthedocs.io) for
python, or [autotools](https://www.gnu.org/software/automake/manual/html_node/Autotools-Introduction.html) 
or [CMake](https://cmake.org/) C/C++, etc.) is likely to be painful (even if it 
seems easy at first) and will probably lead to a difficult to maintain package. 
This also applies to upstreams that make a poor use of the distribution mechanism
(e.g. by hardcoding paths or forcing non-standard install locations)
Seriously consider fixing the distribution, mechanism prior to packaging such code.  

Note: This is a generic recipe based on `dh_make`. If you are packaging a 
python code that uses setuptools for distribution, consider using the 
?workflow C? instead of this generic one.

[dh_make](https://www.debian.org/doc/manuals/maint-guide/first.en.html#non-native-dh-make) 
is a generic tool for creating a skeleton of a debian source package. Use it 
[in conjunction with `gbp import-orig`](http://honk.sigxcpu.org/projects/git-buildpackage/manual-html/gbp.import.html#GBP.IMPORT.FROMSCRATCH) 
to create a local packaging git repo as follows:

- Download the code to be packaged from upstream (In the following example, it is referred to as <UP_TARBALL>, and is assumed to have an upstream version <UP_VERSION>) 

```
mkdir /packaging/<SRC_NAME>-<UP_VERSION>
cd /packaging/<SRC_NAME>-<UP_VERSION>
git init
gbp import-orig --pristine-tar -u <UP_VERSION> <UP_TARBALL>
git remote add origin https://git.cells.es/ctpkg/<SRC_NAME>_deb.git
dh_make
cd /packaging/
mv <SRC_NAME>-<UP_VERSION> <SRC_NAME>_deb
cd /packaging/<SRC_NAME>_deb
```

Notes: 

- <SRC_NAME> is the name of the debian source package that we want to create (see [Appendix 3 - ALBA packaging naming convention](Appendix_3.md)). 
- <UP_VERSION> is the upstream version
- <UP_TARBALL> is the name of (path to) the tarball containing the upstream source code.
- dh_make will make several questions. Reply as best as you can, but do not worry: everything can be changed later on (see the ?Edit the Debian Folder Files as needed? recipe)
- dh_make complains if the directory is not called <SRC_NAME>-<UP_VERSION>, but that does not fit our conventions. That?s why we change the dir name *after* running dh_make to generate the skeleton

