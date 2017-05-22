# Edit the Debian Folder Files as needed

This is the most complex step (especially when you are creating the package for 
the first time). 

You are likely to do this step iteratively: 
first editing some files, comitting the changes with `git add` and `git commit`,
trying to [build the package](recipe.Build_package.md),
and getting back to editting more files to solve the errors/warnings found 
during the build. You can see more details in the docs for the [gbp workflow]
(http://honk.sigxcpu.org/projects/git-buildpackage/manual-html/gbp.intro.html#GBP.WORKFLOW)

**IMPORTANT:** We strongly recommend looking at a [reference package from the Appendix  2](Appendix_2.md) 
as an example. 

Go into the `debian` directory:
```
cd /packaging/<SRC_NAME>_deb/debian
```

This directory must contain at least the following files (the links point 
to detailed info on each file from the maint-guide): 

- [control](https://www.debian.org/doc/manuals/maint-guide/dreq.en.html#control): 
this file contains basic info about the package (descriptions, dependencies, 
classification, etc.). It also defines which binary packages will be created 
from this debian source package. For our packages is mandatory to set the latest
standards version (**currently, 3.9.8**).

- [copyright](https://www.debian.org/doc/manuals/maint-guide/dreq.en.html#copyright): 
this file lists which license applies to each file in the package (both upstream
and debian files). Non-DFSG (DFSG standing for Debian Free Software Guidelines) 
code files should also be listed here. **You can find a template in `/templates` path of your
debpack container**.

- [changelog](https://www.debian.org/doc/manuals/maint-guide/dreq.en.html#changelog): 
this is the **packaging** changelog. Do **not** include **upstream** changes info.
This file is parsed for getting the version info when building the package so 
its syntax is quite strict. Generally **this is the last file we edit** after 
everything else has been done, and we edit it using the `gbp dch` command 
**only** (see the [Update changelog](recipe.Update_changelog_and_tag.md) recipe).

- [rules](https://www.debian.org/doc/manuals/maint-guide/dreq.en.html#rules): 
this is a Makefile that describes how to actually build the package. 
Historically, there have been different ways on how to create the `rules` file. 
At ALBA we use the ***debhelper v9*** conventions. You may see older docs 
recommending solutions that do not match this. Please do not follow those for 
any new package.

- The `debian` dir may also contain other files. See them [here](https://www.debian.org/doc/manuals/maint-guide/dother.en.html). 
Typically these would be used for fine-tuning what is done by the `rules` 
makefile.

**Notes:**

- Deciding the right place for installing a given file is one of the most common
sources of doubts. Check [Appendix 1 (Conventions for file path locations)](Appendix_1.md).
The place for configuring how and where should each file be installed, is the 
`debian/rules` file, and more specifically, the "dh_install" rule and the 
`debian/<package>.install` files. **Please refer to the closest [exemplary 
package](Appendix_2.md) for hints on how deal with this in your specific case**. 

- You may also be interested in reading [how to auto-generate man pages](recipe.Autogenerating_manpages.md)

- Consider adding a [working watch file](https://wiki.debian.org/debian/watch). 
(For upstream code in git.cells.es, the upstream project must be public, and an 
example watch file can be found [here](https://git.cells.es/ctpkg/linacgui_deb/blob/46ffecf544cd5381ecb799e7d32c1e0126164dc8/debian/watch) )
