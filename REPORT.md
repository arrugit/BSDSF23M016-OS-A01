## **Feature 2: Multi-file Build and First Release**

**1. Linking Rule in Makefile**

In this feature, the linking rule of the Makefile was:

$(TARGET): $(OBJECTS)
    $(CC) $(CFLAGS) -o $@ $(OBJECTS)


Here, the executable target ($(TARGET)) depends directly on the list of object files ($(OBJECTS)).

The compiler links all object files into one final binary in a single step.

This differs from linking against a library, where instead of including every object file, we link with a prebuilt archive (.a) or shared library (.so) using a flag such as -lmylib. That approach makes builds faster and modular since common code doesn’t need recompiling.

**2. Git Tags and Their Importance**

A git tag is a pointer to a specific commit in the repository history, usually marking an important version (e.g., a stable release).

Tags are useful because they allow developers and users to easily refer back to specific versions without needing to remember commit hashes.

Simple tags: Just a lightweight pointer to a commit.

Annotated tags: Store metadata such as the tagger’s name, email, date, and a descriptive message. These are preferred for versioning since they provide context.

In this feature, we created an annotated tag:

git tag -a v0.1.1-multifile -m "Version 0.1.1 - Basic multifile compilation"

**3. GitHub Release and Attaching Binaries**

A GitHub Release is a snapshot of the project tied to a specific tag. It makes it easy for users to see what has changed between versions and download stable builds.

By attaching the compiled binary (bin/client) as an asset to the release, users can run the program directly without needing to compile the source code themselves.

This is an essential step for distributing production-ready software, especially for non-developers.

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

## **Feature 4: Dynamic Library Build**
**1. What is Position-Independent Code (-fPIC) and why is it a fundamental requirement for creating shared libraries?**

- `-fPIC` creates code that can run correctly no matter where in memory it is loaded.  
- It is required for shared libraries because the OS may load them at different memory addresses for different programs.  

**2. Explain the difference in file size between your static and dynamic clients. Why does this difference exist?**

- **Static client** is larger because it contains a copy of all library code inside the executable.  
- **Dynamic client** is smaller because it only stores references to the shared library, which is loaded separately at runtime.  

**3. What is the LD_LIBRARY_PATH environment variable? Why was it necessary to set it for your program to run, and what does this tell you about the responsibilities of the operating system's dynamic loader?**

- `LD_LIBRARY_PATH` tells the OS where to look for shared libraries.  
- It was needed so the program could find `libmyutils.so` inside the `lib/` folder.  
- This shows that the OS dynamic loader is responsible for locating and loading shared libraries when a program starts.  

