CXX = g++
INCLUDES = -I/usr/include/opencv4
CFLAGS = -O3 -std=c++20 -fmodules-ts
SYSTEM_HEADER_CFLAGS = -x c++-system-header iostream
LIBRARIES = -lopencv_core 
OBJ_EXT = .o
CPP_EXT =.cpp
CXX_EXT =.cxx
INT_EXT =$(CXX_EXT)
IMP_EXT =_impl$(CXX_EXT)

BASE_DIR = ./
EXEC_DIR = $(BASE_DIR)bin
SRC_DIR = $(BASE_DIR)src
OBJ_DIR =$(BASE_DIR)objs

TARGET_STEM = head_circumference_20
TARGET = $(EXEC_DIR)/$(TARGET_STEM)

_IM = images
_IM_DEPS_STEMS = read
_IM_INTS = $(addsuffix $(INT_EXT), $(_IM_DEPS_STEMS))
_IM_IMPS = $(addsuffix $(IMP_EXT), $(_IM_DEPS_STEMS))

IM_OBJ_DIR = $(OBJ_DIR)/$(_IM)
IM_SRC_DIR = $(SRC_DIR)/$(_IM)
IM_INTS = $(addprefix $(IM_SRC_DIR)/, $(_IM_INTS))
IM_IMPS = $(addprefix $(IM_SRC_DIR)/, $(_IM_IMPS))
_IM_INT_OBJS = $(_IM_INTS:$(INT_EXT)=$(OBJ_EXT)) 
IM_INT_OBJS = $(addprefix $(IM_OBJ_DIR)/, $(_IM_INT_OBJS))
_IM_IMP_OBJS = $(_IM_IMPS:$(CXX_EXT)=$(OBJ_EXT)) 
IM_IMP_OBJS = $(addprefix $(IM_OBJ_DIR)/, $(_IM_IMP_OBJS))

all: $(TARGET)

$(EXEC_DIR):
	mkdir -p $@

$(IM_OBJ_DIR):
	mkdir -p $@

$(IM_INT_OBJS): $(IM_OBJ_DIR)/%$(OBJ_EXT): $(IM_INTS) | $(IM_OBJ_DIR)
	$(CXX)  $< -c -o $@  $(CFLAGS) $(INCLUDES)

$(IM_IMP_OBJS): $(IM_OBJ_DIR)/%$(OBJ_EXT): $(IM_IMPS) $(IM_INT_OBJS) | $(IM_OBJ_DIR)
	$(CXX)  $< -c -o $@  $(CFLAGS) $(INCLUDES) -I$(SRC_DIR)

$(TARGET): $(SRC_DIR)/$(TARGET_STEM)$(CPP_EXT) $(IM_INT_OBJS) $(IM_IMP_OBJS) | $(EXEC_DIR)
	@echo "(Compiling and) Linking $(TARGET) ..."
	$(CXX) $< -o $@ $(IM_INT_OBJS) $(IM_IMP_OBJS) $(CFLAGS) $(SYSTEM_HEADER_CFLAGS) $(LIBRARIES)

clean:
	rm $(TARGET) $(IM_INT_OBJS) $(IM_IMP_OBJS)  
	rmdir $(EXEC_DIR) $(IM_OBJ_DIR) $(OBJ_DIR)
	

run:
	$(TARGET)

peak:
	@echo "ojbets for images are $(_IM_OBJS)"
	


