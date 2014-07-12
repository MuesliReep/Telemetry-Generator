

CC = gcc #TODO: ARM

###
###  Dirs & Files
###

SRCDIR = src
BLDDIR = bld
BIN  = telemetry-generator
ALLTARGETS = telemetry-generator

SRC_FILES  = main.c
SRC_FILES += Generator.c

ifndef V
  QUIET_CC   = @echo ' CC   ' $<;
  QUIET_LINK = @echo ' LINK ' $@;
  QUIET_TEST = >/dev/null 2>&1
endif

SRC  := $(patsubst %,$(SRCDIR)/%,$(SRC_FILES))
SRC  := $(sort $(SRC))
OBJ  := $(patsubst $(SRCDIR)/%.c,$(BLDDIR)/%.o,$(SRC))
DEPS := $(patsubst $(SRCDIR)/%.c,$(BLDDIR)/%.d,$(SRC))

$(BLDDIR)/%.o: $(SRCDIR)/%.c
	$(MKBLDDIR)
	$(QUIET_CC)$(CC) $(CFLAGS) -c $< -o $@

telemetry-generator: $(OBJ)
	$(QUIET_LINK)$(CC) $(LDOPTS) -o $(BIN) $(OBJ) $(LIBS)

# do not move the following line:
-include $(DEPS)

###
###  Common
###

all: $(ALLTARGETS)

clean:
	rm -f $(ALLTARGETS) *~ gmon*
	rm -rf $(BLDDIR)