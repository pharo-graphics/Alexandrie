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
- [Cairo](https://gitlab.freedesktop.org/cairo/cairo): 
  - Focus on using the Cairo API smartly, avoiding redundant calls and early OO abstractions.
  - It doesn't rely on the "Surface Plugin", like Sparta-Cairo, unlike Athens-Cairo.
- [FreeType](https://freetype.org/):
  - Only cover a small subset of the FreeType API that Cairo needs to draw text.
  - Support color bitmap fonts (emoji)
- [Harfbuzz](https://harfbuzz.github.io/):
  - This library converts a sequence of Unicode input into properly formatted and positioned glyph output—for any writing system and language.
  - We make it available for users.
  - Bindings to this library didn't exist before in Pharo (not that we know!).


**Note for newcomers to Pharo FFI:**

Using this bindings, a developer should be able to follow a C tutorial and easily translate the code to Pharo.
Tip: To find how a C API function is bound in Pharo, you can copy the function name in the official documentation or the tutorial, paste it on any Pharo text editor, right click and select "Method source with it" in the context menu. If there is a method with that name, then start browsing the class, senders, etc. to learn how to use it. If no method contains it, then you can add it by yourself "by example": find a similar bidning to another FFI call and it is often simple.


## Testing

The project counts with Test packages that pixel-compare the actual output of the render with PNGs previously exported in the 'tests/' directory of this repo. If any pixel doesn't match with the expected output, the test fails. Browse `AeCanvasTest`. To run such tests, the `AeFilesystemResources` will look into the registered Iceberg repositories for one named 'Alexandrie' (case-insensitive). This means that the test will ERROR if the repository is not registered at Iceberg. Normally the repository is registered after Metacello load. But it was not the case on the CI jobs (via smalltalk-ci), and that's why the '.ci.ston' executes a pre-install code (located in the 'scripts/' directory) that adds registers the repository explicitely.


## Install

Load in a Pharo 11:

```smalltalk
Metacello new
        baseline: 'Alexandrie';
        repository: 'github://pharo-graphics/Alexandrie/src';
        load.
```

## Dependencies

The dynamic libraries provided by the Pharo VM satisfy the project needs in all major platforms (Mac, Linux and Windows). This is true after [this release of Pharo VM](https://github.com/pharo-project/pharo-vm/releases/tag/v9.0.21). These are the versions:
- Cairo: 1.17.4
- FreeType: 2.12.1
- Harfbuzz: 5.3.1

You can find the library versions by printing each of the following sentences:
```
AeCairoLibrary uniqueInstance versionString.
AeFTLibrary newInitialized versionString.
AeHarfbuzzLibrary uniqueInstance versionString.
```

## License

This code is licensed under the [MIT license](./LICENSE).
