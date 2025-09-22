# Compiler and Flags
CC = gcc
CFLAGS = -Wall -Iinclude -fPIC

# Directories
SRC_DIR = src
OBJ_DIR = obj
BIN_DIR = bin
LIB_DIR = lib
INC_DIR = include

# Targets
STATIC_LIB = $(LIB_DIR)/libmyutils.a
DYNAMIC_LIB = $(LIB_DIR)/libmyutils.so
STATIC_CLIENT = $(BIN_DIR)/client_static
DYNAMIC_CLIENT = $(BIN_DIR)/client_dynamic

# Sources and Objects
SRCS = $(SRC_DIR)/mystrfunctions.c $(SRC_DIR)/myfilefunctions.c
OBJS = $(OBJ_DIR)/mystrfunctions.o $(OBJ_DIR)/myfilefunctions.o
MAIN = $(OBJ_DIR)/main.o

# Default target
all: $(STATIC_CLIENT) $(DYNAMIC_CLIENT)

# Build object files
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	$(CC) $(CFLAGS) -c $< -o $@

# Static library
$(STATIC_LIB): $(OBJS)
	ar rcs $@ $^

# Dynamic library
$(DYNAMIC_LIB): $(OBJS)
	$(CC) -shared -o $@ $^

# Static client
$(STATIC_CLIENT): $(MAIN) $(STATIC_LIB)
	$(CC) -o $@ $^

# Dynamic client
$(DYNAMIC_CLIENT): $(MAIN) $(DYNAMIC_LIB)
	$(CC) -o $@ $< -L$(LIB_DIR) -lmyutils

# Clean
clean:
	rm -f $(OBJ_DIR)/*.o $(STATIC_CLIENT) $(DYNAMIC_CLIENT) $(STATIC_LIB) $(DYNAMIC_LIB)

# Phony targets
.PHONY: all clean
