# CMake Template Project
A ready-to-use C/C++ CMake project template. This template includes a professional, scalabel and intuitive folder structure. The template includes a main.cpp file ready to be used as a starting point for your project. It also includes the necessary CMakeLists.txt files to build the project.
## Folder Structure
This template features a professional folder structure based in [CPM](https://github.com/VicenteVieraG/CPM) (An ongoing project of my own). This structure is solid enough to handle every kind of project, from small size to complex and professional sized code bases. At the same time, the arquitecture is easy enough for anyone to understand it right away:
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
This template requires some dependencies to be installed in your system before building the project.

The easiest way to install these dependencies is using a package manager. Here are my preferred package managers, but feel free to use anyone you want, or even install them manually.
- [Scoop](https://scoop.sh)
- [Chocolately](https://community.chocolatey.org)
### CMake
CMake is the build system and base of the template. A build system is a tool for automating the process of building a project. It handles the compilation of source code, linking of libraries, and other tasks required to create an executable or library.

You can install CMake in different ways:
- Directly from the [CMake official web page](https://cmake.org/download/).
- [Scoop](https://scoop.sh)
  ```shell
    scoop bucket add main
    scoop install main/cmake
  ```
- [Chocolately](https://community.chocolatey.org)
  ```shell
    choco install cmake
  ```
### Build kits
CMake requires a build kit to create all the necessary files, folders and configurations for the project. The build kits include a C/C++ compiler, linker, debugger and other tools that are necessary for the project to be built.
#### minGW
- [Scoop](https://scoop.sh)
  ```shell
    scoop bucket add main
    scoop install main/mingw
  ```
- [Chocolately](https://community.chocolatey.org)
  ```shell
    choco install mingw
  ```
- Manual installation
  - [Official website](https://www.mingw-w64.org)
#### Clang (LLVM)
- [Scoop](https://scoop.sh)
  ```shell
    scoop bucket add main
    scoop install main/llvm
  ```
- [Chocolately](https://community.chocolatey.org)
  ```shell
    choco install llvm
  ```
- Manual installation
  - [Official website](https://clang.llvm.org)
#### MSCV
This build kit can only be installed through the Visual Studio installer. You need to install Visual Studio and select the descktop development with C++ workload or manually select the MSVC package in the Visual Studio installer.
- Download Visual Studio
  - Winget
    ```shell
      winget install -e --id Microsoft.VisualStudio.2022.Community.Preview
    ```
  - [Visual Studio official website](https://visualstudio.microsoft.com/es/downloads/)