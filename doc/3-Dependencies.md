The dynamic libraries provided by the Pharo VM satisfy the project needs in all major platforms (Mac, Linux and Windows). This is true after [this release of Pharo VM](https://github.com/pharo-project/pharo-vm/releases/tag/v9.0.21). These are the versions:
- Cairo: 1.17.4
- FreeType: 2.12.1
- Harfbuzz: 5.3.1

You can find the library versions by printing each of the following sentences:
```smalltalk
AeCairoLibrary uniqueInstance versionString.
AeFTLibrary newInitialized versionString.
AeHarfbuzzLibrary uniqueInstance versionString.
```

**Mac: Use system dependencies (brew)**

Follow the following steps on Mac, or adapt them to other system.

In a terminal:

1. Install latest dependencies with `brew install harfbuzz`, or get latest with `brew upgrade` if you already have them installed. Harfbuzz depends on all our dependencies so this is ensures everything needed is installed and updated.
2. In a directory, download Pharo 12: `curl https://get.pharo.org/120+vmLatest | bash`
3. Create a copy of the VM without the dependencies:
```bash
cp -r pharo-vm pharo-vm1

for LIB_PREFIX in libpng libpixman libharfbuzz libfreetype libfontconfig libcairo
do 
  rm -v pharo-vm1/Pharo.app/Contents/MacOS/Plugins/${LIB_PREFIX}*dylib  
done
```
4. Open image with: `./pharo-vm1/Pharo.app/Contents/MacOS/Pharo Pharo.image`
5. Inspect current versions with:
```smalltalk
{ AeCairoLibrary uniqueInstance versionString.
  AeFTLibrary newInitialized versionString.
  AeHarfbuzzLibrary uniqueInstance versionString } inspect
```
6. Run benchmarks (e.g. https://github.com/pharo-graphics/BlocBenchs)

To run benchmarks from Terminal (an example):
```bash
./pharo-vm/Pharo.app/Contents/MacOS/Pharo --headless Pharo.image eval "AeBenchFigureGridRunner new run"
./pharo-vm1/Pharo.app/Contents/MacOS/Pharo --headless Pharo.image eval "AeBenchFigureGridRunner new run"
```

**Windows: Use downloaded dependencies**

Adapt previous steps: 

Step 1 can be adapted to downloading and uncompressing [latest Harfbuzz release zip bundle](https://github.com/harfbuzz/harfbuzz/releases).
You will get DLLs for our dependencies (libpng, libpixman, libharfbuzz, libfreetype, libfontconfig, libcairo).
Place them in the same directory as the Pharo image, and the FFI library finder should find them.

Step 3 can translate to:
```bash
cp -r pharo-vm pharo-vm1
for LIB_PREFIX in libpng libpixman libharfbuzz libfreetype libfontconfig libcairo
do 
  rm -fv pharo-vm1/${LIB_PREFIX}*.dll
done
```bash
(In a Git Bash terminal)
