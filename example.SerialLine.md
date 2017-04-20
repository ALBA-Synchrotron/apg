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

## B4. [Create the remote git repo](recipe.Create_the_remote_git_repo.md)

The following command was used to create the yat_deb repository in 
`ctpkg` group of `git.cells` 

```
create_ctpkg_project serialline_deb "Repo for packaging SerialLine on debian" \
                                    "lib, ds, c++, cfalcon"
```

## B5. [Push to the remote git repo](recipe.Push_to_the_remote_git_repo.md)

## A4. [Edit the Debian Folder Files as needed](recipe.Edit_the_Debian_Folder_Files.md)

## A5. [Build package](recipe.Build_package.md)

## A6. [Update Changelog and tag](recipe.Update_changelog_and_tag.md)

The following commands were executed.


And after check that the `gbp dch` did not introduce any lintian error.

```
gbp buildpackage --git-tag-only 
git push --all
git push --tags

```

## A7. [Upload artifacts](recipe.Upload_artifacts.md)

------------------------------
