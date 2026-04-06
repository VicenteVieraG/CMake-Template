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
#### MinGW
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

### Clang-Tidy
This template includes an opt-in root `.clang-tidy` configuration. You can enable `clang-tidy` during the build with:

```shell
cmake -S . -B build -DENABLE_CLANG_TIDY=ON
cmake --build build
```

Only targets that explicitly call `target_enable_clang_tidy(<target>)` are analyzed.

If you prefer to analyze every C/C++ target without adding per-target calls, enable the global mode:

```shell
cmake -S . -B build -DENABLE_CLANG_TIDY=ON -DENABLE_CLANG_TIDY_GLOBAL=ON
cmake --build build
```

## Advanced Features
The template ships with reusable CMake utility modules under [`cmake/`](cmake/) and a set of root options in [`CMakeLists.txt`](CMakeLists.txt) that let you enable tooling, diagnostics, and build optimizations.

### Root CMake options (`CMakeLists.txt`)
Use these options at configure time (for example with `-D<OPTION>=ON`):

| Option | Default | Description |
| --- | --- | --- |
| `BUILD_TESTS` | `OFF` | Enables the test tree and CTest integration (`enable_testing()`). |
| `BUILD_TESTS_WITH_MAIN` | `ON` | Builds Catch2 tests with a custom `main` function (used by the tests subtree). |
| `ENABLE_CLANG_TIDY` | `OFF` | Enables clang-tidy support for targets using `target_enable_clang_tidy(<target>)`. |
| `ENABLE_CLANG_TIDY_GLOBAL` | `OFF` | Enables clang-tidy for all C/C++ targets globally (requires `ENABLE_CLANG_TIDY=ON`). |
| `ENABLE_WARNINGS` | `ON` | Includes compiler warning helpers and allows applying warning profiles to targets. |
| `ENABLE_WARNINGS_AS_ERRORS` | `OFF` | Promotes warnings to errors when used with warning helpers. |
| `ENABLE_SANITIZERS` | `OFF` | Enables compiler/linker sanitizer flags through the sanitizer utility module. |
| `SANITIZER_PRESET` | `default` | Selects sanitizer profile: `default`, `thread`, `memory`, `leak`. |
| `ENABLE_LTO_GLOBALY` | `OFF` | Enables IPO/LTO globally for `Release` and `RelWithDebInfo` when supported. |

### Utility modules in `cmake/`

#### `cmake/ClangTidy.cmake`
- `target_enable_clang_tidy(<target>)`: Applies clang-tidy to one target when `ENABLE_CLANG_TIDY=ON`.
- `enable_global_clang_tidy()`: Activates `CMAKE_C_CLANG_TIDY` and `CMAKE_CXX_CLANG_TIDY` for all targets when global mode is enabled.
- Validates arguments/targets and fails fast if `clang-tidy` is requested but not installed.

#### `cmake/Warnings.cmake`
- `target_set_warnings(<target> <enabled> <enabled_as_errors>)`: Applies warning presets per compiler.
- Uses:
  - MSVC: `/W4`, `/permissive-`, and optionally `/WX`
  - Clang/GCC: `-Wall`, `-Wextra`, `-Wpedantic`, and optionally `-Werror`

#### `cmake/Sanitizer.cmake`
- `enable_sanitizers()`: Enables compile and link sanitizer flags based on compiler and `SANITIZER_PRESET`.
- Supported presets:
  - `default` (MSVC: `address`; Clang/GCC: `address`, `undefined`)
  - `thread` (Clang/GCC)
  - `memory` (Clang)
  - `leak` (Clang/GCC)

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

Enable global IPO/LTO for release-like builds:
```shell
cmake -S . -B build -DENABLE_LTO_GLOBALY=ON
```
