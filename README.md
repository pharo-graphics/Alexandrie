# Alexandrie

[![License](https://img.shields.io/github/license/pharo-graphics/Alexandrie.svg)](./LICENSE)
[![Tests](https://github.com/pharo-graphics/Alexandrie/actions/workflows/test.yml/badge.svg)](https://github.com/pharo-graphics/Alexandrie/actions/workflows/test.yml)
[![Test ffi-minimal baseline group](https://github.com/pharo-graphics/Alexandrie/actions/workflows/test.ffi-minimal.yml/badge.svg)](https://github.com/pharo-graphics/Alexandrie/actions/workflows/test.ffi-minimal.yml)

This repository includes:
- [Pharo](https://pharo.org/) FFI bindings to [Cairo](https://www.cairographics.org), [FreeType](https://freetype.org/) and [Harfbuzz](https://harfbuzz.github.io/).
- A font manager that can scan filesystem for fonts files, and provide a simple selection API (extracted from Pharo's FT2 bindings)
- A 2D canvas (unstable) for drawing figures and text providing an abstraction layer on top of Cairo. It was born as an alternative for rendering [Bloc](https://github.com/pharo-graphics/Bloc) elements, but it is independent from Bloc.

Please check our [wiki](../../wiki) for more information.

## License

This code is licensed under the [MIT license](./LICENSE).
