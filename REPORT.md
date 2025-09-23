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

