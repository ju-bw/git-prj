# Makefile für Backup
# Letztes Update: 24-Feb-2019
# Backupversionen erstellen: backups/2019-02-22/projekt.tar.gz
SHELL=/bin/bash
# projektname
PRJNAME=projekt
MDFILES=$(shell find . -name "*.md")
TEXFILES=$(shell find . -name "*.tex")
CFILES=$(shell find . -name "*.c")
FILES=$(shell find . -name "Makefile_*")
PRJFILES=$(TEXFILES) $(MDFILES) $(CFILES) $(FILES)
TIMESTAMP=$(shell date +%F)
BACKUPTMP=../backup-tmp
BACKUPDIR=../backups
RM = rm -rf

backup: 
	cp -a . $(BACKUPTMP)
	for file in $(PRJFILES); do $(RM) $(BACKUPTMP)/$$file~; done
	(cd $(BACKUPTMP); tar -c * | gzip > $(PRJNAME).tar.gz)
	if [ ! -d $(BACKUPDIR)/$(TIMESTAMP) ]; then mkdir -p $(BACKUPDIR)/$(TIMESTAMP); fi
	cp $(BACKUPTMP)/$(PRJNAME).tar.gz $(BACKUPDIR)/$(TIMESTAMP)/$(PRJNAME).tar.gz
	$(RM) $(BACKUPTMP)

clean:
	$(RM) $(BACKUPTMP)
	$(RM) $(BACKUPDIR)

# make -p

# $@ Name des Ziels
# $< Die erste Abhängigkeit
# $+ Alle Abhängigkeiten
# $^ Alle Abhängigkeiten, ohne Dopplungen
# $? Alle ungültigen Abhängigkeiten