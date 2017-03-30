Exemplary package: python library package using setuptools (Fandango)
=====================================================================


This was the followed workflow for creating the Fandango package:

## C1. [Get a debpack:alba docker container running and log into it](https://git.cells.es/ctpkg/documentation/blob/master/Get_a_debpack_alba_docker_container_running_and_log_into_it.md)

Build and run the debpack container:
```
git clone https://git.cells.es/ctpkg/debpack.git
docker build --rm=true -t debpack:alba debpack/
xhost +local:
docker run -it --privileged=True  --name debpack -h debpack \
           -e "HOST_USER=$USER" -e DISPLAY=$DISPLAY -e QT_X11_NO_MITSHM=1 \
           -v /tmp/.X11-unix:/tmp/.X11-unix debpack:alba bash
```

## C2. [Get the python module upstream source and cd into it](https://git.cells.es/ctpkg/documentation/blob/master/Get_the_python_module_upstream_source_and_cd_into_it.md)

Fandango package is present in github.

Inside debpack docker container do:
```
cd /packaging
git clone https://github.com/tango-controls/fandango.git
git checkout develop
```

## C3. [Generate the debian source (with python setup.py sdist_dsc ... )](https://git.cells.es/ctpkg/documentation/blob/master/Generate_the_debian_source.md)


The fandango debian sources were generated with:


```
cd fandango

python setup.py --command-packages=stdeb.command sdist_dsc \
                --debian-version 0~bpo9+0~alba+1 --suite stretch-backports \
                --depends 'python-tango, python-taurus'
```

Fandango depedends on Taurus and PyTango libraries.




## B3. [Create the local gbp repo with `gbp import-dsc`](https://git.cells.es/ctpkg/documentation/blob/master/Create_the_local_gbp_repo_with_gbp_import-dsc.md)

The local gbp repository was created with:

```
cd deb_dist
gbp import-dsc fandango_12.3.0-0~bpo9+0~alba+1.dsc /packaging/fandango_deb --pristine-tar
cd /packaging/fandango_deb/
# add the remote
git remote add origin https://git.cells.es/ctpkg/fandango_deb.git
```

## B4. [Create the remote git repo](https://git.cells.es/ctpkg/documentation/blob/master/Create_the_remote_git_repo.md)

The following command was used to create the fandango_deb repository in 
`ctpkg` group of `git.cells` 

```
create_ctpkg_project fandango_deb "Functional tools for PyTango / Tango Control System" \
                                  "lib, python, ALL, mrosanes, cfalcon" 
```

## B5. [Push to the remote git repo](https://git.cells.es/ctpkg/documentation/blob/master/Push_to_the_remote_git_repo.md)
```
git push --all
git push --tags
```


## A4. [Edit the Debian Folder Files as needed](https://git.cells.es/ctpkg/documentation/blob/master/Edit_the_Debian_Folder_Files_as_needed.md)

Add and/or modify copyright, control and rules file.

Also a python-fandango.lintian-overrides file has to be added inside the folder
/packaging/fandango_deb/debian if we have to bypass some lintian error 
(the directive is to try to solve as many of the reported lintian errors
as possible). This file indicates which warnings have to be overriden by lintian. 
In our case, we have added: **manpage-has-errors-from-man** to the file 
python-fandango.lintian-overrides.


Other files that had to be added in fandango package in order to create the 
manpages are:
fandango_deb/debian/manpages
fandango_deb/debian/help2man
And the file fandango_deb/debian/rules has been modified to allow the manpage
creation.


## A5. [Test the package building](https://git.cells.es/ctpkg/documentation/blob/master/Test_the_package_building.md)


Before testing the build, it is a good idea to update cowbuilder by using:
```
cowbuilder --update
```

For testing the build, adding and/or fixing debian files (rules, control, copyright) 
according to lintian an piupart quality check, run iteratively 
```
gbp buildpackage
```
from inside the /packaging/fandango_deb folder, correct files, and run again the command,
till you are satisfied: no more error or warnings from lintian appears. If some
of the warnings has to be bypassed, indicate it in python-fandango.lintian-overrides
file, as indicated above.



## A6. [Update changelog, build the package, tag it, and push](https://git.cells.es/ctpkg/documentation/blob/master/Update_changelog_build_the_package_tag_it_and_push.md)

Next, update changelog using:
```
gbp dch --release --commit --since <commithash>
```

Perform a final test with:
```
gbp buildpackage
```

Finally, when everything is correct, build the final package and tag it by doing:
```
gbp buildpackage --git-tag
git push --all
git push --tags

```

## A7. [Upload_artifacts_to_ALBA_repo](https://git.cells.es/ctpkg/documentation/blob/master/Upload_artifacts_to_ALBA_repo.md)

-------------------------------------------------------------------------------

> **Note**:
> You can avoid the most common lintian errors checking this [list](https://git.cells.es/ctpkg/documentation/blob/master/Typical_lintian_errors.md)




