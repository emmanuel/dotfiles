#!/bin/sh

y="`pwd`/$1"
echo Will create a searchable PDF for $y

x=`basename "$y"`
name=${x%.*}

mkdir "$name"
cd "$name"

# splitting to individual pages
gs -dSAFER -dBATCH -dNOPAUSE -sDEVICE=jpeg -r300 -dTextAlphaBits=4 -o out_%04d.jpg -f "$y"

# process each page
for f in $( ls *.jpg ); do
  # extract text
  # tesseract -l eng -psm 3 $f ${f%.*} pdf
  tesseract $f ${f%.*} -l eng --psm 3 pdf
  rm $f
done

# combine all pages back to a single file
gs -dCompatibilityLevel=1.4 -dNOPAUSE -dQUIET -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=../${name}_searchable.pdf *.pdf

cd ..
rm -rf $name

# Adapted from: http://www.morethantechnical.com/2013/11/21/creating-a-searchable-pdf-with-opensource-tools-ghostscript-hocr2pdf-and-tesseract-ocr/
# from http://www.ehow.com/how_6874571_merge-pdf-files-ghostscript.html
# bash tut: http://linuxconfig.org/bash-scripting-tutorial
# Linux PDF,OCR: http://blog.konradvoelkel.de/2013/03/scan-to-pdfa/
