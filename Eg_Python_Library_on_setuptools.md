Exemplary package: python library package using setuptools (Fandango)
=====================================================================


This was the followed workflow for creating the Fandango package:

## C1. [Get a debpack:alba docker container running and log into it](https://git.cells.es/ctpkg/documentation/blob/master/Get_a_debpack_alba_docker_container_running_and_log_into_it.md)

## C2. [Get the python module upstream source and cd into it](https://git.cells.es/ctpkg/documentation/blob/master/Get_the_python_module_upstream_source_and_cd_into_it.md)


Build and run the debpack container:
<pre>
git clone https://git.cells.es/ctpkg/debpack.git

docker build --rm=true -t debpack:alba debpack/

xhost +local:

docker run -it --privileged=True  --name debpack -h debpack \
           -e "HOST_USER=$USER" -e DISPLAY=$DISPLAY -e QT_X11_NO_MITSHM=1 \
           -v /tmp/.X11-unix:/tmp/.X11-unix debpack:alba bash
</pre>


Inside debpack docker container do:
<pre>
cd /packaging

git clone https://github.com/tango-controls/fandango.git
git checkout develop

cd fandango

python setup.py --command-packages=stdeb.command sdist_dsc \
                --debian-version 0~bpo9+0~alba+1 --suite stretch-backports \
                --depends 'python-tango, python-taurus'

cd deb_dist

gbp import-dsc fandango_12.3.0-0~bpo9+0~alba+1.dsc /packaging/fandango_deb --pristine-tar

cd /packaging/fandango_deb/

git remote add origin https://git.cells.es/ctpkg/fandango_deb.git

create_ctpkg_project fandango_deb "Functional tools for PyTango / Tango Control System" "lib, python, ALL, mrosanes" 

git push --all

git push --tags


</pre>


Add and/or modify copyright, control and rules file.

Also a python-fandango.lintian-overrides file has to be added inside the folder
/packaging/fandango_deb/debian if we have to bypass some lintian error 
(the directive is to try to solve as many of the reported lintian errors
as possible). This file indicates which warnings have to be overriden by lintian. 
In our case, we have added: **manpage-has-errors-from-man** to the file 
python-fandango.lintian-overrides.


Other files that had to be added in fandango package in order to create the 
manpages are:
fandango_deb/debian/manpages
fandango_deb/debian/help2man
And the file fandango_deb/debian/rules has been modified to allow the manpage
creation.
It has been needed to install the application help2man: apt-get install help2man



Before testing the build, it is a good idea to update cowbuilder by using:
<pre>
cowbuilder --update
</pre>

For testing the build, adding and/or fixing debian files (rules, control, copyright) 
according to lintian an piupart quality check, run iteratively 
<pre>
gbp buildpackage
</pre>
from inside the /packaging/fandango_deb folder, correct files, and run again the command,
till you are satisfied: no more error or warnings from lintian appears. If some
of the warnings has to be bypassed, indicate it in python-fandango.lintian-overrides
file, as indicated above.

Next, update changelog using:
<pre>
gbp dch --release --commit --since <commithash>
</pre>

Perform a final test with:
<pre>
gbp buildpackage
</pre>

Finally, when everything is correct, build the final package and tag it by doing:
<pre>
gbp buildpackage --git-tag
</pre>



