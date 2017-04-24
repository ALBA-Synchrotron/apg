# Exemplary package: C DS/library (SerialLine)

This was the workflow followed for creating the SerialLine packages:

## D1 - [Get the debpack Docker](recipe.Get_the_debpack_Docker.md)

## D2 - [Get the source tarball](recipe.Get_the_source_tarball.md)

SerialLine project is part of the TANGO project, it is hosted in sourceforge (svn). 
The source tarball was generated with these commands: 
```
svn export https://svn.code.sf.net/p/tango-ds/code//DeviceClasses/Communication/SerialLine/tags/release_1_2_12/ SerialLine-1.2.12
tar -cvzf SerialLine-1.2.12.tar.gz serialline-1.2.12
rm -rf serialline-1.2.12
``` 

## D3 - [Create local packaging git repo with dh_make](recipe.Create_local_packaging_git_repo_with_dh_make.md)

For creating the git repo using dh_make, these commands were executed:

```
mkdir /packaging/serialline-1.2.12
cd /packaging/serialline-1.2.12
git init
gbp import-orig --pristine-tar -u 1.2.12 ../serialline-1.2.12.tar.gz
git remote add origin https://git.cells.es/ctpkg/serialline_deb.git
dh_make
```

The `serialline` upstream includes the sources for a library and a device server.
The chosen `dh_make` template was for packaging a library.  This is the dh_make output:

```
> dh_make
Type of package: (single, indep, library, python)
[s/i/l/p]?
> l
Email-Address       : cfalcon@cells.es
License             : blank
Package Name        : serialline
Maintainer Name     : cfalcon
Version             : 1.11.1
Package Type        : library
Date                : Wed, 20 Apr 2017 13:21:46 +0000
Are the details correct? [Y/n/q]
> Y
```

Then we have to rename the previous folder:

```
cd
mv /packaging/serialline-1.2.12 /packaging/serialline_deb
cd /packaging/serialline_deb
```


## B4. [Create the remote git repo](recipe.Create_the_remote_git_repo.md)

The following command was used to create the yat_deb repository in 
`ctpkg` group of `git.cells` 

```
create_ctpkg_project serialline_deb "Repo for packaging SerialLine on debian" \
                                    "lib, ds, c++, cfalcon"
```

## B5. [Push to the remote git repo](recipe.Push_to_the_remote_git_repo.md)

## A4. [Edit the Debian Folder Files as needed](recipe.Edit_the_Debian_Folder_Files.md)

