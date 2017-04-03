# Exemplary package: C library (YAT)

This was the workflow followed for creating the YAT packages:

## D1 - [Get the debpack Docker](recipe.Get_the_debpack_Docker.md)

## D2 - [Get the source tarball](recipe.Get_the_source_tarball.md)

YAT library is part of the TANGO project, it is hosted in sourceforge (svn). 
The source tarball was generated with these commands: 
```
svn export https://svn.code.sf.net/p/tango-cs/code/share/yat/tags/YAT-1.11.1 yat-1.11.1
tar -cvzf yat-1.11.1.tar.gz yat-1.11.1
rm -rf yat-1.11.1
``` 

## D3 - [Create local packaging git repo with dh_make](recipe.Create_local_packaging_git_repo_with_dh_make.md)

For creating the git repo using dh_make, these commands were executed:

```
mkdir /packaging/yat-1.11.1
cd /packaging/yat-1.11.1
git init
gbp import-orig --pristine-tar -u 1.11.1 ../yat-1.11.1.tar.gz
git remote add origin https://git.cells.es/ctpkg/yat_deb.git
dh_make
```

And this is the dh_make output:

```
> dh_make
Type of package: (single, indep, library, python)
[s/i/l/p]?
> l
Email-Address       : cfalcon@cells.es
License             : blank
Package Name        : yat
Maintainer Name     : cfalcon
Version             : 1.11.1
Package Type        : library
Date                : Wed, 29 Mar 2017 13:21:46 +0000
Are the details correct? [Y/n/q]
> Y
```

Then we have to rename the previous folder: 

```
cd
mv /packaging/yat-1.11.1 /packaging/yat_deb
cd /packaging/yat_deb
```

## B4. [Create the remote git repo](recipe.Create_the_remote_git_repo.md)

The following command was used to create the yat_deb repository in 
`ctpkg` group of `git.cells` 

```
create_ctpkg_project yat_deb "Repo for packaging YAT on debian" \
                                  "lib, c++, cfalcon"
```

## B5. [Push to the remote git repo](recipe.Push_to_the_remote_git_repo.md)

## A4. [Edit the Debian Folder Files as needed](recipe.Edit_the_Debian_Folder_Files.md)

The `dh_make` command generated templates of most of the needed debian files. 
In this step some of those files were [edited or deleted, and a few ones were created](https://git.cells.es/ctpkg/yat_deb/commit/f207d5be95517652c7c08dee61ba3579b7d8d174)

This project generates two packages the `libyat1` and `libyat1-dev`.
The build dependencies and descriptions had to be edited in the [control](https://git.cells.es/ctpkg/yat_deb/blob/master/debian/control) 

For building the project, the upstream needed to be patched. It was patched 
following this [guide](http://honk.sigxcpu.org/projects/git-buildpackage/manual-html/gbp.patches.html), 
using the following commands:

```
gbp pq import
# Three patches were applied via commits
gbp pq export
git add debian/patches
git commit
```

You can see the three patches, [here](https://git.cells.es/ctpkg/yat_deb/commit/620a07c65a2ee6ac1586b37757002f3bb35ffbb7).

After patching the upstream, some debian files needed further edits:

- The main changes were in [rules](https://git.cells.es/ctpkg/yat_deb/blob/af8db84176b6ef279d8a949279386dfe9ebb064c/debian/rules) 
file, where two overrides were needed for compiling the project: 

```
override_dh_auto_configure:
        ./autogen.sh
        dh_auto_configure --

override_dh_auto_build:
        make -C src
```

Then, for avoiding the following lintian errors,
```
I: libyat1: no-symbols-control-file usr/lib/x86_64-linux-gnu/libyat.so.1.0.0
E: libyat1: symbols-file-contains-current-version-with-debian-revision
```

These overrides were added:

```
override_dh_shlibdeps: 	
    dpkg-gensymbols -plibyat1 -Odebian/libyat1.symbols -q
    sed -e "s:-[^-]*$::~:" -i debian/libyat1.symbols 	
    dh_makeshlibs 	
    dh_shlibdeps 

override_dh_clean: 	
    dh_clean libyat1.symbols

```

The [libyat-dev.install](https://git.cells.es/ctpkg/yat_deb/blob/af8db84176b6ef279d8a949279386dfe9ebb064c/debian/libyat-dev.install),
[copyright](https://git.cells.es/ctpkg/yat_deb/blob/af8db84176b6ef279d8a949279386dfe9ebb064c/debian/copyright), 
and the [watch](https://git.cells.es/ctpkg/yat_deb/blob/af8db84176b6ef279d8a949279386dfe9ebb064c/debian/watch) 
have been modified to fill/fix the generated template.


## A5. [Build package](recipe.Build_package.md)


## A6. [Update Changelog and tag](recipe.Update_changelog_and_tag.md)

The following commands were executed.

```
gbp dch --release --commit --since 0e0716332
gbp buildpackage
```

And after check that the `gbp dch` did not introduce any lintian error.

```
gbp buildpackage --git-tag-only 
git push --all
git push --tags

```

## A7. [Upload artifacts](recipe.Upload_artifacts.md)

------------------------------
