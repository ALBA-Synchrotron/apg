### Appendix 3. ALBA packaging naming convention
Each package has an unique “name”. Here, at ALBA we define a strategy to use unique names that do not clash with debian packages name based on [Vicent Bernat document](https://vincent.bernat.im/en/blog/2014-local-apt-repositories) and [dep14](http://dep.debian.net/deps/dep14/). So, we will use a custom backport convention for creating our packages.

The package name has two components: name + version. The name is defined in the `debian/control` file, while the package version is defined in `debian/changelog`. One source package can yield one or more binary packages (with different names) which will all share the version. 

The naming convention is:

```
<NAME>_<UPSTREAM>-<DEB>~bpo<DISTRO>+<BPO>~alba+<ALBA>
```


Where:
- `<NAME>` is the package name. It must consist only of lowercase 
  letters (a-z), digits (0-9), plus (+) and minus (-) signs, and 
  periods (.). They must be at least two characters long and must 
  start with an alphanumeric character
- `<UPSTREAM>` is the upstream sources version (e.g: 12.3.0). 
  - Note 1: If the upstream sources are from an untagged commit 
    in a version control system, you should suffix the version with 
    `+<CVS>`. The conventions for `<CVS>` depend on the control 
    version system:
    - For git: `<CVS>` would be `git<YYYYMMDD>.<BUILD>.<HASH>` , where 
      `<YYYYMMDD>` is the packaging date, `<BUILD>` 
      is an incremental number reset to `1` when `<YYYYMMDD>` 
      changes. `<HASH>` is the first **six** git hash characters. You may    
      use:
      ```
      echo "+git"`date +%Y%m%d`.1.`git rev-parse --short=6 HEAD`
      ```
    - For svn: `<CVS>` would be `svn~r<REV>`, where `<REV>` 
      is the svn revision number. You may use:
      ```
      echo “+svn~r”`svnversion`
      ```
    - For cvs: `<CVS>` would be `cvs~r<REV>`, where `<REV>` 
      is the cvs revision number.
  - Note 2: in some cases, (e.g., when the upstream sources are modified
    by the Debian packager to comply with the Debian Free Software
    Guidelines), an *extra* suffix may be found such as `dfsg` or 
    `dfsg1`, or similar)
- `<DEB>` is the Debian version for existing Debian packages. Normally 
  it is a number for existing debian packages, but in some cases, it 
  can be more complex (e.g. `4+b3`). If  there is no existing debian
  package, use `0`. If you are including any extra patches, you have to
  add +patch<N> where <N> is a correlatively increasing number beginning in   
  1.
- `<DISTRO>` is the distro major release number (e.g., <DISTRO> is `9`
  for [Debian Stretch](https://wiki.debian.org/es/DebianStretch)).
- `<BPO>` is the **debian** backport number. If we are not backporting from an existing backport, use `0`
- `<ALBA>` is an incremental number of the existing packages with this exact configuration. Reset it to `1` if any of the previous version components changes.

 **Examples** 

- If today (14th Feb 2017) we want to package fandango (which 
  does not exist in Debian repos), using the code from the git
  commit 00d19e6, the source name would be `fandango` and the
  version would be:
  `12.3.0+git20170214.1.00d19e-0~bpo9+0~alba+1`

- Let’s assume that a new version of the tango package comes out for
  debian sid (e.g. tango-9.2.6+dfsg1-1), and we want to backport 
  it for ALBA, the source name would be `tango` and version:
  `9.2.6+dfsg1-1~bpo9+0~alba+1`

- Let’s assume that a new version of the tango package comes out for
  any debian distribution (e.g. tango-9.2.6+dfsg1-1), and we want to   
  backport it with and extra patch for ALBA, the source name would be  
 `tango` and version: `9.2.6+dfsg1-1+patch1~bpo9+0~alba+1`

- Let’s assume that we create a new alba package from scratch for the         
  SerialLine DS package and it comes from a SVN trunk branch (r1643975)
  the source name would be `serialline` and version:
  `1.8.11+svn~r16439-0~bpo9+0~alba+1` 

- If today (1st Mar 2017) we create the first backport for
  the taurus package using (the develop branch), the source name 
  would be `taurus` and the version would be:
  `4.0.4a0+git20170301.1.8fe85+dfsg-0~bpo9+0~alba+1`
