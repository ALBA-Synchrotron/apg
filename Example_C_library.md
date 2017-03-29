This was the followed workflow for creating the YAT packages:

D1 - [Get a debpack:alba docker container running and log into it](https://git.cells.es/ctpkg/documentation/blob/master/Get_a_debpack_alba_docker_container_running_and_log_into_it.md)

D2 - [Get the source tarball](https://git.cells.es/ctpkg/documentation/blob/master/Get_the_source_tarball.md)

YAT library is part of the TANGO project, it is hosted in sourceforge (svn). 
The source tarball was get with these commands: 
```
svn export https://svn.code.sf.net/p/tango-cs/code/share/yat/tags/YAT-1.11.1 yat-1.11.1
tar -cvzf yat-1.11.1.tar.gz yat-1.11.1
rm -rf yat-1.11.1
``` 

D3 - [Create local packaging git repo with dh_make](https://git.cells.es/ctpkg/documentation/blob/master/Create_local_packaging_git_repo_with_dh_make.md)

For creating the git repo using dh_make, these commands were executed:
```
mkdir /packaging/yat-1.11.1
cd /packaging/yat-1.11.1
git init
gbp import-orig --pristine-tar -u 1.11.1 ../yat-1.11.1.tar.gz
git remote add origin https://git.cells.es/ctpkg/yat_deb.git
dh_make
```
It is the dh_make output:

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

B4. [Create the remote git repo](https://git.cells.es/ctpkg/documentation/blob/master/Create_the_remote_git_repo.md)

The following command was used to create the yat_deb repository in 
`ctpkg` group of `git.cells` 

```
create_ctpkg_project yat_deb "Repo for packaging YAT on debian" \
                                  "lib, c++, cfalcon"
```

B5. [Push to the remote git repo](https://git.cells.es/ctpkg/documentation/blob/master/Push_to_the_remote_git_repo.md)

A4. [Edit the Debian Folder Files as needed](https://git.cells.es/ctpkg/documentation/blob/master/A5. [Test the package building](https://git.cells.es/ctpkg/documentation/blob/master/Test_the_package_building.md)

The `dh_make` creates a templates of most of the needed debian files. 
In this step those files were edited, created or deleted.  You can see the changes in this [commit](https://git.cells.es/ctpkg/yat_deb/commit/f207d5be95517652c7c08dee61ba3579b7d8d174)

A5. [Test the package building](https://git.cells.es/ctpkg/documentation/blob/master/Test_the_package_building.md)


A6. [Update changelog, build the package, tag it, and push](https://git.cells.es/ctpkg/documentation/blob/master/Update_changelog_build_the_package_tag_it_and_push.md)

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

A7. [Upload_artifacts_to_ALBA_repo](https://git.cells.es/ctpkg/documentation/blob/master/Upload_artifacts_to_ALBA_repo.md)

------------------------------