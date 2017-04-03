# Update upstream if needed

Note: make sure you are working in your packaging repo root (i.e., do
`cd /packaging/<SRC_NAME>_deb` )

If you are updating an existing package with a new upstream version, you should import the new sources: 

- If upstream uses git, it should be possible to [point the
`upstream` branch of the packaging repo to the upstream repo]
(https://wiki.debian.org/PackagingWithGit#Using_the_upstream_repo-1). 
Note: we haven???t yet validated this workflow at ALBA.
- If the package provides a working [`debian/watch` file]
(https://www.debian.org/doc/manuals/maint-guide/dother.en.html#watch),
it should be possible to use `gbp import-orig --uscan`.
Note: we haven???t yet validated this workflow at ALBA.
- If the above methods are not ok for you, you can always fall back to
using a tarball from upstream (See [Appendix 5](Appendix_5.md)) and issuing 
`gbp import-orig <path/to/tarball> -u <UPSTREAM> --pristine-tar`. 
Keep in mind the following notes:

  - See [Appendix 3](Appendix_3.md) for details about what goes in the `<UPSTREAM>` 
  version string. 
  - See more details on `gbp import-orig` [here]
(http://honk.sigxcpu.org/projects/git-buildpackage/manual-html/gbp.import.html#GBP.IMPORT.NEW.UPSTREAM). 

  - If the original package has +dfsg (debian free software
  guidelines) in its version name,it means that the upstream was 
  modified to fit the [DFSG]
  (https://en.wikipedia.org/wiki/Debian_Free_Software_Guidelines) and you
  may need to do similar changes in your updated upstream (the changelog
  file should list the modifications). After that the upstream branch has
  to be merged into the master branch. 

Debpack is configured to automatically update the changelog after a successful `gbp import-orig` call.

For working with patches to the upstream code (e.g. if you are packaging a code that needs some modification to run on debian, or which needs a modification which is not yet integrated by upstream), see the [`gbp pq` workflow](http://honk.sigxcpu.org/projects/git-buildpackage/manual-html/gbp.patches.html).
