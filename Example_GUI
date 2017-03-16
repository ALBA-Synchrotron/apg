# Exemplary package: GUI

The chosen exemplary package for GUI is the `linacgui`.
You can get the source package using `apt-get source linacgui`

You have to take in mind that GUI packages even though they are written in python,
they must be installed in `/usr/share/<package>`. 

If you follow the packaging guide you should modify/create the 
following [files](https://git.cells.es/ctpkg/linacgui_deb/commit/ab83d2cecb94dc5a6cc9b0ee237ff58023ddd949#9c96da0e9f91d7d8937b69b524702c106258f0d1) for your package:

- changelog
  Remember that the changelog has to include packaging information and 
  never includes  upstream features or fixes. 
  The version in this file is one of the most important parameter.
  See Appendix 3 to compose the version. 

- control
This file defines the information and dependencies of the 
 upstream and the binary package(s). 
 
 Probably your package requires these build dependencies:
 ```
  Build-Depends: dh-python,
                   python-setuptools (>= 0.6b3),
                   python-all (>= 2.6.6-3),
                   debhelper (>= 9),
                   dh-exec,
                   help2man,
                   dh-python
 ``` 
Is a mandatory to set the ancient-standards-version to  3.9.8. 
 
- copyright
This file defines the licenses used by the upstream and debian files.
 
- < package >.install
This file is used to define the extra installation files, such us desktop files
and for moving and renaming the launchers. It is needed since the python
modules are not in the `$PYTHONPATH`. 

  Your < package >.install file should be like this: 
  ```
    #!/usr/bin/dh-exec
    debian/linacgui/usr/bin/ctli => /usr/share/linacgui/ctli_
    debian/linacgui/usr/bin/ctlisetup => /usr/share/linacgui/ctlisetup_
    distribute/ctli.desktop /usr/share/applications
  ``` 
We recommend rename the launcher from < name > to < name >_ to avoid possible collisions with 
the existing modules. You can see an example in the second and the third line.

 > **Note:**
 > This file needs execution permissions when this shebang, `#!/usr/bin/dh-exec`, 
 > is added . Moreover to add `dh-exec` as Build-Depends in the  `control` file.

- < package >.links
This files is used to define sym-links. We need it because in the `install` file we moved the 
launchers from `/usr/bin` to `/usr/share/< package >/< launcher_name >_` and we have 
to create a link for them in `/usr/bin`.

  Your < package >.links file should be like this: 
  ```
  usr/share/ctli/ctli_ usr/bin/ctli
  usr/share/ctli/ctlisetup_ usr/bin/ctlisetup
  ``` 

- < package >.lintian-overrides
File to skip lintian checkings. It has to be used to skip **only** upstream checkings.
 The skipped messages  have to be reported to upstream maintainer in order to fix them.

- < package >.postinstall
If your GUI is python you need to generate the *.pyc files as post install action.

 Your < package >.postinstall file should be like this: 
 ```
 #!/bin/sh
 python -m compileall /usr/share/linacgui/ctl
 #DEBHELPER#
 exit 0
 ```

- < package >.prerm
If you GUI is python, the package must remove the generated *.pyc files
before uninstall action.

 Your < package >.prerm file should be like this:  
 ```
 #!/bin/sh
 python -m compileall /usr/share/linacgui/ctl
 #DEBHELPER#
 exit 0
 ```

- rules
Replace the existing exports by this:
`export PYBUILD_INSTALL_ARGS=--install-lib=/usr/share/<package> --no-compile`

- watch
**TODO** In the **future** this file should point to git.cells.es

> **Note**: 
> You can avoid the most common lintian errors checking this [list](https://git.cells.es/ctpkg/documentation/blob/master/Typical_lintian_errors.md)
