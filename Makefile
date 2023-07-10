CXX = g++
INCLUDES = -I/usr/include/opencv4
CFLAGS = -O3 -std=c++20 -fmodules-ts $(INCLUDES) -x c++-system-header iostream   
LIBRARIES = -lopencv_core 
OBJ_EXT = .o
CPP_EXT =.cpp

BASE_DIR = ./
EXEC_DIR = $(BASE_DIR)bin
SRC_DIR = $(BASE_DIR)src
OBJ_DIR =$(BASE_DIR)objs

IQUOTE=-iquote$(SRC_DIR)

TARGET_STEM = head_circumference_20
TARGET = $(EXEC_DIR)/$(TARGET_STEM)

all: $(TARGET)

$(EXEC_DIR):
	mkdir -p $@

$(TARGET): $(SRC_DIR)/$(TARGET_STEM)$(CPP_EXT) | $(EXEC_DIR)
	@echo "(Compiling and) Linking $(TARGET) ..."
	$(CXX) $< -o $@ $(CFLAGS) $(LIBRARIES)

clean:
	rm $(TARGET)

run:
	$(TARGET)


