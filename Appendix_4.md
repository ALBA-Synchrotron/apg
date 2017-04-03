# Appendix 4. Conventions for Packaging Git repo name and config.


The following conventions are in place for the ALBA **packaging** git repos:

- They are hosted as projects of the [ctpkg group](https://git.cells.es/ctpkg) in `git.cells.es`

- The packaging repo name (and consequently the gitlab project name) should be `<SRC_NAME>_deb`, where <SRC_NAME> is the source package name and follows the conventions from [Appendix 3](Appendix_3.md). Some examples of packaging repo names are: `tango_deb` or `linux-gpib_deb` (note that `libtango9_deb` would not be valid since `libtango9` is the name of a binary package, not of a source package)

- The project description must first describe the project and then include a separate line beginning with `Tags: ` and followed by a comma-separated list of relevant tags. Tags can be used for grouping packages (e.g. as a substitute of the tree hierarchy of bliss). Suggested tags are:

  - (for type of package) drv, ds, app, lib
  - (for language) c++, python, ...
  - (for ALBA unit) BL01, BL04, ..., IDLab, ...
  - (for maintainer) cfalcon, ...   

For example, a reasonable description (including tags for the tango_deb repo would be:

```
Repo for packaging the Tango Library and tools on Debian
Tags: ds, lib, c++, ALL, cfalcon
```
