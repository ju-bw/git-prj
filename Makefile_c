# Makefile für C
# Letztes Update: 24-Feb-2019
#
SHELL=/bin/bash
SRC=$(shell find . -iname "*.c")
TARGETS=$(SRC:%.c=%) # Musterersetzung c in 
OBJ=$(SRC:%.c=%.o)
DEP=$(SRC:%.c=%.d)
CFLAGS=-std=c11 -Wall -Wextra -lpthread -pthread -Wno-missing-field-initializers -O0 

all: $(TARGETS)

%.d: %.c
	$(CC) -MM $(CFLAGS) $< > $@

-include $(DEP)

debug: # gdb
	for i in $(TARGETS); do touch $$i.c; done
	make CFLAGS=-g 
	
clean:
	rm -rf $(OBJ) $(DEP) $(TARGETS)
	rm -rf *.x *.d a.out *~

.PHONY: clean # Phony Ziele sind immer veraltet

# make -p

# $@ Name des Ziels
# $< Die erste Abhängigkeit
# $+ Alle Abhängigkeiten
# $^ Alle Abhängigkeiten, ohne Dopplungen
# $? Alle ungültigen Abhängigkeiten

# CC       C-Kompilerbefehl
# CFLAGS   C-Kompileroptionen
# CXXFLAGS C++-Kompileroptionen
# LDFLAGS  Linkeroptionen
# LOADLIBES Einzubindende Bibliotheken
# SHELL    Shell zur Verwendung







