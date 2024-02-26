#=================================MAKE FLAGES==================================#
MAKEFLAGS		:=	--no-print-directory
.DEFAULT_GOAL	:=	all

.DELETE_ON_ERROR:
.SECONDEXPANSION:

#=================================COMPILATION==================================#

CC					:=	g++
CFLAGS				:=	-MP -MMD
SDL_FLAGS			:=	-LSDL2 -lSDL2main -lSDL2 -lSDL2_image \
						-lSDL2_mixer -lSDL2_ttf
SDL_FLAGS_WINDOWS	:=	-LSDL2/lib -lSDL2main -lSDL2 -lSDL2_image -lSDL2_mixer \
						-lSDL2_ttf
INCLUDE				:=	-I include/

#==================================EXECUTABLE==================================#
NAME		:=	game
BUILD_DIR	:=	.build
BIN_DIR		:=	bin

#=================================SOURCE FILES=================================#
SRCS	:=	srcs/main.cpp

#====================================OBJECTS===================================#
OBJS 		:=	${SRCS:srcs/%.cpp=$(BUILD_DIR)/%.o}
DEPS		:=	$(SRCS:srcs/%.cpp=$(BUILD_DIR)/%.d)
DIRS		:=	$(sort $(shell dirname $(BUILD_DIR) $(OBJS)))

#====================================COLORS====================================#
NOC			:=	\033[0m
RED			:=	\e[1m\e[38;5;196m
GREEN		:=	\e[1m\e[38;5;76m
BLUE		:=	\e[1m\e[38;5;33m
PURPLE		:=	\033[1;35m

#=================================COUNTER UTILS================================#
PERCENT				:=	0
NB_COMPIL			:=	0
TOTAL_COMPIL		:=	$(words $(OBJS))

#=====================================RULES====================================#
all: $(BIN_DIR)/$(NAME)

$(DIRS):
	@mkdir -p $@

$(BUILD_DIR)/%.o : srcs/%.cpp | $$(@D)
	$(if $(filter $(NB_COMPIL),0), @echo "$(BLUE)Compiling$(NOC)")
	$(eval NB_COMPIL=$(shell expr $(NB_COMPIL) + 1))
	$(eval PERCENT=$(shell echo $$(($(NB_COMPIL) * 100 / $(TOTAL_COMPIL)))))
	@if [ $(PERCENT) -lt 10 ]; then echo -n "[  $(PERCENT)%]"; elif [ $(PERCENT) -lt 100 ]; then echo -n "[ $(PERCENT)%]"; else echo -n "[$(PERCENT)%]"; fi
	@echo " $(PURPLE)Building $<$(NOC)"
	@$(CC) $(CFLAGS) -c $< -o $@

$(BIN_DIR)/$(NAME): $(OBJS)
	@echo "$(BLUE)Creation of binary$(NOC)"
	@mkdir -p $(BIN_DIR)
	@$(CC) -o $@ $(INCLUDE) $^ $(SDL_FLAGS)
	@echo "$(GREEN)Done$(NOC)"

clean:
	@echo "$(RED)Deleting objects$(NOC)"
	@rm -rf $(BUILD_DIR)

fclean: clean
	@echo "$(RED)Deleting binary$(NOC)"
	@rm -f $(BIN_DIR)/$(NAME)

re: clean
	@make $(BIN_DIR)/$(NAME)

run: $(BIN_DIR)/$(NAME)
	@echo "$(BLUE)Launch game$(NOC)"
	@cd $(BIN_DIR); ./$(NAME)
	@echo "$(GREEN)Have a nice day :)$(NOC)"

build-linux :
	@echo "$(BLUE)Create a build for linux$(NOC)"
	@rm -rf build_linux
	@mkdir build_linux
	@mkdir build_linux/bin
	@echo "./bin/$(NAME)" > build_linux/run_game.sh
	@chmod 744 build_linux/run_game.sh
	@echo "$(PURPLE)Compiling...$(NOC)"
	@$(CC) $(CFLAGS) -o build_linux/bin/$(NAME) $(INCLUDE) $(SRCS) $(SDL_FLAGS)
	@cp -r data build_linux/data
	@echo "$(GREEN)Done$(NOC)"

build-windows :
	@echo "$(BLUE)Create a build for windows$(NOC)"
	@rm -rf build_windows
	@mkdir build_windows
	@mkdir build_windows/bin
	@echo "@echo off" > build_windows/run_game.bat
	@echo "title Run game" >> build_windows/run_game.bat
	@echo "cd bin" >> build_windows/run_game.bat
	@echo "$(NAME).exe" >> build_windows/run_game.bat
	@echo "$(PURPLE)Compiling...$(NOC)"
	@x86_64-w64-mingw32-g++ $(CFLAGS) -o build_windows/bin/$(NAME).exe \
		$(INCLUDE) $(SRCS) -lmingw32 $(SDL_FLAGS_WINDOWS)
	@cp -r data build_windows/data
	@cp SDL2/bin/SDL2.dll build_windows/bin/SDL2.dll
	@cp SDL2/bin/SDL2_image.dll build_windows/bin/SDL2_image.dll
	@cp SDL2/bin/SDL2_mixer.dll build_windows/bin/SDL2_mixer.dll
	@cp SDL2/bin/SDL2_ttf.dll build_windows/bin/SDL2_ttf.dll
	@echo "$(GREEN)Done$(NOC)"

.PHONY: clean fclean re run build-linux build-windows
