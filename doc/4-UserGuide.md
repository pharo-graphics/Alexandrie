One of the guiding ideas of Alexandrie is that, for a developer, it should straightforward to translate a C tutorial to Pharo.
A good example at this respect is `AeCairoMigratedRenderTest`, which contains original cairo tests translated to our bindings.

**Is there a binding for this function?** To find how a C API function is bound in Pharo, you can do these simple steps: 
1. copy the C name (either function name, type, struct, enum, etc.)
2. paste it on any Pharo text editor
3. right click and select "Method source with it" in the context menu.
If there is a method with that name, then start browsing the class, senders, etc. to learn how to use it.
If no method contains it, then you can add it by yourself "by example": find a similar binding to another FFI call. It is often simple.

Also, this browser can help to find FFI calls: https://github.com/tinchodias/FFICallBrowser .

**Documentation links.** Most FFI calls in this repository have a link in the method comment to read to original documentation. Check our code convention for more information.


## Learning

We created tests that can be good source of examples, such as `AeCairoExamplesRenderTest` and siblings. 
On these test suites, each method creates a surface and a context to draw.
Such tests can serve as a good starting point: copy the code into a Workspace and play with it.

However, it is hard to understand our examples in Pharo without grasping how the underlaying C library really works. The following are some recommended lectures at this respect:

Cairo:
* This is a good start to understand how cairo works: https://cairographics.org/tutorial/
* "Cookbook" examples: https://cairographics.org/cookbook/
* The API reference: https://cairographics.org/manual/index.html

Harfbuzz and FreeType:
They provide documentation in https://harfbuzz.github.io/ and https://freetype.org/

In general, downloading and browsing other user projects is a good source of examples of use:
- Pango: https://gitlab.gnome.org/GNOME/pango
- Harfbuzz CLI tools: https://harfbuzz.github.io/utilities.html#utilities-command-line-tools
- Mozilla's gecko-dev: https://github.com/mozilla/gecko-dev
- WebKit: https://github.com/WebKit/WebKit
- inkscape: https://gitlab.com/inkscape/inkscape
- GTK: https://gitlab.gnome.org/GNOME/gtk
- SDL_ttf: https://github.com/libsdl-org/SDL_ttf (Harfbuzz, FreeType, SDL)
