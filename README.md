# Alexandrie

[![License](https://img.shields.io/github/license/pharo-graphics/Alexandrie.svg)](./LICENSE)
[![Tests](https://github.com/pharo-graphics/Alexandrie/actions/workflows/test.yml/badge.svg)](https://github.com/pharo-graphics/Alexandrie/actions/workflows/test.yml)

A 2D canvas for [Pharo](https://pharo.org/) based on [Cairo](https://www.cairographics.org).

It was born as an alternative for rendering [Bloc](https://github.com/pharo-graphics/Bloc) elements, but it is independent from Bloc.

**Note:** The canvas API is unstable yet. We started coding it by following the ideas written below, but in a next version the API will take better and more stable shape.

### FFI bindings

This project includes FFI bindings to Cairo and FreeType that do not depend on the bindings that exist in Pharo. 

**What's different?**

- Document Pharo code to ease a developer to link with the C API counterpart. 
- Offer direct access to the raw C API of the bound libraries. (See note below)
- Cairo: 
  - Focus on using the Cairo API smartly, avoiding redundant calls and early OO abstractions.
  - It doesn't rely on the "Surface Plugin", like Sparta-Cairo, unlike Athens-Cairo.
- FreeType:
  - Only cover a small subset of the FreeType API that Cairo needs to draw text.
  - Support color bitmap fonts (emoji)

**Note for Pharo newcomers:**

Using this bindings, a developer should be able to follow a C tutorial and easily translate the code to Pharo.
Tip: To find how a C API function is bound in Pharo, you can copy the function name in the official documentation or the tutorial, paste it on any Pharo text editor, right click and select "Method source with it" in the context menu. If there is a method with that name, then start browsing the class, senders, etc. to learn how to use it. If no method contains it, then you can add it by yourself "by example": find a similar bidning to another FFI call and it is often simple.


## Testing

The project counts with Test packages that pixel-compare the actual output of the render with PNGs previously exported in the 'tests/' directory of this repo. If any pixel doesn't match with the expected output, the test fails. Browse `AeCanvasTest`. To run such tests, the `AeFilesystemResources` will look into the registered Iceberg repositories for one named 'Alexandrie' (case-insensitive). This means that the test will ERROR if the repository is not registered at Iceberg. Normally the repository is registered after Metacello load. But it was not the case on the CI jobs (via smalltalk-ci), and that's why the '.ci.ston' executes a pre-install code (located in the 'scripts/' directory) that adds registers the repository explicitely.


## Install

Load in a Pharo 11 (should work on previous versions of Pharo, too):

```smalltalk
Metacello new
        baseline: 'Alexandrie';
        repository: 'github://pharo-graphics/Alexandrie/src';
        load.
```

## About color bitmap fonts (emoji)

Apparently, FreeType >= 2.5 is required. These were tested and do work:
- Cairo 1.16.0
- FreeType 2.12.1

The Pharo 11 VM for Mac and Windows (as of August/2022) comes with Cairo 1.15.4 and FreeType 2.9.1 which don't support rendering this kind of fonts.
The VM for linux doesn't bring them, so Pharo looks at the shared libraries. In the case of Ubuntu 22.04, the lib versions were recent enough.

**On Mac**, those libraries could be installed together as dependencies of gtk3.
It could be done with:
- https://formulae.brew.sh/formula/gtk+3
- https://ports.macports.org/port/gtk3

And then:
1. cd pharo-vm/Pharo.app/Contents/MacOS/Plugins/
2. rm libcairo.* libfreetype.* libpixman-1.* libpng12.*

**On Windows**, it wasn't tested yet


## License

This code is licensed under the [MIT license](./LICENSE).
