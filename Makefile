include macros.mk

TARGET     = bin/client_static
LIB        = lib/libmyutils.a
OBJECTS    = obj/mystrfunctions.o obj/myfilefunctions.o
MAINOBJ    = obj/main.o

.PHONY: all clean

all: $(TARGET)

# Link the final program with static library
$(TARGET): $(MAINOBJ) $(LIB)
	$(CC) $(CFLAGS) -o $@ $(MAINOBJ) -Llib -lmyutils

# Build static library
$(LIB): $(OBJECTS)
	ar rcs $@ $(OBJECTS)
	ranlib $@

# Compile object files
obj/%.o: src/%.c
	$(CC) $(CFLAGS) -Iinclude -c $< -o $@

clean:
	rm -f obj/*.o $(TARGET) $(LIB)

