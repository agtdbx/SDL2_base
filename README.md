# SDL2_Base
Repo servant de base a un projet C++ avec la SDL2.
De base le projet inclu SDL2_image, SDL2_mixer et SDL2_ttf

## Configuration
```
sudo apt install make g++ mingw-w64 unzip
make config
```
*Cela va installer make, g++, mingw-32 et git-lfs qui sont nécessaire au fonctionnement du projet*

## Environement
Le projet est séparant en plus fichiers :
 - .build -> C'est dans ce dossier qu'ira tous les .o et .d issu de la compilation
 - bin -> C'est dans ce dossier que ce trouvera l'éxécutable du projet
 - data -> C'est ici que vous pourrez mettre vos données pour le projet
 - include -> C'est le dossier où mettre ces headers (.h/.hpp)
 - SDL2 -> C'est le dossier des libs SDL2
 - srcs -> C'est ici que vous pouvez mettre tous vos fichiers sources (.cpp)

## Makefile
Un Makefile pour compiler un projet en C++ est déjà présent.

Vous pouvez changer le nom de l'éxécutable en modifiant la variable **NAME** ligne 19 du Makefile

Vous devez rajouter vos fichiers sources à la variable **SRCS** ligne 24 du Makefile

Pour compiler, tapez
```
make
```

Pour lancer le projet, tapez
```
make run
```

Vous pouvez retirer les .o et .d en tapant
```
make clean
```

Vous pouvez retirer les .o, .d et le binaire en tapant
```
make fclean
```

Vous pouvez recompiler tous le projets en tapant
```
make re
```

Vous pouvez créer une build pour linux, un dossier build_linux sera créer et contiendra votre projet.
```
make build-linux
```

Vous pouvez créer une build pour window, un dossier build_windows sera créer et contiendra votre projet.
```
make build-windows
```
