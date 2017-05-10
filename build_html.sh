#!/bin/sh
#create single html doc from TOC
OUT=apg.html
echo "generating $OUT"
pandoc `cat TOC` -o $OUT

# TODO: convert .md links to anchors
# TODO: get version (tag or git refspec) and add it to the name
# TODO: Maybe use sphinx to insert the .md?
# TODO: integrate this in gitlab-ci  
