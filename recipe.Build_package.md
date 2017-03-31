# Test the package building 

The debpack:alba docker image is configured to use [cowbuilder](https://wiki.debian.org/cowbuilder) for building in a clean chroot and to build the results in `../build-area`). See [this](http://honk.sigxcpu.org/projects/git-buildpackage/manual-html/gbp.building.html) for more details.
Be sure that your chroot is up to date by running:
`cowbuilder --update`

It will be needed to test many times the package building, in order to fix the errors found by lintian and piuparts during the process of building. 
If you are applying **workflow A: Maintaining an existing alba package**, you will need to update the changelog with: `gbp dch --release --commit`.

In order to test the package creation, run `gbp buildpackage`. 
This command tries to build the package and performs a quality check. As output it gives a list of quality errors (given by lintian and piuparts) that must be fixed. This command shall be executed iteratively till the quality check is satisfied, before going to next step.

While (for now) we are not aborting builds on quality check errors, no package should be uploaded for which lintian shows an Error or Warning. The **Debian Policy** manual should clarify how to solve most issues reported by the quality checking tools. Note that you can also run the quality checkers manually  (See the ”Manually run quality checks for packages” recipe)
