# Appendix 2. Reference packages

When facing the packaging of a new code, it is a good idea to use a similar 
existing package as a reference.

Here we list some packages that have been chosen as good examples for different 
types of codes. For some of them, a document is linked were the process of  
creating this specific package is explained in detail.


- Python Device Server: [PyLinkCam](example.PyLinkCam.md)
- C++ Device Server: [SerialLine](example.SerialLine.md)
- Python module:[fandango](example.fandango.md) python-taurus, python-sardana
- C++ Library: [Yat](example.yat.md), [SerialLine](example.SerialLine.md)
- Python application (ex: TaurusGUI): [LinacGUI](example.LinacGUI.md)
- Driver: linux-gpb
- Single source packages yielding multiple binary packages: [SerialLine](example.SerialLine.md)

Note: you can also use official packages for reference. In this case, if you do 
not have access to their packaging CVS, you can simply unpack the sources with:
`apt-get source foo`
