C:=g++
SRCEXT:=cpp
SRCDIR:=src
OBJDIR:=obj
BIN:=bin/program

CFLAGS:=@compile_flags.txt
LDFLAGS:=-flto --gc-sections

DEBUGCFLAGS:=-Og -g -D _DEBUG
DEBUGLDFLAGS:=-g

RELEASECFLAGS:=-O3
RELEASELDFLAGS:=

.PHONY: debug release clean
debug: CFLAGS+=$(DEBUGCFLAGS)
debug: LDFLAGS+=$(DEBUGLDFLAGS)
debug: $(BIN)
release: CFLAGS+=$(RELEASECFLAGS)
release: LDFLAGS+=$(RELEASELDFLAGS)
release: $(BIN)
OBJS:=$(patsubst $(SRCDIR)/%.$(SRCEXT),$(OBJDIR)/%.o,$(wildcard $(SRCDIR)/*.$(SRCEXT)))
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
