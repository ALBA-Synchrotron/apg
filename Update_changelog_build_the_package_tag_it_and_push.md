### Update changelog, build the package, tag it, and push


Once you are satisfied with the package configuration and want to really release a package, use `gbp dch --release --commit --since <REV>` to update the debian/changelog (where <REV> corresponds to the git tag or git commit hash, from which the changelog should be updated).
This will create an entry in the changelog with a release entry and open an editor so that you can check it. Check everything and edit whatever necessary. **Pay especial attention to the Debian distribution name (it should be “stretch-backports”) and to ensure that the automatically generated version string conforms to the ALBA packaging naming convention (see Appendix 3).** 

Apply a final test by running:
`gbp buildpackage`

If problems are found with the changelog after this build, review the
changelog and run again `gbp buildpackage`.

When everything is correct, build the final package and tag it with: 
`gbp buildpackage --git-tag`.

Finally you should push your changes to the remote repo with: `git push && git push --tags`