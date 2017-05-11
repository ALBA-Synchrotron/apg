# Test the package building 

**IMPORTANT**:

- The debpack:alba docker image is configured to use [cowbuilder](https://wiki.debian.org/cowbuilder) 
for building in a clean chroot and to build the results in `../build-area`). 
See [this](http://honk.sigxcpu.org/projects/git-buildpackage/manual-html/gbp.building.html) 
for more details.

- The chroot repository info may not be up-to-date (**which would cause 
errors when installing build-dependencies** during the the build process). 
You can update it with: `cowbuilder --update`

- The build process triggers calls to lintian and piuparts for quality checks. 
They will likely output several warnings/errors that must be fixed (by going 
back to [editing the debian files](recipe.Edit_debian_files.md) and committing 
the changes. 

- The build and the quality checks are done on a chroot which is automatically 
removed when the build exits. This is inconvenient for debugging (e.g. you do not 
have access to the logs). (**TODO:** find a workaround for this)

- While (for now) we are not aborting builds on quality check errors, no package
should be uploaded to the repos if it shows an Error or Warning. 
The **Debian Policy** manual should clarify how to solve most issues reported by
the quality checking tools. Note that you can also [run the quality checkers 
manually](recipe.Manually_run_quality_checks.md).

- The build command has to be executed from the following directory:
```
cd /packaging/<SRC_NAME>_deb
```

During the packaging of a code, you will need to test the build several times,
in order to iteratively fix the build and quality check errors.

For building a package, use: **`gbp buildpackage`**

--------

If you are stuck with problems during the build, you may read [this](recipe.Build_shortcuts.md) 
(at your own risk!)

