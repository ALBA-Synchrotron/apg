# Upload artifacts to ALBA repo:

The results from the build will be created in `../build-area` (e.g., assuming that your local packaging repo was in `/packaging/foo_deb`, 
the results will be in `/packaging/build-area/`).

In order to make the created packages available to other ALBA machines, you need to upload the package build results to any of the ALBA 
repositories:
* [deb9_production](http://controls01.cells.es/testrepo/debian9/)
* [deb9_staging]((http://controls01.cells.es/testrepo/debian9_staging/))

The easiest is to use the `upload <repo_name>` command in your local packaging repo (if everything is ok, 
it will ask you for **sicilia’s passwd**).

The `upload` needs a repository name (If you don't give any argument it will show you the help):
```
Usage: give a valid repo
e.g. upload deb9_staging"
e.g. upload deb9_production"
```
The `upload` command executes a `lintian` check (if there is any lintian error the upload will be aborted).
if the check is passed, it executes the `dput` command for the given repository. For finishing the `upload`
command will update the ALBA repositories.
