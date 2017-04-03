# Exemplary package: python library package using setuptools (Fandango)

This was the followed workflow for creating the Fandango package:

## C1. [Get the debpack Docker](recipe.Get_the_debpack_Docker.md)

Build and run the debpack container:
```
git clone https://git.cells.es/ctpkg/debpack.git
docker build --rm=true -t debpack:alba debpack/
xhost +local:
docker run -it --privileged=True  --name debpack -h debpack \
           -e "HOST_USER=$USER" -e DISPLAY=$DISPLAY -e QT_X11_NO_MITSHM=1 \
           -v /tmp/.X11-unix:/tmp/.X11-unix debpack:alba bash
```

## C2. [Get the python module upstream source and cd into it](recipe.Get_the_python_module_upstream_source.md)

Fandango package is present in github.

Inside debpack docker container do:
```
cd /packaging
git clone https://github.com/tango-controls/fandango.git
git checkout develop
```

## C3. [Generate the debian source with setuptools](recipe.Generate_the_debian_source_with_setuptools.md)


The fandango debian sources were generated with:


```
cd fandango

python setup.py --command-packages=stdeb.command sdist_dsc \
                --upstream-version-suffix +git20170317.1.5a7706 \
                --debian-version 0~bpo9+0~alba+1 \
                --build-depends "help2man" \
                --depends 'python-tango, python-taurus' \
                --suite stretch-backports
```

Fandango depedends on Taurus and PyTango libraries.

help2man is required for the automatic generation of the man pages:


## B3. [Create the local gbp repo with `gbp import-dsc`](recipe.Create_the_local_gbp_repo_with_gbp_import-dsc.md)

The local gbp repository was created with:

```
cd deb_dist
gbp import-dsc fandango_12.3.0-0~bpo9+0~alba+1.dsc /packaging/fandango_deb --pristine-tar
cd /packaging/fandango_deb/
# add the remote
git remote add origin https://git.cells.es/ctpkg/fandango_deb.git
```

## B4. [Create the remote git repo](recipe.Create_the_remote_git_repo.md)

The following command was used to create the fandango_deb repository in 
`ctpkg` group of `git.cells` 

```
create_ctpkg_project fandango_deb "Functional tools for PyTango / Tango Control System" \
                                  "lib, python, ALL, mrosanes, cfalcon" 
```

## B5. [Push to the remote git repo](recipe.Push_to_the_remote_git_repo.md)
```
git push --all
git push --tags
```


## A4. [Edit the Debian Folder Files as needed](recipe.Edit_the_Debian_Folder_Files.md)

The use of the `python setup.py --command-packages=stdeb.command sdist_dsc (...)` 
command before generated a debian dir with some files that were "almost" right,
but some customizations were required (in an iterative process) to pass the 
lintian checks


* [rules](https://git.cells.es/ctpkg/fandango_deb/blob/49646d06be99ff67379da9c73ae6496885ecdb25/debian/rules)
file has been modified to auto-generate manpages.

* [copyright](https://git.cells.es/ctpkg/fandango_deb/blob/49646d06be99ff67379da9c73ae6496885ecdb25/debian/copyright) 
is needed to pass the lintian checks.

* [control](https://git.cells.es/ctpkg/fandango_deb/commit/cd57a8013f1c97393db1ec1c5dfe625a9b880657) file
has been modified, to fix formatting issues.

* [watch](https://git.cells.es/ctpkg/fandango_deb/blob/49646d06be99ff67379da9c73ae6496885ecdb25/debian/watch)
**TODO** In the **future** this file should point to github fandango location.

* [compat](https://git.cells.es/ctpkg/fandango_deb/blob/49646d06be99ff67379da9c73ae6496885ecdb25/debian/compat)

Other files that had to be added in fandango package in order to create the 
manpages are:

* [manpages](https://git.cells.es/ctpkg/fandango_deb/blob/49646d06be99ff67379da9c73ae6496885ecdb25/debian/manpages)
* [help2man](https://git.cells.es/ctpkg/fandango_deb/blob/49646d06be99ff67379da9c73ae6496885ecdb25/debian/help2man)

* [python-fandango.lintian-overrides](https://git.cells.es/ctpkg/fandango_deb/blob/49646d06be99ff67379da9c73ae6496885ecdb25/debian/python-fandango.lintian-overrides)
A python-fandango.lintian-overrides file had to be added to bypass some format 
errors in the man pages that are generated from the "--help" command of the 
upstream scripts.
This was reported to upstream and is considered a workaround until upstream 
fixes it, rather than a proper solution ( overriding the lintian errors shall be
the exception, not the norm)


## A5. [Test the package building](https://git.cells.es/ctpkg/documentation/blob/master/Test_the_package_building.md)


Before testing the build, it is a good idea to update cowbuilder by using:
```
cowbuilder --update
```

For testing the build, several iterations of debugging were needed where:

- One runs `gbp buildpackage`
- Checks the output of the build, paying attention to lintian and piuparts checks
- Edits the files in `/packaging/fandango_deb/debian` and/or contacts upstream to
  do changes in `/packaging/fandango_deb`
- For the  **trully** unavoidable checks that need be bypassed (in this case, 
  man pages format errors, that depend on upstream for fix), upstream is notified
  and a lintian-override created.


## A6. [Update changelog, build the package, tag it, and push](https://git.cells.es/ctpkg/documentation/blob/master/Update_changelog_build_the_package_tag_it_and_push.md)

Next, update changelog using:
```
gbp dch --release --commit --since 306fc343
```

Perform a final test with:
```
gbp buildpackage
```

Finally, when everything is correct, build the final package and tag it by doing:
```
gbp buildpackage --git-tag-only
git push --all
git push --tags

```

## A7. [Upload_artifacts_to_ALBA_repo](https://git.cells.es/ctpkg/documentation/blob/master/Upload_artifacts_to_ALBA_repo.md)

-------------------------------------------------------------------------------

> **Note**:
> You can avoid the most common lintian errors checking this [list](https://git.cells.es/ctpkg/documentation/blob/master/Typical_lintian_errors.md)




