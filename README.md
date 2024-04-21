# CMake Template Project
The aim of this project is to be a ready-to-use CMake template you can just jump directly into the code.
## Folder Structure
This template features a professional folder structure based in [CPM](https://github.com/VicenteVieraG/CPM)(An ongoing project of my own). This structure is solid enough to handle a project size from the most basic to highly complex and professional works. At the same time, the arquitecture is easy enough for anyone to understand it right away:
```
Root_Folder/
├── app/
│   ├── CMakeLists.txt
│   └── main.cpp
├── config/
│   ├── CMakeLists.txt
│   └── config.hpp.in
├── external/
│   └── CMakeLists.txt
├── include/
│   └── CMakeLists.txt
├── src/
│   └── CMakeLists.txt
├── .gitignore
├── CMakeLists.txt
└── README.md
```
> Folder structure diagram created with [Tree](https://tree.nathanfriend.io).
## Dependencies
### CMake
To build any CMake-based project CMake should be installed in your system. The latest version can be downloaded in different ways:
- Directly from the [CMake official web page](https://cmake.org/download/).
- Using a package mannager
  - [Scoop](https://scoop.sh)
  ```shell
    scoop bucket add main
    scoop install main/cmake
  ```
  - [Chocolately](https://community.chocolatey.org)
  ```shell
    choco install cmake
  ```
### A CMake Generator
A generator in CMake is the engine in charge of creating all the nesessary files and folders so that CMake can build the project. There are many, but I will reference some of the most widely used:
#### Ninja
#### MSVC