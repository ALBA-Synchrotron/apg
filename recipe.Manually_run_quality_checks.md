# Manually run quality checks for packages

Lintian and piuparts tools **must** be run after building the package. 
You can do it as follows:

- lintian: 
``` 
cd /packaging/<package>_deb
lintian -i -I 
``` 

- piuparts: 
```
cd /packaging/<package>_deb
piuparts -d strech -m http://httpredir.debian.org/debian --extra-repo "deb [ trusted=yes ] http://controls01.cells.es/testrepo debian9/" <PACKAGE>.changes
```

