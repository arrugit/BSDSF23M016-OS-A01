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