The `dh_make` command generated templates of most of the needed debian files.
In this step some of those files were [edited or deleted, and a few ones were created](https://git.cells.es/ctpkg/serialline_deb/commit/68e15291eee7ca359e707c634947edd34669ee3c)

For building the project, the upstream needed to be patched. It was patched
following this [guide](http://honk.sigxcpu.org/projects/git-buildpackage/manual-html/gbp.patches.html),
using the following commands:

```
gbp pq import
# A patch was applied via commit
gbp pq export
git add debian/patches
git commit
```

You can see the patch, [here](https://git.cells.es/ctpkg/serialline_deb/commit/65c8c0e11054390a467ebff5ae7cba1c1a38dff8).

This project generates three packages, two for the libraries `libserialline1` and `libserialline-dev`, and other
for the device server `tangods-serialline`.

The `dh_make` creates the skeleton for the libraries and some debian files were further [edits](https://git.cells.es/ctpkg/serialline_deb/commit/2298e40b3a23c017fa39d1e31107074bad847e15)

The build dependencies and descriptions were edited in the [control](https://git.cells.es/ctpkg/serialline_deb/commit/2298e40b3a23c017fa39d1e31107074bad847e15#58ef006ab62b83b4bec5d81fe5b32c3b4c2d1cc2)
file.


- The main changes were in [rules](https://git.cells.es/ctpkg/serialline_deb/commit/2298e40b3a23c017fa39d1e31107074bad847e15#8756c63497c8dc39f7773438edf53b220c773f67)
file, where overrides were added and some options were uncommented for compiling the project:

```
DEB_HOST_MULTIARCH ?= $(shell dpkg-architecture -qDEB_HOST_MULTIARCH)
export DEB_BUILD_MAINT_OPTIONS = hardening=+all


override_dh_auto_configure:
	dh_auto_configure --


override_dh_auto_build:
	# We force to use debug in order to generate debug-symbols
	# It could possibly be solved in upstream
	make -C src OUTPUT_TYPE=SHARED_LIB  OUTPUT_DIR=. RELEASE_TYPE=DEBUG

override_dh_auto_clean:
	dh_clean
	rm -rf src/*.so*

```

The [libserialline-dev.install](https://git.cells.es/ctpkg/serialline_deb/blob/38167e9dbcf05635558b9fab577e8a2332aab77d/debian/libserialline-dev.install),
[libserialline1.install](https://git.cells.es/ctpkg/serialline_deb/blob/38167e9dbcf05635558b9fab577e8a2332aab77d/debian/libserialline1.install),
and [copyright](https://git.cells.es/ctpkg/serialline_deb/blob/38167e9dbcf05635558b9fab577e8a2332aab77d/debian/copyright)
have been modified to fill/fix the generated template.

The watch file does not work for this project due to the SF structure project.

Since code is not maintained and the packages are intended for internal use
and there is not current intention of promoting it to debian, the requirements were relaxed
and many lintian errors were overridden in the [libserialline1.lintian-overrides](https://git.cells.es/ctpkg/serialline_deb/commit/2298e40b3a23c017fa39d1e31107074bad847e15#766694b113023c4e7233d366f2fcc21aad41c4de).
file.


The steps to generate the device server package  were  done in this [commit](https://git.cells.es/ctpkg/serialline_deb/commit/b6fdcee67ecb82dfc46f321a06728441aefaf604).
The package was defined in the `control` file, the `override_dh_auto_build` was modified in the `rules` file
to compile the device server, and the `tangods-serialine.install` file was created.

For [creating the device server man pages](https://git.cells.es/ctpkg/serialline_deb/commit/165ebe4df39953ffc1e128a58996fa8b1e7ceebd),
the dependency of `help2man` was added to the `control` file, a this override and entry were added in the `rules` file:

```
MANS = Serial.1

%.1:
	help2man -n '$* DS' --no-info --no-discard-stderr --include debian/help2man -o $(CURDIR)/debian/$@ ./src/$*

override_dh_installman: $(MANS)
	dh_installman
```

Moreover the [help2man](https://git.cells.es/ctpkg/serialline_deb/commit/165ebe4df39953ffc1e128a58996fa8b1e7ceebd#115581112935d379c61faab00a201c876f9eb468),
and [tangods_serialline.manpages](https://git.cells.es/ctpkg/serialline_deb/commit/165ebe4df39953ffc1e128a58996fa8b1e7ceebd#78e986c09b3355ce0dab7abc33843f674b1305ca) files
were created.

Once again lintian reports problems, and the necessary lintian overrides were done in this [commit](https://git.cells.es/ctpkg/serialline_deb/commit/af15f8b7927fab18f564a5e3dde64e2c433d69b2).



## A5. [Build package](recipe.Build_package.md)

## A6. [Update Changelog and tag](recipe.Update_changelog_and_tag.md)

The following commands were executed.

```
gbp dch --release --commit --since 63a1c06e
gbp buildpackage
```

And after check that the `gbp dch` did not introduce any lintian error.

Lintian reports an information message that could not be overridden due to it is not
a package issue:
`I: serialline changes: backports-changes-missing`


```
gbp buildpackage --git-tag-only 
git push --all
git push --tags

```

## A7. [Upload artifacts](recipe.Upload_artifacts.md)

------------------------------
