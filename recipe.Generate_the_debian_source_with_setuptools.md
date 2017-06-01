# Generate the debian source (with setuptools)

**Important** this recipe requires that the python module uses `setuptools` 
(e.g., it may not work if it uses `distutils` instead of `setuptools`). 
Consider requesting upstream to switch to setuptools, or even to patch it 
yourself before attempting to package it, since it will make things easier. 
If that is not possible, you may need to use the [Workflow D](README.md) instead.

If the python module that you want to package uses setuptools, use:


```
python setup.py --command-packages=stdeb.command sdist_dsc \
            	--upstream-version-suffix +<CVS> \
                --debian-version 0~bpo9+0~alba+1 \
            	--suite stretch-backports \
                --depends '<dep1>, <dep2>, <dep3>, ...'

```

Note: `--upstream-version-suffix` is only needed if the upstream sources are 
from an unreleased commit in a version control system. For a detailed explanation 
of what goes into <CVS>, see [Appendix 3.](Appendix_3.md)

Note: `--depends '<dep1>, <dep2>, <dep3>, ...'` only works if the dependencies
are installed in your PC.

See the [stdeb docs](https://pypi.python.org/pypi/stdeb) for details on usage 
and more command options and examples.

The above command will create a source package in the `./deb_dist/` directory, 
which includes a `.dsc` file that you can use to create the local gbp repo.
