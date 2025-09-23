## **Feature-3: Creating and Using Static Library**

**1. Compare the Makefiles from Part 2 and Part 3. What are the key differences in the variables and rules that enable the creation of a static library?**

Part 2 (multifile build):

Directly compiled all .c files into .o files.

Linked them together into the final executable.

Example rule:

$(TARGET): $(OBJECTS)
	$(CC) $(CFLAGS) -o $@ $(OBJECTS)


Part 3 (static library build):

First archived utility .o files into a static library (lib/libmyutils.a) using ar.

Then linked only main.o with -lmyutils.

Example rules:

$(LIB): $(OBJECTS)
	ar rcs $@ $(OBJECTS)
	ranlib $@

$(TARGET): $(MAINOBJ) $(LIB)
	$(CC) $(CFLAGS) -o $@ $(MAINOBJ) -Llib -lmyutils


Key difference: Part 3 separates library creation from final executable linking, which makes the project more modular and reusable.

**2. What is the purpose of the ar command? Why is ranlib often used immediately after it?**

ar: Stands for archiver. It bundles multiple object files (.o) into a single archive (.a), which is the static library.

ranlib: Creates an index (symbol table) inside the library, so the linker can quickly find functions.

Some systems auto-run ranlib when you use ar rcs, but it’s good practice to run it explicitly.

**3. When you run nm on your client_static executable, are the symbols for functions like mystrlen present? What does this tell you about how static linking works?**

Yes, nm bin/client_static shows the function symbols (like mystrlen, mystrcat, etc.).

This happens because static linking copies the actual machine code of the functions into the executable itself.

Result:

Executable is larger but self-contained.

Does not need external libraries at runtime.
