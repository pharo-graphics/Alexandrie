# Dependencies

The dynamic libraries provided by the Pharo VM satisfy the project needs in all major platforms (Mac, Linux and Windows). This is true after [this release of Pharo VM](https://github.com/pharo-project/pharo-vm/releases/tag/v9.0.21). These are the versions:
- Cairo: 1.17.4
- FreeType: 2.12.1
- Harfbuzz: 5.3.1
- SDL2: 2.30.6

You can find the library versions by printing the result of the following expression:
```smalltalk
{ #Cairo -> AeCairoLibrary uniqueInstance versionString.
  #Freetype -> AeFTLibrary newInitialized versionString.
  #Harfbuzz -> AeHarfbuzzLibrary uniqueInstance versionString.
  #SDL2 -> SDL2 version versionString } asOrderedDictionary
```

## Updating libraries locally

The following notes show how to try the most recent Cairo, Freetype and Harfbuzz libraries on your system. We miss SDL2 library; please read about SDL2 at the final of this document.

**Mac/Linux**

Follow the following steps on Mac, or adapt them to Linux. In a terminal:

1. On Linux, install harfbuzz either with apt or your distro's way to do it. On Mac, you can use the [Harfbuzz formulae](https://formulae.brew.sh/formula/harfbuzz#default) to get it (`brew install harfbuzz` or get latest with `brew upgrade` if you already have them installed). Harfbuzz depends on all our dependencies so this is ensures everything needed is installed and updated.
2. Create a directory and download Pharo 12: `curl https://get.pharo.org/120+vmLatest | bash`
3. In the same directory, create a copy of the VM that doesn't have these libraries (to force Pharo find the system libraries):
```bash
cp -r pharo-vm pharo-vm-nolibs

for LIB_PREFIX in libpng libpixman libharfbuzz libfreetype libfontconfig libcairo
do 
  rm -v pharo-vm-nolibs/Pharo.app/Contents/MacOS/Plugins/${LIB_PREFIX}*dylib  
done
```
4. Open Pharo with: `./pharo-vm-nolibs/Pharo.app/Contents/MacOS/Pharo Pharo.image`
5. Done. Check current versions with the versions expression shown before in this document.


You can run some benchmarks before/after. For example, the benchmakrs in https://github.com/pharo-graphics/BlocBenchs
This is an example of how to run benchmarks from Terminal:
```bash
./pharo-vm/Pharo.app/Contents/MacOS/Pharo --headless Pharo.image eval "AeBenchFigureGridRunner new run"
./pharo-vm-nolibs/Pharo.app/Contents/MacOS/Pharo --headless Pharo.image eval "AeBenchFigureGridRunner new run"
```

**Windows**

Download the zip bundle of [latest Harfbuzz release](https://github.com/harfbuzz/harfbuzz/releases).
Copy `pharo-vm` as `pharo-vm-nolibs` and uncompress the zip into it. Replace files! (this is key).
Open Pharo with the new libs with `./pharo-vm-nolibs/Pharo.exe Pharo.image`.

WARNING: Harfbuzz-Freetype doesn't work.

---

SDL2
----

Update the SDL2 library similarly to Cairo and other libraries. First, build or install the SDL2 library as explained in https://wiki.libsdl.org/SDL2/Installation. On Mac, the [Homebrew formulae](https://formulae.brew.sh/formula/sdl2) works well. On Windows, you can download the SDL2 library [from here](https://github.com/libsdl-org/SDL/releases/latest).
