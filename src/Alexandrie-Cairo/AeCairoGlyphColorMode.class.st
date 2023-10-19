"
I am a Cairo FFI binding for `cairo_color_mode_t`.

Specifies if color fonts are to be rendered using the color glyphs or outline glyphs. Glyphs that do not have a color presentation, and non-color fonts are not affected by this font option.

Members:
* `CAIRO_COLOR_MODE_DEFAULT`: Use the default color mode for font backend and target device, since 1.18.
* `CAIRO_COLOR_MODE_NO_COLOR`: Disable rendering color glyphs. Glyphs are always rendered as outline glyphs, since 1.18.
* `CAIRO_COLOR_MODE_COLOR`: Enable rendering color glyphs. If the font contains a color presentation for a glyph, and when supported by the font backend, the glyph will be rendered in color, since 1.18.

See: https://www.cairographics.org/manual/cairo-cairo-font-options-t.html#cairo-color-mode-t
"
Class {
	#name : #AeCairoGlyphColorMode,
	#superclass : #AeEnumeration,
	#classVars : [
		'CAIRO_COLOR_MODE_COLOR',
		'CAIRO_COLOR_MODE_DEFAULT',
		'CAIRO_COLOR_MODE_NO_COLOR'
	],
	#category : #'Alexandrie-Cairo-Enumerations'
}

{ #category : #'accessing enum' }
AeCairoGlyphColorMode class >> CAIRO_COLOR_MODE_COLOR [
	"This method was automatically generated"
	^ CAIRO_COLOR_MODE_COLOR
]

{ #category : #'accessing enum' }
AeCairoGlyphColorMode class >> CAIRO_COLOR_MODE_DEFAULT [
	"This method was automatically generated"
	^ CAIRO_COLOR_MODE_DEFAULT
]

{ #category : #'accessing enum' }
AeCairoGlyphColorMode class >> CAIRO_COLOR_MODE_NO_COLOR [
	"This method was automatically generated"
	^ CAIRO_COLOR_MODE_NO_COLOR
]

{ #category : #'accessing enum camelcased' }
AeCairoGlyphColorMode class >> color [

	^ self CAIRO_COLOR_MODE_COLOR
]

{ #category : #'accessing enum camelcased' }
AeCairoGlyphColorMode class >> default [

	^ self CAIRO_COLOR_MODE_DEFAULT
]

{ #category : #'enum declaration' }
AeCairoGlyphColorMode class >> enumDecl [
	"
	self rebuildEnumAccessors
	"

	^ #(
		CAIRO_COLOR_MODE_DEFAULT 0
		CAIRO_COLOR_MODE_NO_COLOR 1
		CAIRO_COLOR_MODE_COLOR 2
		)
]

{ #category : #'accessing enum camelcased' }
AeCairoGlyphColorMode class >> noColor [

	^ self CAIRO_COLOR_MODE_NO_COLOR
]

{ #category : #hook }
AeCairoGlyphColorMode class >> underlinedNamePrefix [

	^ 'CAIRO_COLOR_MODE_'
]
