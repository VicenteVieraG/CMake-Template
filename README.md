# CMake Template Proyect
The aim of this proyect is to be a ready-to-use CMake template you can just jump directly into the code.
## Folder Structure
This template features a professional folder structure based in [CPM](https://github.com/VicenteVieraG/CPM)(An ongoing proyect of my own). This structure is solid enough to handle a proyect size from the most basic to highly complex and professional works. At the same time, the arquitecture is easy enough for anyone to understand it right away:
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