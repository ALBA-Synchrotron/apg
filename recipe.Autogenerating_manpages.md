# Auto-generation of man pages (using help2man)

This recipe shows how to auto-generate man pages for applications base on help2man. This process requires modify and create files in the debian folder.

The control file three new build dependencies have to be added.
`xauth, xvfb, help2man`.
The rules file two overrides are needed `override_dh_clean` and  `override_dh_installman`. The first one is used to remove the auto-generated man pages and the second one is for creating them.

```
export PYTHONPATH=$(CURDIR)/debian/<package python modules>
MANS = <LAUNCHER1>.1 <LAUNCHER2>.1

override_dh_clean:
    	dh_clean $(MANS)

%.1:
    	xvfb-run -a help2man -n '$* <TEXT e.g. GUI, Launcher>' \
                           --no-info \
                           --include debian/help2man \
                           -o $(CURDIR)/debian/$@ \
                           ./debian/<package>/usr/bin/$*



override_dh_installman: $(MANS)
    	dh_installman

``` 
The <package>.manpages file has to be created. This file has the list of man pages to be installed.
e.g.
```
debian/<LAUNCHER1>.1 
debian/<LAUNCHER2>.1
```

The help2man file has to be created. It is used to enrich the man pages. We used to define authors information. This is our template.

```
[authors]
.B <Package name>
was primarily developed at ALBA.
.br
.br
For a full list of contributors, see <Page with the contributors info> 

e.g. 
https://git.cells.es/controls/<project>/graphs/master

``` 
