# Clone the packaging repo from git.cells.es

ALBA “backported” packages are managed with a git-based workflow (using [gbp](http://honk.sigxcpu.org/projects/git-buildpackage/manual-html/gbp.intro.html)), which implies that the packaging-related data are kept in git repositories. In the case of ALBA, the packaging repos for ALBA packages are centralized in the https://git.cells.es/ctpkg group. Do not confuse the packaging repo (which contains packaging stuff) with the upstream repo (where the upstream may be managing the original sources). 

The name of the packaging repo for a source package named `<SRC_NAME>` is: 

`https://git.cells.es/ctpkg/<SRC_NAME>_deb`

It can be cloned using:

`gbp clone https://git.cells.es/ctpkg/<SRC_NAME>_deb`
