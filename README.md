# CMake Template Project
A ready-to-use C/C++ CMake project template. This template includes a professional, scalable and intuitive folder structure with all the required features to create end-to-end applications. The template contains a main.cpp file ready to be used as a starting point for your project.

## Usage
Create a new project from GitHub and use this repository as a template. You can also copy or clone the code into your computer, delete the .git file and create a new repository with the template. In either case, if you want to enable tests with the Cath2 default template integration, you will need to include it as a git submodule from the .gitmodules file:
```bash
git submodule update --init --recursive
```

## Features
- Application entry point [main file](./app/main.cpp) working out of the box.
- Catch2 tests integrated with CTest ready to start writing tests in file [tests/main.cpp](./tests/main.cpp).
- Doxigen documentation building with CMake CI pipeline.
- Clang-tidy linting at build time.
- Graphviz dependencies visualization.
- A set of useful .cmake files with utility functions to enable advanced features.
- Advanced features easily enabled from the root [CMakeLists.txt](./CMakeLists.txt) file.
- Professional, scalable and intuitive folder structure for any kind of project.

## Folder Structure
This template features a professional folder structure. It is solid enough to handle any kind of projects, from small and personal ones, to professional and enterprise ones. At the same time, it is ergonomic and intuitive for anyone to understand it right-away:

```Text
Root Folder/
├── app/
│   ├── CMakeLists.txt
│   └── main.cpp
├── cmake/
│   ├── AddGitSubmodule.cmake
│   ├── ClangTidy.cmake
│   ├── Docs.cmake
│   ├── LTO.cmake
│   ├── Sanitizer.cmake
│   └── Warnings.cmake
├── config/
│   ├── CMakeLists.txt
│   └── config.hpp.in
├── Docs/
│   └── Doxyfile
├── external/
│   └── CMakeLists.txt
├── includes/
│   └── CMakeLists.txt
├── src/
│   └── CMakeLists.txt
├── tests/
│   ├── catch2 (git submodule)/
│   │   └── ...
│   ├── CMakeLists.txt
│   └── main.cpp
├── .clang-tidy
├── .gitignore
├── .gitmodules
├── CMakeLists.txt
├── LICENSE
├── Makefile
└── README.md
```
> Folder structure diagram created with [Tree](https://tree.nathanfriend.io).

## Dependencies
This template requires some dependencies to be installed in your system before building the project.

The easiest way to install these dependencies is using a package manager. Here are my preferred package managers, but feel free to use anyone you want, or even install them manually.
- [APT](https://wiki.debian.org/Apt)
- [Scoop](https://scoop.sh)
- [Winget](https://learn.microsoft.com/en-us/windows/package-manager/winget/)
- [Chocolately](https://community.chocolatey.org)

### CMake
CMake is the build system and base of the template. A build system is a tool for automating the process of building a project. It handles the compilation of source code, linking of libraries, and other tasks required to create an executable or library.

You can install CMake in different ways:
- __apt__
  ```bash
  sudo apt update
  sudo apt install cmake -y
  ```
- __Scoop__
  ```shell
  scoop bucket add main
  scoop install main/cmake
  ```
- __Winget__
  ```shell
  winget install -e --id Kitware.CMake
  ```
- __Chocolately__
  ```shell
  choco install cmake
  ```
- __Manual installation__
  - [CMake official web page](https://cmake.org/download/)

### Toolchains/Compilers
CMake requires a build kit to create all the necessary files, folders and configurations for the project. The build kits include a C/C++ compiler, linker, debugger and other tools that are necessary for the project to be built.

#### MinGW (Windows Only)
- __Scoop__
  ```shell
    scoop bucket add main
    scoop install main/mingw
  ```
- __Chocolately__
  ```shell
    choco install mingw
  ```
- __Manual installation__
  - [Official website](https://www.mingw-w64.org)

#### Clang (LLVM)
- __apt__
  ```bash
  sudo apt update
  sudo apt install clang clangd -y
  ```
- __Scoop__
  ```shell
    scoop bucket add main
    scoop install main/llvm
  ```
- __Winget__
  ```shell
  winget install -e --id LLVM.LLVM
  ```
- __Chocolately__
  ```shell
    choco install llvm
  ```
- __Manual installation__
  - [Official website](https://clang.llvm.org)

#### MSCV (Windows Only)
This build kit can only be installed through the Visual Studio installer. You need to install Visual Studio and select the descktop development with C++ workload or manually select the MSVC package in the Visual Studio installer.
- Download Visual Studio
  - Winget
    ```shell
      winget install -e --id Microsoft.VisualStudio.2022.Community.Preview
    ```
  - [Visual Studio official website](https://visualstudio.microsoft.com/es/downloads/)

### Clang-Tidy (Optional)
Linter for C/C++ source files. This template include an option to enable global or per-target Clang-tidy linter analisys.
- __apt__
  ```bash
  sudo apt update
  sudo apt install clang-tidy -y
  ```
- included in [LLVM toolchain](#clang-llvm) for Windows.

### Doxygen (Optional)
Documentation generated automaticly from comments in code. It generates a wiki web page with all the documentation from the project.
- __apt__
  ```bash
  sudo apt update
  sudo apt install doxygen -y
  ```
- __Scoop__
  ```shell
  scoop install doxygen
  ```
- __Winget__
  ```shell
  winget install -e --id DimitriVanHeesch.Doxygen
  ```
- __Chocolately__
  ```shell
  choco install doxygen.install
  ```
- __Manual Instalation__
  [Link to official web page](https://www.doxygen.nl/index.html)

## Advanced Features
