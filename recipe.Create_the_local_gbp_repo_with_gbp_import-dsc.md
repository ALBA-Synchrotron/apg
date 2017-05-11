# Create the local gbp repo with `gbp import-dsc`
 
You can create a local gbp repo by importing a .dsc file. Apply the following 
command from the folder where the `.dsc` file is located:

```
cd /packaging
gbp import-dsc <dscfile> /packaging/<SRC_NAME>_deb --pristine-tar
cd /packaging/<SRC_NAME>_deb
git remote add origin https://git.cells.es/ctpkg/<SRC_NAME>_deb.git
```

Notes: 
- in order to be coherent with the [remote git naming convention](Appendix_4.md), 
we explicitly name the target `<SRC_NAME>_deb`  
- we add the URL for the remote packaging repo as `origin`. 
- Do not worry if the remote repo does not yet exist (see the [create the 
remote git repo](recipe.Create_the_remote_git_repo.md) recipe)
