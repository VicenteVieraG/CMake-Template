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
Linter for C/C++ source files. This template includes an option to enable per-target Clang-tidy analysis via `ENABLE_CLANG_TIDY`.
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
The template ships with reusable CMake utility modules under [`cmake/`](cmake/) and a set of root options in [`CMakeLists.txt`](CMakeLists.txt) that let you enable tooling, diagnostics, and build optimizations.

### Root CMake options (`CMakeLists.txt`)
Use these options at configure time (for example with `-D<OPTION>=ON`):

| Option                       | Default   | Description                                                                                                     |
| ---------------------------- | --------- | --------------------------------------------------------------------------------------------------------------- |
| `BUILD_TESTS`                | `OFF`     | Enables the test tree and CTest integration (`enable_testing()`).                                               |
| `BUILD_TESTS_WITH_MAIN`      | `OFF`      | Builds Catch2 tests with a custom `main` function (used by the tests subtree).                                  |
| `ENABLE_CLANG_TIDY`          | `OFF`     | Enables clang-tidy support for targets using `target_enable_clang_tidy(<target>)`.                              |
| `ENABLE_WARNINGS`            | `OFF`      | Enables compiler warning profiles for targets using `target_set_warnings(<target> <enabled_as_errors>)`.        |
| `ENABLE_WARNINGS_AS_ERRORS`  | `OFF`     | Promotes warnings to errors when used with `target_set_warnings()`.                                             |
| `ENABLE_SANITIZERS`          | `OFF`     | Enables sanitizer helpers so targets can opt into compiler/linker sanitizer flags.                              |
| `SANITIZER_PRESET`           | `default` | Default sanitizer profile used by `target_enable_sanitizers()`: `default`, `thread`, `memory`, `leak`.          |
| `ENABLE_LTO_GLOBALY`         | `OFF`     | Enables IPO/LTO globally for `Release` and `RelWithDebInfo` when supported.                                     |

### Utility modules in `cmake/`
#### `cmake/ClangTidy.cmake`
- `target_enable_clang_tidy(<target>)`: Applies clang-tidy to one target when `ENABLE_CLANG_TIDY=ON`.
- Configures both `C_CLANG_TIDY` and `CXX_CLANG_TIDY` target properties.
- Validates argument count and target existence, and fails fast if `clang-tidy` is requested but not installed.

#### `cmake/Warnings.cmake`
- `target_set_warnings(<target> <enabled_as_errors>)`: Applies warning presets per compiler when `ENABLE_WARNINGS=ON`.
- Uses:
  - MSVC: `/W4`, `/permissive-`, and optionally `/WX`
  - Clang/GCC: `-Wall`, `-Wextra`, `-Wpedantic`, and optionally `-Werror`

#### `cmake/Sanitizer.cmake`
- `target_enable_sanitizers(<target> [preset])`: Enables sanitizer flags for a specific target. Uses `SANITIZER_PRESET` by default or an explicit per-target preset when provided.
- Supported presets:
  - `default` (MSVC: `address`; Clang/GCC: `address`, `undefined`)
  - `thread` (Clang/GCC)
  - `memory` (Clang)
  - `leak` (Clang/GCC)
- Notes:
  - Executable, shared, module, and interface targets receive both compile and link flags.
  - Static and object libraries receive compile flags only, so the final linked target should also enable sanitizers.

#### `cmake/LTO.cmake`
- `target_enable_lto(<target>)`: Enables IPO/LTO for a specific target in `Release` and `RelWithDebInfo`.
- If `ENABLE_LTO_GLOBALY=ON`, enables IPO/LTO globally for supported toolchains.
- Uses `CheckIPOSupported` and emits a warning when the toolchain does not support IPO/LTO.

#### `cmake/Docs.cmake`
- Adds a `docs` custom target when Doxygen is available:
  - Runs Doxygen from `${CMAKE_SOURCE_DIR}/docs`
  - Generates HTML documentation as configured by your Doxygen project files.

#### `cmake/AddGitSubmodule.cmake`
- `add_git_submodule(<relative_dir>)`:
  - Initializes/updates a git submodule if needed.
  - Automatically calls `add_subdirectory()` when the submodule contains a `CMakeLists.txt`.

### Example advanced configurations

Enable warnings + warnings as errors:
```shell
cmake -S . -B build -DENABLE_WARNINGS=ON -DENABLE_WARNINGS_AS_ERRORS=ON
```

Enable sanitizers with the thread preset:
```shell
cmake -S . -B build -DENABLE_SANITIZERS=ON -DSANITIZER_PRESET=thread
```

Then opt targets into the configured sanitizer preset:
```cmake
target_enable_sanitizers(${CMAKE_PROJECT_NAME})
target_enable_sanitizers(tests leak)
```

Enable global IPO/LTO for release-like builds:
```shell
cmake -S . -B build -DENABLE_LTO_GLOBALY=ON
```
