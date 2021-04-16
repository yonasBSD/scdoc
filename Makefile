VERSION=1.11.1
CFLAGS?=-g
MAINFLAGS:=-DVERSION='"$(VERSION)"' -Wall -Wextra -Werror -Wno-unused-parameter
LDFLAGS+=-static
INCLUDE+=-Iinclude
PREFIX?=/usr/local
BINDIR?=$(PREFIX)/bin
MANDIR?=$(PREFIX)/share/man
PCDIR?=$(PREFIX)/share/pkgconfig
OUTDIR=.build
HOST_SCDOC=./scdoc
.DEFAULT_GOAL=all

OBJECTS=\
	$(OUTDIR)/main.o \
	$(OUTDIR)/string.o \
	$(OUTDIR)/utf8_chsize.o \
	$(OUTDIR)/utf8_decode.o \
	$(OUTDIR)/utf8_encode.o \
	$(OUTDIR)/utf8_fgetch.o \
	$(OUTDIR)/utf8_fputch.o \
	$(OUTDIR)/utf8_size.o \
	$(OUTDIR)/util.o

$(OUTDIR)/%.o: src/%.c
	@mkdir -p $(OUTDIR)
	$(CC) -std=c99 -pedantic -c -o $@ $(CFLAGS) $(MAINFLAGS) $(INCLUDE) $<

scdoc: $(OBJECTS)
	$(CC) $(LDFLAGS) -o $@ $^

scdoc.1: scdoc.1.scd $(HOST_SCDOC)
	$(HOST_SCDOC) < $< > $@

scdoc.5: scdoc.5.scd $(HOST_SCDOC)
	$(HOST_SCDOC) < $< > $@

scdoc.pc: scdoc.pc.in
	sed -e 's:@prefix@:$(PREFIX):g' -e 's:@version@:$(VERSION):g' < $< > $@

all: scdoc scdoc.1 scdoc.5 scdoc.pc

clean:
	rm -rf $(OUTDIR) scdoc scdoc.1 scdoc.5 scdoc.pc

install: all
	mkdir -p $(DESTDIR)/$(BINDIR) $(DESTDIR)/$(MANDIR)/man1 $(DESTDIR)/$(MANDIR)/man5 $(DESTDIR)/$(PCDIR)
	install -m755 scdoc $(DESTDIR)/$(BINDIR)/scdoc
	install -m644 scdoc.1 $(DESTDIR)/$(MANDIR)/man1/scdoc.1
	install -m644 scdoc.5 $(DESTDIR)/$(MANDIR)/man5/scdoc.5
	install -m644 scdoc.pc $(DESTDIR)/$(PCDIR)/scdoc.pc

uninstall:
	rm -f $(DESTDIR)/$(BINDIR)/scdoc
	rm -f $(DESTDIR)/$(MANDIR)/man1/scdoc.1
	rm -f $(DESTDIR)/$(MANDIR)/man5/scdoc.5
	rm -f $(DESTDIR)/$(PCDIR)/scdoc.pc

check: scdoc scdoc.1 scdoc.5
	@find test -perm -111 -exec '{}' \;

.PHONY: all clean install uninstall check
