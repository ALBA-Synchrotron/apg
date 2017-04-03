# Download a debian source package

If you need to download a debian source package from a debian repository 
(maybe you are backporting it, or maybe you want to study it while packaging 
something similar), just use:

```
apt-get source <package_name>
```

Note: <package_name> should be the *source* package name, but it will also 
accept a *binary* package name
