# Git Befehle

% Letztes Update: 24-Feb-2019

<http://git-scm.com/download>

Die drei Zustände einer Datei in Git:

- untracked  :: Git kümmert sich nicht.
- commited   :: Im Repository gespeicherte Dateien.
- modified   :: Dateien mit ungespeicherten Änderungen.
- staged     :: Änderungen, die gespeichert werden sollen (nach einem add).

Git erstellt pro Commit eine Prüfsumme (hash) von Inhalt, Autor, Datum ...

Ein Referenzname zeigt auf die Spitze jedes Branches.

Branch: (nebenläufiger) Strang von Änderungen an der gleichen Quelle

alias ~/.gitconfig

~~~
	# file: ~/.gitconfig
  st = status 
  cl = clone
  c = commit -m
  cam = commit -am
  ca = commit --amend
  co = checkout
  br = branch -a
  brm = branch --merged
  r = reset
  lg = log --oneline --graph --decorate
  lo = log --oneline --decorate
  ls = log --pretty=format:"%C(green)%h\\ %C(yellow)[%ad]%Cred%d\\ %Creset%s%Cblue\\ [%an]" --decorate --date=relative
  ll = log --pretty=format:"%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [a:%an,c:%cn]" --decorate --numstat
  d = diff --word-diff
  dc = diff --cached
~~~

## Neues Repository auf github anlegen

<https://github.com/ju-bw/>

- Repository name = git-prj
- Repo            = github, lokal, backup, origin
- Branch          = work, feature


~~~
	# Neues Repository auf github anlegen
	# 	Create a new repository
	# 	Repository name = git-prj

	# Ubuntu: Generating a new SSH key and adding it to the ssh-agent
	ssh-keygen -t rsa -b 4096 -C "mail@ju1.eu"
		Enter passphrase (empty for no passphrase): [Type a passphrase]
		Enter same passphrase again: [Type passphrase again]
	# Hinzufügen SSH-Schlüssels zum ssh-agent
	eval "$(ssh-agent -s)"
	ssh-add ~/.ssh/id_rsa

	# Zwischenablage
	sudo apt-get install xclip 

	# Kopiert den Inhalt der Datei id_rsa.pub in Zwischenablage
	xclip -sel clip < ~/.ssh/id_rsa.pub

	# auf github SSH key hinzufügen
~~~

## Neues Repository lokal anlegen

~~~
	vi ~/.gitignore
	vi ~/.gitattributes
	vi ~/.gitconfig
~~~

~~~
	# Neues Repository lokal anlegen
	cd ~/experimente/git-ubuntu/
	mkdir git-prj
	cd git-prj
	git init  # rm -rf .git oder git status
	vi neu.txt
	git add .   # Änderungen zum Commit vorzumerken
	git add neu.txt
	#git reset HEAD neu.txt  # Änderungen verwerfen
	#git checkout -- neu.txt # Änderungen verwerfen
	git commit -am "init" # neue Version anlegen
	git commit -a # editor         # neue Version anlegen
~~~

## Lokales Repository in das zentrale Repository (Github) kopieren

~~~	
	# Lokales Repository in das zentrale Repository kopieren
	git remote add origin https://github.com/ju-bw/git-prj.git
	git remote add origin git@github.com:ju-bw/git-prj.git

	# remote (github) definieren: frei wählbar
	git remote add github https://github.com/ju-bw/git-prj.git
	git remote add github git@github.com:ju-bw/git-prj.git

	# Zum Senden wird das Repository auf den Server gepusht.
	git push -u origin master
	# Welcher Branch (master) soll übertragen werden
	git push -u github master 
	git push # git push github master
	
	# Zum Empfangen, wird vom Remote gepullt:
	git pull # git pull github master
~~~

## aktuellen Zustand anzeigen 

~~~
	# aktuellen Zustand anzeigen 
	# alias: ~/.gitconfig
	git status 
	git log #  beenden mit q
	git log --oneline --graph --decorate
	git log -u # Zeigt den Verlauf einer Datei mit Diffs an
	gitk
	git lg > gitlog.txt
	git ls >> gitlog.txt
~~~

## Branch

~~~
	# Branch
	git branch -a # liste aller branches
	git status

	git branch work      # Erzeugt einen neuen Branch
	git checkout work    # Wechselt zum  Branch
	git checkout -b work # Branch erzeugen und gleich wechseln

	# bearbeiten
	vi neu.txt
	git add .
	git commit -a # oder: git commit -am"Testaenderung"
	git status
	git checkout master
	git merge work 

	# Branch löschen
	git checkout master
	git branch --no-merged 
	git branch -d work
~~~

## Die Arbeit zurück auf den Master-Branch führen

~~~
	# Die Arbeit zurück auf den Master-Branch führen
	git checkout master
	git merge work      # Automatischer Merge
~~~

## Im Falle von Konflikten (unvereinbare Änderungen)

