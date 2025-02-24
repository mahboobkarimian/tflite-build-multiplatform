### How to use
0. Create a `CMakeLists.txt` for your project and use `tensorflowlite.dll.if.lib` to link it to your code. You also need `tensorflowlite.dll` for runtime.

1. Install tools
```
choco install ninja -y
choco install cmake -y
choco install llvm -y
```
 
2. In cmd enter the next 2 lines, this will use clang (no MSVC):
```
$env:CC="C:\Program Files\LLVM\bin\clang.exe"
$env:CXX="C:\Program Files\LLVM\bin\clang++.exe"
```
 
3. make a `build` dir, cd into it and run:
```
cmake -S ./ -G Ninja ..
ninja
```
