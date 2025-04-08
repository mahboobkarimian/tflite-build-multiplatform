### Update for multiple platforms
For v2.18.0: 
Either download from the build action artifacts, or fork this repo to run actions yourself.

### How to use
0. Download compiled tflite from releases. Get tensorflow source and **checkout to the version assigned to my release**.
1. Create a `CMakeLists.txt` for your project and link `tensorflowlite.dll.if.lib` to it. You also need `tensorflowlite.dll` for runtime.

2. Install tools
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
