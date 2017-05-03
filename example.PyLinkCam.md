# Exemplary package: Python DS (PyLinkam)

This was the followed workflow for creating the pylinkam DS package:

## C1. [Get the debpack Docker](recipe.Get_the_debpack_Docker.md)

## C2. [Get the python module upstream source and cd into it](recipe.Get_the_python_module_upstream_source.md)

PyLinkam DS is a SVN project hosted in sourceforge. The upstream was gotten
with this command:
```
svn co http://svn.code.sf.net/p/tango-ds/code/DeviceClasses/SampleEnvironment/PyLinkam/trunk PyLinkam
```

## C3. [Generate the debian source with setuptools](recipe.Generate_the_debian_source_with_setuptools.md)

PyLinkam project is based on `setuptools`, so the debian source were
generated with the followed command:
```

python setup.py --command-packages=stdeb.command sdist_dsc \
                --package tangods-pylinkam --upstream-version-suffix +svn~r23606\
                --debian-version 0~bpo9+0~alba+1 --suite stretch-backports \
                --build-depends "dh-exec, help2man" \
                --depends 'python-tango, python-numpy'
``` 

## B3. [Create the local gbp repo with `gbp import-dsc`](recipe.Create_the_local_gbp_repo_with_gbp_import-dsc.md)

The local gbp repo was created with these commands:

```
gbp import-dsc pylinkam_2.0+svn~r23606-0~bpo9+0~alba+1.dsc /packaging/pylinkam_deb --pristine-tar
cd /packaging/pylinkam_deb
git remote add origin https://git.cells.es/ctpkg/pylinkam_deb.git
```

## B4. [Create the remote git repo](recipe.Create_the_remote_git_repo.md)

The following command was used to create the pylinkam_deb repository in 
`ctpkg` group of `git.cells` 

```
create_ctpkg_project pylinkam_deb "Repo for packaging PyLinkam DS on debian" \
                                  "DS, python, cfalcon"
```

## B5. [Push to the remote git repo](recipe.Push_to_the_remote_git_repo.md)

## A4. [Edit the Debian Folder Files as needed](recipe.Edit_the_Debian_Folder_Files.md)

