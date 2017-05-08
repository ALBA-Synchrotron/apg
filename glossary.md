# Glossary 

Before starting the packaging you need to know a series of concepts that will 
be used in this guide.

- [upstream](https://en.wikipedia.org/wiki/Upstream_(software_development)): 
refers to the original author/maintainer of the code (or the original code 
itself).

- [source package](https://wiki.debian.org/Packaging/SourcePackage) 
The upstream tar.gz + a .dsc file + a debian.tar.xz file.

- [binary package](https://wiki.debian.org/Packaging/BinaryPackage) 
The .deb file(s) resulting from *building* a source package.

- [backports](https://wiki.debian.org/Backports): In the official Debian 
packaging workflow, the packages are built only for Debian Unstable, and from 
there they would slowly migrate to Testing and then Stable distros. Backports 
are a shortcut to re-package selected packages from Testing or Unstable directly
into Stable without waiting (and without guaranties). **Since in ALBA we package
directly for Stable, we are in a sense always doing “backports”** even if 
sometimes we “backport” something that does not actually exist in Unstable.

- [debian folder]( https://www.debian.org/doc/manuals/maint-guide/dreq.en.html):
a directory containing all the metadata required for packaging. It should 
contain, at least, the following files: `control`, `copyright`, `changelog` 
and `rules` (other files may also be present).

- [cowbuilder](https://wiki.debian.org/cowbuilder): It is a wrapper for pbuilder 
to build packages without the unnecessary compress/uncompress step, in fact using COW (Copy-On-write).
- [gbp](http://honk.sigxcpu.org/projects/git-buildpackage/manual-html/gbp.building.html ):
Tool for building packages from the Git repository.
- The quality check tools are [lintian](https://lintian.debian.org/manual/) for finding  bugs 
and policy violations and [piupart ](https://piuparts.debian.org/) for testing the generated `.deb` packages.
