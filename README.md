# SDL2_Base
This project is a base for C++ projet with SDL2.
This base contains SDL2_image, SDL2_mixer and SDL2_ttf

## Set-up
```
sudo apt install make g++ mingw-w64 zip
```
*This will install make, g++, mingw-32 and zip which are required for the projet*

## Environement
The projet is split in many subfolders :
 - .build -> This is the subfolder for .o and .d from compiling project
 - bin -> There is the place for the executable
 - data -> Here you can put every data required by your projet
 - log -> The log of the previous execution will be here
 - include -> This is the headers (.h/.hpp) subfolders
 - SDL2 -> SDL2 libs folder
 - srcs -> This is the place for your sources files (.cpp)

## Makefile
A Makefile for compiliong your project already exist.

You can change the executable name by change the value or the variable **NAME** at line 22 of Makefile

You can add your sources files at the variable **SRCS** line 28

You can change the display of compilation by change **DISPLAY** value at line 36;
With a value of ***PERCENTAGE*** you will have a percentage
With ***PROGRESS_BAR*** a value, you will have a progress bar
For any other value, you will have a counter

To compile
```
make
```

To run the project
```
make run
```

To remove .o et .d
```
make clean
```

To delete .o, .d and binary
```
make fclean
```

To recompile all files of the projet
```
make re
```

To create a build for linux in a build_linux folder
```
make build-linux
```

To create a build for windows in a build_linux build_windows
```
make build-windows
```

To create a global build in a build_linux build_windows
This will contains a build for linux, windows and theres compressed versions in .zip and .tar.gz
```
make build
```
