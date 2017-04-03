# Manually run quality checks for packages

Lintian and piuparts tools are automatically run when building the package, 
but you may also want to run them manually for debugging. You can do it as 
follows:

- lintian: 
``` 
lintian -i -I <PACKAGE>.dsc
``` 

- piuparts: 
```
piuparts -d strech -m http://httpredir.debian.org/debian --extra-repo "deb [ trusted=yes ] http://controls01.cells.es/testrepo debian9/" <PACKAGE>.changes
```

