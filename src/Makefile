include ../macros.mk

# Object files
OBJS = $(OBJDIR)/main.o $(OBJDIR)/mystrfunctions.o $(OBJDIR)/myfilefunctions.o

# ----------------------
# Build Static Executable
# ----------------------
static: $(LIBDIR)/libmyutils.a $(OBJS)
	$(CC) $(OBJS) -o $(STATIC_TARGET) -L$(LIBDIR) -lmyutils

$(LIBDIR)/libmyutils.a: $(OBJDIR)/mystrfunctions.o $(OBJDIR)/myfilefunctions.o
	mkdir -p $(LIBDIR)
	ar rcs $@ $^
	ranlib $@

# ----------------------
# Build Dynamic Executable
# ----------------------
dynamic: $(LIBDIR)/libmyutils.so $(OBJS)
	$(CC) $(OBJS) -o $(DYNAMIC_TARGET) -L$(LIBDIR) -lmyutils

$(LIBDIR)/libmyutils.so: $(OBJDIR)/mystrfunctions.o $(OBJDIR)/myfilefunctions.o
	mkdir -p $(LIBDIR)
	$(CC) -shared -o $@ $^

# ----------------------
# Compilation Rules
# ----------------------
$(OBJDIR)/%.o: %.c
	mkdir -p $(OBJDIR)
	$(CC) $(CFLAGS) -c $< -o $@

# ----------------------
# Clean
# ----------------------
clean:
	rm -f $(OBJDIR)/*.o $(STATIC_TARGET) $(DYNAMIC_TARGET) \
	      $(LIBDIR)/libmyutils.a $(LIBDIR)/libmyutils.so

