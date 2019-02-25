#!/bin/bash -e
# Letztes Update: 24-Feb-2019
# optimiere Bilder für das Web & Latex

# png oder jpg als input? code anpassen zeile 46

# Variable
quelle="img-in"
ziel="img-out"
tmp="tmp"
img="img"
aufloesung="1920" # 1920x1080
qualitaet="75"    # 75%
info="optimiere Bilder für das Web & Latex"
timestamp_2=$(date +"%d-%h-%Y")
copyright="ju -- https://ju1.eu -- Letztes Update: $timestamp_2"

# -----------------------------
echo "+++ $info"

# Ordner prüfen
if [ ! -d $quelle ];   then mkdir -p $quelle; fi
if [ ! `ls -a $quelle | wc -l` -gt 2  ]; then echo "+++ Fehler: $quelle ist leer."; exit; fi
if [ ! -d $ziel ];   then mkdir -p $ziel; fi

echo "+++ Kopie: Quelle - Ziel"
rsync -avpEh --delete $quelle/ $ziel/
echo "-----------------------------"

echo "Suchen und Ersetzen"
cd $ziel
# 's/suchen/ersetzen/g'
find . -name "*.JPG"  -exec rename 's/.JPG/.jpg/g'  {} +
find . -name "*.jpeg" -exec rename 's/.jpeg/.jpg/g' {} +
find . -name "*"      -exec rename 's/ü/ue/g' {} +
find . -name "*"  		-exec rename 's/ä/ae/g' {} +
find . -name "*"  		-exec rename 's/ö/oe/g' {} +
find . -name "*"      -exec rename 's/Ü/ue/g' {} +
find . -name "*"      -exec rename 's/Ä/ae/g' {} +
find . -name "*"      -exec rename 's/Ö/oe/g' {} +
find . -name "*"      -exec rename 's/ß/ss/g' {} +
find . -name "*"      -exec rename 's/_/-/g'  {} +
find . -name "*"      -exec rename 's/ //g'   {} +
echo "-----------------------------"

# code anpassen
echo "PNG in JPG"
#cd $ziel
for i in *.png; do
	jpgname=${i%.png}.jpg
	# convert quelle.png ziel.jpg
	convert $i $jpgname
done

echo "JPG in PNG"
#cd $ziel
#for i in *.jpg; do
#	pngname=${i%.jpg}.png
	# convert quelle.jpg ziel.png
#	convert $i $pngname
#done
echo "-----------------------------"

#cd $ziel
echo "+++ Web optimierte Fotos"
# Rahmen - Progressiv - Schärfen -auto-orient - Meta entfernen - Qualität
for i in *.jpg; do
	# convert quelle.jpg ziel.png
	convert $i -quality $qualitaet $i # Qualitaet 75%
	# Progressiv - Schärfen - Meta entfernen
	convert $i -auto-orient -sharpen 1 -strip -interlace JPEG $i
done

# 1920x1080 Auflösung web
mogrify -resize $aufloesung *.jpg

echo "-----------------------------"

echo "+++ Latex optimierte Fotos"
# 728x516 Auflösung png
mogrify -resize $aufloesung *.png

# png in eps
for i in *.png; do
	epsname=${i%.png}.eps
	# convert quelle.jpg ziel.png
	convert -quiet -flatten -background white $i eps3:$epsname
done

# eps in pdf (728x516) latex
for i in *.eps; do
	pdfname=${i%.eps}.pdf
	gs -dEPSCrop -dBATCH -dNOPAUSE -sOutputFile=$pdfname -sDEVICE=pdfwrite \
		-c "<< /PageSize [$aufloesung]  >> setpagedevice" 90 rotate 0 -f $i &>/dev/null
done

echo "-----------------------------"

echo "+++ Aufräumen"
rm *.eps
rm *.png

cd ..

echo "fertig"
