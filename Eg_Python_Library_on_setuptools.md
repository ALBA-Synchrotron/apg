Example: python library package using setuptools
=========================================


For building fandango package Workflow C is followed:


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



Before testing the build, it is a good idea to update cobuilder by using:
`cowbuilder --update`

For testing the build, adding and/or fixing debian files (rules, control, copyright) 
according to lintian an piupart quality check, run iteratively `gbp buildpackage` 
from inside the `/packaging/fandango_deb` folder, correct files, and run again the command.




Finally, when everything is correct, build the final package and tag it by doing:
`gbp buildpackage --git-tag`




