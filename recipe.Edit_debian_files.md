# Edit the Debian Folder Files as needed

This is the most complex step (especially when you are creating the package for the first time). 
We recommend using a [reference package from the Appendix  2](Appendix_2.md). 
The `debian` folder must contain at least the following files (for a deeper understanding of their purpose and syntax, follow the provided links to the maint-guide): 
 - [control](https://www.debian.org/doc/manuals/maint-guide/dreq.en.html#control): this file contains basic info about the package (descriptions, dependencies, classification, etc.). It also defines which binary packages will be created from this debian source package. For our packages is mandatory to set the latest ancient-standards-version (**current 3.9.8**).

 - [copyright](https://www.debian.org/doc/manuals/maint-guide/dreq.en.html#copyright): this file lists which license applies to each file in the package (both upstream and debian files). Non dfsg (dfsg standing for Debian Free Software Guidelines) code files should be listed here.
 - [changelog](https://www.debian.org/doc/manuals/maint-guide/dreq.en.html#changelog): this is the **packaging** changelog. Do **not** include *upstream* changes info. This file is parsed for getting the version info when building the package so its syntax is quite strict. Better edit it with the `gbp dch` command only (see the “Update changelog, build the package, tag it, and push” recipe)
 - [rules](https://www.debian.org/doc/manuals/maint-guide/dreq.en.html#rules): this is a Makefile that describes how to actually build the package. Historically, there have been different ways on how to create the `rules` file. At ALBA we use the “debhelper v9” conventions. You may see older docs recommending solutions that do not match this. Please do not follow those for any new package.
 - The `debian` dir may also contain other files. See them [here](https://www.debian.org/doc/manuals/maint-guide/dother.en.html). Typically these would be used for fine-tuning what is done by the `rules` makefile.

As already mentioned, at ALBA we use a [gbp-based workflow](http://honk.sigxcpu.org/projects/git-buildpackage/manual-html/gbp.intro.html#GBP.WORKFLOW). This has the following implications:

- All relevant changes to files in the debian dir should be committed (use `git add` and `git commit` as usual for this). The commit messages will be used to automatically update the debian/changelog file later on.

- Deciding the right place for installing a given file is one of the most common sources of doubts. Check Appendix 1 (Conventions for file path locations), and the Debian Policy Manual (e.g., the [Files section](https://www.debian.org/doc/debian-policy/ch-files.html)). Also, understanding the [Filesystem Hierarchy Standard](https://www.debian.org/doc/packaging-manuals/fhs/fhs-2.3.html#THEROOTFILESYSTEM) may be useful.

- May interest you how to auto generate man pages (base on help2man). See this [recipe](https://git.cells.es/ctpkg/documentation/blob/master/Auto_generation_of_man_pages.md)
