C:=g++
override SRCEXT:=cpp
override SRCDIR:=src
OBJDIR:=obj
BIN:=bin/program

override CFLAGS:=@compile_flags.txt
override LDFLAGS:=

override DEBUGCFLAGS:=-Og -g -D _DEBUG
override DEBUGLDFLAGS:=-g

override RELEASECFLAGS:=-O3 -flto
override RELEASELDFLAGS:=-flto

.PHONY: debug release clean
debug: CFLAGS+=$(DEBUGCFLAGS)
debug: LDFLAGS+=$(DEBUGLDFLAGS)
debug: $(BIN)
release: CFLAGS+=$(RELEASECFLAGS)
release: LDFLAGS+=$(RELEASELDFLAGS)
release: $(BIN)
override OBJS:=$(patsubst $(SRCDIR)/%.$(SRCEXT),$(OBJDIR)/%.o,$(wildcard $(SRCDIR)/*.$(SRCEXT)))
-include $(OBJS:%.o=%.d)
$(BIN): $(dir $(BIN)) $(OBJS)
	$(C) $(OBJS) -o $@ $(LDFLAGS)
$(dir $(BIN)):
	mkdir -p $@
$(OBJDIR)/%.o: $(SRCDIR)/%.$(SRCEXT) $(OBJDIR)
	$(C) -c $< -o $@ -MMD $(CFLAGS)
$(OBJDIR):
	mkdir -p $@
clean:
	rm -rf $(OBJDIR) $(BIN)
