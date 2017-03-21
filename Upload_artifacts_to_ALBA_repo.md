### Upload artifacts to ALBA repo:

In order to make the created packages available to other ALBA machines, you need to upload the package build results to ALBA’s debian9 package repository (currently served from `controls01:/siciliarep/www/testrepo/debian9`). Use the following command:
 
```
scp /packaging/build-area/*.{deb,changes,xz,dsc,gz} \
    sicilia@controls01:/siciliarep/www/testrepo/debian9
```

The results from the build will be created in `../build-area` (e.g., assuming that your local packaging repo was in `/packaging/foo_deb`, the results will be in `/packaging/build-area/`).


The repo directory is automatically re-scanned for new package files and the package indices are updated every 30 min.

If you need to force a re-scan, you can run `ssh sicilia@ct64debian8 /siciliarep/scripts/debian9-update-repo.sh` 