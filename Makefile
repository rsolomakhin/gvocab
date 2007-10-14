# Makefile

DESTDIR=$(HOME)
BINDIR=$(DESTDIR)/bin
SHAREDIR=$(DESTDIR)/share/gvocab

ver=0.3
tardir=gvocab-$(ver)
bin=gvocab
ui=ui.glade
words=sat-words.xml
sedbin=gvocab.sed
svg=gvocab.svg
png=gvocab.png

help:
	# Actions:
	#	make help
	# 	make install
	#	make uninstall
	# Options:
	# 	DESTDIR - destition directory. [$(DESTDIR)]
install: $(BINDIR)/$(bin) $(SHAREDIR)/$(ui) $(SHAREDIR)/$(words) $(SHAREDIR)/$(png)
$(BINDIR)/$(bin): $(sedbin) $(BINDIR)
	cp -f $(sedbin) $(BINDIR)/$(bin)
$(sedbin): $(bin)
	cp -f $(bin) $(sedbin)
	sed -i "s!$(ui)!$(SHAREDIR)/$(ui)!" $(sedbin)
	sed -i "s!$(words)!$(SHAREDIR)/$(words)!" $(sedbin)
$(SHAREDIR)/$(png): $(png) $(SHAREDIR)
	cp -f $(png) $(SHAREDIR)/$(png)
$(BINDIR):
	mkdir -p $(BINDIR)
$(SHAREDIR)/$(ui): $(ui) $(SHAREDIR)
	cp -f $(ui) $(SHAREDIR)/$(ui)
$(SHAREDIR)/$(words): $(words) $(SHAREDIR)
	cp -f $(words) $(SHAREDIR)/$(words)
$(SHAREDIR):
	mkdir -p $(SHAREDIR)
uninstall:
	rm -f $(BINDIR)/$(bin)
	-rmdir $(BINDIR)
	rm -f $(SHAREDIR)/$(ui)
	rm -f $(SHAREDIR)/$(words)
	rm -f $(SHAREDIR)/$(png)
	-rmdir $(SHAREDIR)
dist: $(tardir).tar.bz2
$(tardir).tar.bz2: $(tardir)/$(ui) $(tardir)/$(bin) $(tardir)/$(words) $(tardir)/Makefile $(tardir)/INSTALL $(tardir)/ChangeLog $(tardir)/$(png) $(tardir)/$(svg)
	tar jcvf $(tardir).tar.bz2 $(tardir)
$(tardir)/$(ui): $(ui) $(tardir)
	cp -f $(ui) $(tardir)/$(ui)
$(tardir)/$(bin): $(bin) $(tardir)
	cp -f $(bin) $(tardir)/$(bin)
$(tardir)/$(words): $(words) $(tardir)
	cp -f $(words) $(tardir)/$(words)
$(tardir)/Makefile: Makefile $(tardir)
	cp -f Makefile $(tardir)/Makefile
$(tardir)/INSTALL: INSTALL $(tardir)
	cp -f INSTALL $(tardir)/INSTALL
$(tardir)/ChangeLog: ChangeLog $(tardir)
	cp -f ChangeLog $(tardir)/ChangeLog
$(tardir)/$(png): $(png) $(tardir)
	cp -f $(png) $(tardir)/$(png)
$(tardir)/$(svg): $(svg) $(tardir)
	cp -f $(svg) $(tardir)/$(svg)
$(tardir):
	mkdir -p $(tardir)
clean:
	rm -rf *~ $(sedbin) $(tardir).tar.bz2 $(tardir)
