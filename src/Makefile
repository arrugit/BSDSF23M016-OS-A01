include ../macros.mk

# Object files
OBJS = $(OBJDIR)/main.o $(OBJDIR)/mystrfunctions.o $(OBJDIR)/myfilefunctions.o

# Default target
all: $(TARGET)

# Link objects into final executable
$(TARGET): $(OBJS)
	$(CC) $(OBJS) -o $@

# Compile rules
$(OBJDIR)/main.o: main.c
	$(CC) $(CFLAGS) -c $< -o $@

$(OBJDIR)/mystrfunctions.o: mystrfunctions.c
	$(CC) $(CFLAGS) -c $< -o $@

$(OBJDIR)/myfilefunctions.o: myfilefunctions.c
	$(CC) $(CFLAGS) -c $< -o $@

# Cleanup
clean:
	rm -f $(OBJDIR)/*.o $(TARGET)