This [commit](https://git.cells.es/ctpkg/pylinkam_deb/commit/7825d24acc9d9c98d451cea26a1231f69352278b) does
the necesary changes to build the project.
* [control](https://git.cells.es/ctpkg/pylinkam_deb/blob/8e48e8ae61f99cb37589703fe422add5d6176f3e/debian/control). Was modified to edit the descriptions.
* [copyright](https://git.cells.es/ctpkg/pylinkam_deb/blob/8e48e8ae61f99cb37589703fe422add5d6176f3e/debian/copyright). Add a basic copyright file.
* [tangods-pylinkam.install](https://git.cells.es/ctpkg/pylinkam_deb/blob/8e48e8ae61f99cb37589703fe422add5d6176f3e/debian/tangods-pylinkam.install) This file renames the launcher.
<br/>**Note :** Since we use `dh-exec`-extended syntax in`tangods-pylinkam.install` we must give it
execution permissions (`chmod 777 debian/tangods-pylinkam.install`).
<br/>See its [man page](https://manned.org/dh-exec-install.1) for more details.
* [tangods-pylinkam.links](https://git.cells.es/ctpkg/pylinkam_deb/blob/8e48e8ae61f99cb37589703fe422add5d6176f3e/debian/tangods-pylinkam.links) 
This file is used to create a sym-link for the DS launcher
in `/usr/lib/tango` following the [Appendix 1](Appendix_1.md) convention.
* [rules](https://git.cells.es/ctpkg/pylinkam_deb/blob/8e48e8ae61f99cb37589703fe422add5d6176f3e/debian/rules). 
Since this is for a DS package, the python module should not be installed in the
default python path but in `/usr/share/tangods-pylinkam`. The rules file was 
modified to set the proper configuration of `dh_auto_install` accordingly by adding:
`export PYBUILD_INSTALL_ARGS=--install-lib=/usr/share/tangods-pylinkam --no-compile `.
Other modifications to the rules file were done later on to fix errors reported 
by lintian (see next step)

Even though lintian does not trigger any warning, it is a good practice to add 
`postinstall` and `prerm` scripts, as you can see in this [commit](https://git.cells.es/ctpkg/pylinkam_deb/commit/efbabe36189ffd8e59be90ca3c3fcd2a01169837).
These script are in charge of cleaning the system.

## A5. [Build package](recipe.Build_package.md)

During the building tests (using `gbp buildpackage`) some lintian warnings appeared.
```
W: tangods-pylinkam: executable-not-elf-or-script usr/share/tangods-pylinkam/PyLinkam/THMS_600.pump
W: tangods-pylinkam: executable-not-elf-or-script usr/share/tangods-pylinkam/PyLinkam/VERSION
```
These lintian warnings were fixed adding an `override_dh_fixperms` in the rules 
file in this [commit](https://git.cells.es/ctpkg/pylinkam_deb/commit/9aade0ce7f718b4041a96a916566fc07ce42a6ce).
```
override_dh_fixperms:
	chmod 0644 debian/tangods-pylinkam/usr/share/tangods-pylinkam/PyLinkam/THMS_600.pump
	chmod 0644 debian/tangods-pylinkam/usr/share/tangods-pylinkam/PyLinkam/VERSION
	dh_fixperms
```

In order to avoid the lintian warning `binary-without-manpage`, this code was added in the debian rules
in this [commit](https://git.cells.es/ctpkg/pylinkam_deb/commit/c886ba5c526a0e5b6e73b2d51b76a4a104e6cbcf).
```
export PYTHONPATH=$(CURDIR)/debian/tangods-pylinkam/usr/share/tangods-pylinkam/
MANS = PyLinkam.1

override_dh_clean:
	dh_clean $(MANS)

%.1:
	help2man -n '$* DS' --no-info --no-discard-stderr --include debian/help2man -o $(CURDIR)/debian/$@ ./debian/tangods-pylinkam/usr/bin/$*

override_dh_installman: $(MANS)
	dh_installman
``` 

Also, the following files were added to the debian folder: 
- [help2man](https://git.cells.es/ctpkg/pylinkam_deb/blob/8e48e8ae61f99cb37589703fe422add5d6176f3e/debian/help2man),
- [tangods-pylinkam.manpages](https://git.cells.es/ctpkg/pylinkam_deb/blob/8e48e8ae61f99cb37589703fe422add5d6176f3e/debian/tangods-pylinkam.manpages)
- [tangods-pylinkam.lintian-overrides](https://git.cells.es/ctpkg/pylinkam_deb/blob/8e48e8ae61f99cb37589703fe422add5d6176f3e/debian/tangods-pylinkam.lintian-overrides)

The 'tangods-pylinkam.lintian-overrides' has been added to avoid this warning: 
`W: tangods-pylinkam: manpage-has-errors-from-man usr/share/man/man1/PyLinkam.1.gz 28: warning [p 1, 6.2i]: cannot adjust line`
This is an error in the man pages that are generated from the "--help" command 
of the upstream scripts. This was reported to upstream and is considered a 
workaround until upstream fixes it, rather than a proper solution ( overriding 
the lintian errors shall be the exception, not the norm)

## A6. [Update Changelog and tag](recipe.Update_changelog_and_tag.md)

The following commands were executed.

```
gbp dch --release --commit --since 812dcf7
gbp buildpackage
```

And after checking that the `gbp dch` did not introduce any new lintian error, 
it was pushed with:

```
gbp buildpackage --git-tag-only 
git push --all
git push --tags

```

## A7. [Upload artifacts](recipe.Upload_artifacts.md)
