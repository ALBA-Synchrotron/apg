# Build shortcuts

(... or things that you should not do but you may end up doing anyway)

**IMPORTANT:** the following shortcuts should only be used if you really understand 
what you are doing and its implications, and you should be aware that normally 
doing the things the right way will save time in the longer term.

## Build outside the chroot

Fixing the errors during build may be desperating.
Often you edit e.g. debian/rules to fix some lintian warning and when you 
re-build the warning is replaced by 3 more warnings and 2 errors...

And what makes it more frustrating is that the fact of using a clean environment
every time makes the build too slow (specially if your package needs to install 
a lot of build-dependencies).

One thing you can do is to do the coarse debugging outside the chroot:
- first install the build-depends in the docker with apt-get 
- then use `pdbuild` to build the package
- maybe [run lintian manually](recipe.Manually_run_quality_checks.md)

**IMPORTANT** Keep in mind that this should only be done to get unstuck, but 
**under any concept** should you upload a package created like this to the 
repos. Instead, once your package builds fine outside the chroot, do *at least* 
[one build the standard way](recipe.Build_package.md) and pay attention to any 
errors, including those from lintian and piuparts


