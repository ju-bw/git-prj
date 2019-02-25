# Suche file 

Bsp.: c, py, tex, jpg, svg, md, html, pdf

## Suche files, deren Inhalt innerhalb der letzten 7 Tage geändert wurde

~~~
  # suche: md
  find . -name '*.md' -mtime -7 -print -fprint "alle-7-Tage-files.txt" | wc -l 
~~~

## Suchen, Sortieren und in Datei speichern.

~~~
  # suche: md
  PRJFILES="md" 
  find . -name '*.md'  > alle-$PRJFILES-files.txt &
  mv alle-$PRJFILES-files.txt tmp; sort tmp > alle-$PRJFILES-files.txt; rm tmp 
~~~

## Suche anzahl file die sich innerhalb von 7 Tagen geändert hat

~~~
  # suche: git-befehle.md
  FILE="git-befehle.md"
  find . -name $FILE -mtime -7 | wc -l 
~~~

## Backup von file

~~~
  # backup von file
  PRJFILES="md"
  if [ ! -d ../tmp/$PRJFILES ]; then mkdir -p ../tmp/$PRJFILES; fi
  rm -rf ../tmp/$PRJFILES/*
  # suche anpassen
  find . -name "*.md" -exec cp -ap {} ../tmp/$PRJFILES \;
  TIMESTAMP=$(date +%F)
  cd ../tmp/$PRJFILES/
  tar -c * | gzip > ../../$TIMESTAMP-$PRJFILES.tar.gz
~~~
