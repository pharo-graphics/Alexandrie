"
I am a Cairo FFI binding for `cairo_antialias_t`.

Specifies the type of antialiasing to do when rendering text or shapes.

Members:

- `CAIRO_ANTIALIAS_DEFAULT`: Use the default antialiasing for the subsystem and target device, since 1.0
- `CAIRO_ANTIALIAS_NONE`: Use a bilevel alpha mask, since 1.0
- `CAIRO_ANTIALIAS_GRAY`: Perform single-color antialiasing (using shades of gray for black text on a white background, for example), since 1.0
- `CAIRO_ANTIALIAS_SUBPIXEL`: Perform antialiasing by taking advantage of the order of subpixel elements on devices such as LCD panels, since 1.0
- `CAIRO_ANTIALIAS_FAST`: Hint that the backend should perform some antialiasing but prefer speed over quality, since 1.12
- `CAIRO_ANTIALIAS_GOOD`: The backend should balance quality against performance, since 1.12
- `CAIRO_ANTIALIAS_BEST`: Hint that the backend should render at the highest quality, sacrificing speed if necessary, since 1.12

See: https://www.cairographics.org/manual/cairo-cairo-t.html#cairo-antialias-t
"
Class {
	#name : #AeCairoAntialias,
	#superclass : #AeEnumeration,
	#classVars : [
		'CAIRO_ANTIALIAS_BEST',
		'CAIRO_ANTIALIAS_DEFAULT',
		'CAIRO_ANTIALIAS_FAST',
		'CAIRO_ANTIALIAS_GOOD',
		'CAIRO_ANTIALIAS_GRAY',
		'CAIRO_ANTIALIAS_NONE',
		'CAIRO_ANTIALIAS_SUBPIXEL'
	],
	#category : #'Alexandrie-FFI-Enumerations'
}

{ #category : #'accessing enum' }
AeCairoAntialias class >> CAIRO_ANTIALIAS_BEST [
	"This method was automatically generated"
	^ CAIRO_ANTIALIAS_BEST
]

{ #category : #'accessing enum' }
AeCairoAntialias class >> CAIRO_ANTIALIAS_DEFAULT [
	"This method was automatically generated"
	^ CAIRO_ANTIALIAS_DEFAULT
]

{ #category : #'accessing enum' }
AeCairoAntialias class >> CAIRO_ANTIALIAS_FAST [
	"This method was automatically generated"
	^ CAIRO_ANTIALIAS_FAST
]

{ #category : #'accessing enum' }
AeCairoAntialias class >> CAIRO_ANTIALIAS_GOOD [
	"This method was automatically generated"
	^ CAIRO_ANTIALIAS_GOOD
]

{ #category : #'accessing enum' }
AeCairoAntialias class >> CAIRO_ANTIALIAS_GRAY [
	"This method was automatically generated"
	^ CAIRO_ANTIALIAS_GRAY
]

{ #category : #'accessing enum' }
AeCairoAntialias class >> CAIRO_ANTIALIAS_NONE [
	"This method was automatically generated"
	^ CAIRO_ANTIALIAS_NONE
]

{ #category : #'accessing enum' }
AeCairoAntialias class >> CAIRO_ANTIALIAS_SUBPIXEL [
	"This method was automatically generated"
	^ CAIRO_ANTIALIAS_SUBPIXEL
]

{ #category : #'enum declaration' }
AeCairoAntialias class >> enumDecl [
	"
	self rebuildEnumAccessors
	"

	^ #(
		CAIRO_ANTIALIAS_DEFAULT 0

		"method"
		CAIRO_ANTIALIAS_NONE 1
		CAIRO_ANTIALIAS_GRAY 2
		CAIRO_ANTIALIAS_SUBPIXEL 3

		"hints"
		CAIRO_ANTIALIAS_FAST 4
		CAIRO_ANTIALIAS_GOOD 5
		CAIRO_ANTIALIAS_BEST 6
	)
]