~~~
	# Im Falle von Konflikten (unvereinbare Änderungen)
	# zweig master und zweig work wurde getrennt verändert
	git branch -a

	git checkout work
	vi neu.txt
	git commit -am"work: aenderung"

	git checkout master
	vi neu.txt
	git cam "master: aenderung"   #  git commit -am"master: aenderung"

	git merge work  # Automatischer Merge fehlgeschlagen
	git status
	git mergetool
	git lg  # git log --graph --oneline --decorate
~~~

## zu einem früheren Stand zurückkehren

~~~
	# zu einem früheren Stand zurückkehren
	git log --graph --oneline --decorate
	git stash
	git reset --hard 6bb9f9d
~~~

## Einen Commit rückgängig machen

~~~
	# Einen Commit rückgängig machen
	git ls
		3bea70f [vor 45 Sekunden] (HEAD -> master, github/master) test [Jan Unger]
		7470c66 [vor 22 Stunden] merge work master [Jan Unger]
	git revert 3bea70f
~~~

## Den letzten Commit nachträglich bearbeiten

~~~
	# Den letzten Commit nachträglich bearbeiten
	git ca  # git commit --amend
~~~

## Unversionierte Dateien hinzufügen

~~~
	# Unversionierte Dateien hinzufügen
	# 	bsp. datei wurde vergessen zum letzten commit 
	git add hallo.txt
	git ca # git commit --amend 
~~~

## Änderung des Branchverlaufs mit Rebase


~~~
	# Änderung des Branchverlaufs mit Rebase
	git status
	git branch
	git checkout work 
	git log work 
	git log master
	#git merge master
	git rebase master # vor git push benutzen! sonst Konflikte
~~~

## Erweiterte Änderungen mit dem interaktiven Rebase

~~~
	# Erweiterte Änderungen mit dem interaktiven Rebase
	git status
	git branch
	git checkout work 
	git rebase -i HEAD~3
		# Befehle: Rebase 
		# p, pick = Commit verwenden
		# r, reword = Commit verwenden, aber Commit-Beschreibung bearbeiten
		# e, edit = Commit verwenden, aber zum Nachbessern anhalten
		# s, squash = Commit verwenden, aber mit vorherigem Commit vereinen
		# f, fixup = wie "squash", aber diese Commit-Beschreibung verwerfen
		# x, exec = Befehl (Rest der Zeile) mittels Shell ausführen
		# d, drop = Commit entfernen
	# wenn konflikte
	git rebase --edit-todo
	git rebase --continue 
~~~

## Dateien aus der gitignore nachträglich aus dem Repository bekommen

~~~
	# Dateien aus der gitignore nachträglich aus dem Repository bekommen
	vi .gitignore # anpassen
	git commit -am"add pdf to gitignore"
	git rm -r --cached .
	git add .
	git commit -am"Remove now ignore files"
	git clean -nxd # vorschau
	git clean -fxd # löscht auf SSD
~~~

## Repository von Github downloaden

~~~
	# Repository von Github downloaden
	if [ ! -d ../github-klone ]; then mkdir -p ../github-klone; fi
	cd ../github-klone
	git clone git@github.com:ju-bw/git-prj.git 
	git clone https://github.com/ju-bw/git-prj.git 
~~~

## lokal - zentrales Repository für den Austausch erstellen

~~~
	# lokal: zentrales Repository für den Austausch erstellen
	if [ ! -d /media/jan/virtuell/git-server-repo ]; then mkdir -p /media/jan/virtuell/git-server-repo; fi
	cd ~/experimente/git-ubuntu/git-prj
	git clone --bare . /media/jan/virtuell/git-server-repo/git-prj.git
	git remote add lokal /media/jan/virtuell/git-server-repo/git-prj.git
	#git push -u lokal master
	git push # git push lokal master
	git pull # git pull lokal master
~~~

## Lokales Backup erstellen

~~~
	# Lokales Backup erstellen
	if [ ! -d /media/jan/virtuell/git-server-repo ]; then mkdir -p /media/jan/virtuell/git-server-repo; fi
	#cd ~/experimente/git-ubuntu/git-prj
	git clone --no-hardlinks --bare . /media/jan/virtuell/git-server-repo/git-prj-backup.git
	git remote add backup /media/jan/virtuell/git-server-repo/git-prj-backup.git
	
	# sichern
	git push --all backup
	
	# Wiederherstellen: Repository in ein temporäres Verzeichnis klonen
	if [ ! -d /tmp/prj-neu ]; then rm -rf /tmp/prj-neu; fi
	git clone .  /tmp/prj-neu/
	cd /tmp/prj-neu 
	
	# wechselt dann auf den gewünschten Git-Branch
	git log --graph --oneline --decorate
	git stash
	git reset --hard 6bb9f9d
	
	# verschiebe .git in den Workspace der alten Versionsverwaltung.
	
	# Ergebnis prüfen
	if [ ! -d /tmp/prj-alt ]; then mkdir -p /tmp/prj-alt; fi
	cd ~/experimente/git-ubuntu/git-prj/
	git archive master | tar -x -C /tmp/prj-alt/
	kdiff3 /tmp/prj-alt/ /tmp/prj-neu/
~~~

