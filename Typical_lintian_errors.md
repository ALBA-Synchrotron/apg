## Typical lintian errors

**W: linacgui source: changelog-should-mention-nmu**
**W: linacgui source: source-nmu-has-incorrect-version-number 2.70.0.post0-0~bpo9+0~alba+1**

You can suppress these warning adding "local package" on the first line of the changelog entry.  

**W: linacgui source: ancient-standards-version 3.9.6 (current is 3.9.8)**

You can suppress the warning replacing the ancient-standards-version in the debian/control file from 3.9.6 to 3.9.8

**I: linacgui: extended-description-is-probably-too-short**

Add a large description in the control file

**W: linacgui: binary-without-manpage usr/bin/ctli**

The binaries should include --help  option. In the package time help2man must be used.

**E: linacgui: debian-copyright-file-uses-obsolete-national-encoding at line 7**

There are many ways to convert a copyright file from an obsoleted
encoding like ISO-8859-1; you may for example use "iconv" like:
```  
$ iconv -f ISO-8859-1 -t UTF-8 copyright > copyright.new
$ mv copyright.new copyright
```

**W: linacgui: desktop-entry-lacks-main-category usr/share/applications/ctli.desktop** 
The desktop-file-validate tool in the desktop-file-utils package is
useful for checking the syntax of desktop entries.
