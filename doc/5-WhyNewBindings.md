# Why write new bindings for Cairo and Freetype?

This project includes FFI bindings to Cairo and FreeType that are independent from the bindings that existed in Pharo for years.
What's different in Alexandrie?

- In Athens-Cairo package there is no direct access to the raw [Cairo](https://gitlab.freedesktop.org/cairo/cairo) API: the bindings are tangled in the Athens model. This is not bad per se, but we needed more freedom to explore other ways to use the libraries' API.
- In addition, Athens-Cairo rely on the "Surface Plugin", and we want to avoid this dependency.
- We wanted to review the Pharo's bindings for [FreeType](https://freetype.org/). It's enough to cover a small subset of the FreeType API that Cairo needs to draw text.

Additionally, we provide FFI bindings to a library that didn't had any support on Pharo yet: [Harfbuzz](https://harfbuzz.github.io/).
This library "converts a sequence of Unicode input into properly formatted and positioned glyph output—for any writing system and language."
With Harfbuzz, we get access to advanced information stored in font files, such as ligatures, that Cairo and FreeType don't get.

