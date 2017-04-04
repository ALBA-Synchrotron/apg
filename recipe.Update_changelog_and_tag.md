# Update changelog, build the package, tag it, and push


Once you are satisfied with the package configuration and want to really 
release a package, use `gbp dch --release --commit --since <REV>` to update 
the debian/changelog (where <REV> corresponds to the git tag or git commit hash,
from which the changelog should be updated, which typically corresponds to the 
last released package).
This will create an entry in the changelog with a release entry and open an 
editor so that you can check it. Check everything and **edit whatever necessary**.


**Pay especial attention to the following**:

- The Debian distribution name should be `stretch-backports`
- The automatically generated version must conform to the [ALBA convention](Appendix_3.md)) 
- The first item of the list of changes in the new entry, should be `* local package`, to avoid NMU (non-maintainer upload) lintian errors.

Apply a final test by running:
`gbp buildpackage`

If problems are found with the changelog after this build, review the
changelog and run again `gbp buildpackage`.

When everything is correct, build the final package and tag it with: 
`gbp buildpackage --git-tag`.

Finally you should push your changes. See [Push to the remote git repo ](recipe.Push_to_the_remote_git_repo.md)
