# Manually run quality checks for packages

Lintian and piuparts tools **must** be run after building the package. 

## Lintian

Lintian dissects Debian packages and tries to find bugs and policy violations. It contains automated checks for many 
aspects of Debian policy as well as some checks for common errors.

You can launch it:
```
cd /packaging/<package>_deb
lintian -iI --suppress-tags-from-file=/root/lintian-tags.txt
```

At least all lintian error messages have to be fixed/overrided.

## Piuparts

Piuparts is a tool for testing that .deb packages can be installed, upgraded, and removed without problems. piuparts is 
short for "package installation, upgrading and removal testing suite" and is a variant of something suggested 
by Tollef Fog Heen. 

You can launch it:
```
cd /packaging/<package>_deb
CHANGES_FILE=../build-area/`dpkg-parsechangelog -S Source`_`dpkg-parsechangelog -S Version`*.changes
piuparts -d stretch -m http://httpredir.debian.org/debian --extra-repo "deb [ trusted=yes ] http://controls01.cells.es/testrepo debian9/" $CHANGES_FILE
```

