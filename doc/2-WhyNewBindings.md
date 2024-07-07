This project includes FFI bindings to Cairo and FreeType that do not depend on the bindings that exist in Pharo. 

Why rewriting the bindings? What's different?

- Document Pharo code to ease a developer to link with the C API counterpart. 
- Offer direct access to the raw C API of the bound libraries. (See note below)
- [Cairo](https://gitlab.freedesktop.org/cairo/cairo): 
  - Focus on using the Cairo API smartly, avoiding redundant calls and early OO abstractions.
  - It doesn't rely on the "Surface Plugin", like Sparta-Cairo, unlike Athens-Cairo.
- [FreeType](https://freetype.org/):
  - Only cover a small subset of the FreeType API that Cairo needs to draw text.
  - Support color bitmap fonts (emoji)

Additionally, we provide FFI bindings to a library that didn't had any support on Pharo yet: [Harfbuzz](https://harfbuzz.github.io/).
This library "converts a sequence of Unicode input into properly formatted and positioned glyph output—for any writing system and language."
With Harfbuzz, we get access to advanced information stored in font files, such as ligatures, that Cairo and FreeType don't get.

