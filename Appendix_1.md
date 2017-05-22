# Appendix 1. Conventions for file path locations

When packaging, each file should be installed on its standard location. 
[The Files section of the Debian Policy Manual](https://www.debian.org/doc/debian-policy/ch-files.html)) 
indicates which are the conventions. 
The [Filesystem Hierarchy Standard](https://www.debian.org/doc/packaging-manuals/fhs/fhs-2.3.html#THEROOTFILESYSTEM) 
is also an useful source of info.

The place for configuring how and where should each file be installed, is the 
`debian/rules` file, and more specifically, the [dh_install](https://manpages.debian.org/stretch/debhelper/dh_install.1.en.html) 
rule and its `debian/<package>.install` files. **Please refer to the closest 
[exemplary package](Appendix_2.md) for hints on how deal with this in your 
specific case**.

The following is a summary of locations for the typical file types found in ALBA
packages, including some specific cases (such as Device Server files) which
may not be clear from the generic documents.

- Configuration files: `/etc/`
- Init scripts: `/etc/init.d/`
- Device Server launchers (C++, Python, ...): `/usr/lib/tango/`
- Device Server Modules: `/usr/share/<DS_NAME>`
- Include files: `/usr/include/`
- Pure Python modules: `/usr/lib/python<XY>/dist-packages`
- Python modules with compiled lib dependencies: `/usr/lib64/python<XY>/dist-packages`
- Libraries: `/usr/lib{64}/`
- (Taurus)GUIs: `/usr/shared/GUI_NAME/`
- desktop files: `/usr/share/applications/`
- Drivers: `/lib`
