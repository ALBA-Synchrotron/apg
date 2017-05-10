# ALBA Packaging Guide

## Introduction

There are many ways of creating debian packages and too many resources on the 
internet. Due to the dynamic nature of the packaging rules, some docs may be 
contradictory, so it is worth focusing on the following two authoritative 
sources for **generic Debian** packaging:

- [The Debian Policy Manual](https://www.debian.org/doc/debian-policy/)
- [The Debian New Maintainers Guide](https://www.debian.org/doc/manuals/maint-guide/index.en.html)

But still, those docs offer too much choice, so we wrote this *ALBA Packaging 
Guide* to describe the specific workflows and tools that have been chosen for 
packaging for ALBA.

If some instruction in this document contradicts what you read in a more generic
document, please contact someone from CTGenSoft to check if this is a mistake on
our procedures or a deliberate choice (also see the [CONTRIBUTING guide](CONTRIBUTING.md))

## Examples

Also, a set of [practical examples](Appendix_2.md) have been documented. These 
are intended as very specific implementation examples of the *ALBA Packaging 
Guide* workflows, and should be used **together with the guide**.

## Glossary

Note: in this guide we will use terms such as *upstream*, or 
*backport*, etc that have some specific meaning in the context of packaging. 
See the [glossary](glossary.md) for definitions


## Workflows

When packaging for ALBA, you will likely be in one of the following cases :


### Workflow A - Maintaining an existing alba package (i.e. for which a packaging git repo exists):

1. [Get the debpack Docker](recipe.Get_the_debpack_Docker.md)
2. [Clone the packaging repo](recipe.Clone_the_packaging_repo.md)
3. [Update upstream](recipe.Update_upstream.md)
4. [Edit the Debian Files](recipe.Edit_debian_files.md)
5. [Build package](recipe.Build_package.md)
6. [Update Changelog and tag](recipe.Update_changelog_and_tag.md)
7. [Push to the remote git repo](recipe.Push_to_the_remote_git_repo.md)
8. [Upload artifacts](recipe.Upload_artifacts.md)

### Workflow B - Re-packaging (backporting) an existing debian package that does not yet exist in the Alba repo

1. [Get the debpack Docker](recipe.Get_the_debpack_Docker.md)
2. [Download the debian source package](recipe.Download_a_Debian_source_package.md)
3. [Create the local gbp repo with `gbp import-dsc`](recipe.Create_the_local_gbp_repo_with_gbp_import-dsc.md)
4. [Create the remote git repo](recipe.Create_the_remote_git_repo.md)
5. Proceed as in Workflow A-4 and next

### Workflow C - Packaging a setuptools-based python code for which no alba or debian package already exist.

1. [Get the debpack Docker](recipe.Get_the_debpack_Docker.md)
2. [Get the python module upstream source and cd into it](recipe.Get_the_python_module_upstream_source.md)
3. [Generate the debian source with setuptools](recipe.Generate_the_debian_source_with_setuptools.md)
4. Proceed as in Workflow B-3 and next

### Workflow D - Packaging non-setuptools based code (e.g. C++ code) for which no alba or debian package already exist.

1. [Get the debpack Docker](recipe.Get_the_debpack_Docker.md)
2. [Get the source tarball](recipe.Get_the_source_tarball.md)
3. [Create local packaging git repo with dh_make](recipe.Create_local_packaging_git_repo_with_dh_make.md)
4. Proceed as in Workflow B-4 and next

