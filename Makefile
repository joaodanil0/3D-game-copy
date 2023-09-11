
OBJ_DIR = out
SRC_DIR = src
INCLUDE_DIR = include

CC=g++
CCFLAGS=-I$(INCLUDE_DIR) -g -Wall -Wextra -Werror
LDFLAGS=-lm -lncurses

TARGET = launch
MAIN = main

#! Mapeia todo os arquivo dentro da pasta include/
#! que terminam com .h (header)
DEPS=$(shell find $(INCLUDE_DIR) -name '*.h')
# $(info    DEPS is = $(DEPS))

#! Mapeia todos os arquivos CPP dentro da pasta src/ 
#! e troca o sufixo CPP por "o" (de objeto)
SOURCES = $(shell find $(SRC_DIR) -name '*.cpp')
_OBJ = $(patsubst %.cpp,%.o,$(SOURCES))
OBJ  = $(patsubst %,$(OBJ_DIR)/%,$(_OBJ))
# $(info    OBJ is = $(OBJ))

all: $(TARGET)

#! Versao simplificada
#! $(TARGET): launch.o
#!	$(CC) -o launch $(LDFLAGS)
$(TARGET): $(OBJ_DIR)/$(MAIN).o $(OBJ)
	$(CC) -o $@ $^  $(LDFLAGS)

#! Versao simplificada
#! launch.o: launch.cpp
#!	$(CC) -c launch.cpp $(CCFLAGS)
$(OBJ_DIR)/%.o: %.cpp $(DEPS)
	@mkdir -p $(@D) #! Cria a pasta
	$(CC) -c -o $@ $< $(CCFLAGS)

.PHONY: clean

clean:
	-rm -rf $(OBJ_DIR)/*
	-rm $(TARGET)

run: all
	./$(TARGET)