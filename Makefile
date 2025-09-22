# ==============================
# Macros
# ==============================
CC       = gcc
CFLAGS   = -Wall -fPIC -Iinclude
OBJDIR   = obj
BINDIR   = bin
LIBDIR   = lib
SRCDIR   = src
MANDIR   = man/man1

TARGET_STATIC  = $(BINDIR)/client_static
TARGET_DYNAMIC = $(BINDIR)/client_dynamic
STATIC_LIB     = $(LIBDIR)/libmyutils.a
DYNAMIC_LIB    = $(LIBDIR)/libmyutils.so

OBJS = $(OBJDIR)/main.o $(OBJDIR)/mystrfunctions.o $(OBJDIR)/myfilefunctions.o

.PHONY: all static dynamic clean install

# ==============================
# Default: build both
# ==============================
all: static dynamic

# ==============================
# Build static executable
# ==============================
static: $(TARGET_STATIC)

$(TARGET_STATIC): $(OBJS)
	@mkdir -p $(LIBDIR) $(BINDIR)
	ar rcs $(STATIC_LIB) $(OBJDIR)/mystrfunctions.o $(OBJDIR)/myfilefunctions.o
	ranlib $(STATIC_LIB)
	$(CC) $(CFLAGS) $(OBJDIR)/main.o $(OBJDIR)/mystrfunctions.o $(OBJDIR)/myfilefunctions.o \
		-o $@ -L$(LIBDIR) -lmyutils

# ==============================
# Build dynamic executable
# ==============================
dynamic: $(TARGET_DYNAMIC)

$(TARGET_DYNAMIC): $(OBJS)
	@mkdir -p $(LIBDIR) $(BINDIR)
	$(CC) -shared -o $(DYNAMIC_LIB) $(OBJDIR)/mystrfunctions.o $(OBJDIR)/myfilefunctions.o
	$(CC) $(CFLAGS) $(OBJDIR)/main.o $(OBJDIR)/mystrfunctions.o $(OBJDIR)/myfilefunctions.o \
		-o $@ -L$(LIBDIR) -lmyutils

# ==============================
# Compile object files
# ==============================
$(OBJDIR)/%.o: $(SRCDIR)/%.c
	@mkdir -p $(OBJDIR)
	$(CC) $(CFLAGS) -c $< -o $@

# ==============================
# Install target
# ==============================
install: all
	@echo "Installing client and man page..."
	sudo cp $(BINDIR)/client_dynamic /usr/local/bin/client
	sudo cp $(MANDIR)/client.1 /usr/local/share/man/man1/
	sudo mandb

# ==============================
# Cleanup
# ==============================
clean:
	rm -f $(OBJDIR)/*.o $(BINDIR)/* $(LIBDIR)/*

