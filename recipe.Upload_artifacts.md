# Upload artifacts to ALBA repo:

The results from the build will be created in `../build-area` (e.g., assuming that your local packaging repo was in `/packaging/foo_deb`, 
the results will be in `/packaging/build-area/`).

In order to make the created packages available to other ALBA machines, you need to upload the package build results to 
[ALBA’s debian9 package repository](http://controls01.cells.es/testrepo/debian9/). 
The easiest is to use the `dput` command with the .changes file generated for your package (it will ask for **sicilia’s passwd**):
 
```
dput controls01 /packaging/build-area/<pkgname>.changes 
```

The repo directory is automatically re-scanned for new package files and the package indices are updated every 30 min. You can force a re-scan with:

```
ssh sicilia@ct64debian8 /siciliarep/scripts/debian9-update-repo.sh
```  

