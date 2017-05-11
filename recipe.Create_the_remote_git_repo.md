# Create the remote git repo

All alba packages must have an associated remote git repo. If it does not yet exist, it should be created **according to the conventions given in [Appendix 4](Appendix_4.md)**.

You can either create it manually using the web interface og [git.cells](https://git.cells.es) or using the script `create_ctpkg_project`.

If you create the remote git repo manually using the web interface, remember to set the visibility level of the project to *public*.

For creating it automatically, use the following script:
`create_ctpkg_project <SRC_NAME>_deb "<description>" "<tagslist>"`

Notes: SRC_NAME must correspond to the source package name, and therefore comply with the naming convention from [Appendix 4](Appendix_4.md). <description> and <tagslist> are mandatory in order to filter the projects.

e.g.:

`create_ctpkg_project testDS_deb "Repo for packaging testDS on debian" "DS, ALL, cfalcon"`
