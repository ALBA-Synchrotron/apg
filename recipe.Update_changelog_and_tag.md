# Update changelog, build the package, tag it, and push


Once you are satisfied with the package configuration and want to really 
release a package, use `gbp dch --release --commit --since <REV>` to update 
the debian/changelog (where `<REV>` corresponds to the git tag or git commit hash,
from which the changelog should be updated, which typically corresponds to the 
last released package).
This will create an entry in the changelog with a release entry and open an 
editor so that you can check it. Check everything and **edit whatever necessary**.


**Pay especial attention to the following**:

- The Debian distribution name should be `stretch-backports`
- The automatically generated version must conform to the [ALBA convention](Appendix_3.md) (**CHECK CAREFULLY!**)
- The first item of the list of changes in the new entry, should be 
`* local package`, to avoid NMU (non-maintainer upload) lintian errors.

Do a final build of the package with:
`gbp buildpackage`

If problems are found review the changelog (since everything was suppossedly ok 
before updating the changelog, we assume that any problems at this stage can 
only be caused by the `changelog` file). Do any necessary changes and ammend the
last commit (use `--ammend` when committing the changes). Then build again ...

When everything is finally correct, tag the package with: 
`gbp buildpackage --git-tag-only`.

Finally you should push your changes. See [Push to the remote git repo ](recipe.Push_to_the_remote_git_repo.md)

