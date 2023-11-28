"
I am a Cairo FFI binding for `cairo_content_t`.

It is used to describe the content that a surface will contain, whether color information, alpha information (translucence vs. opacity), or both.

Members:

- `CAIRO_CONTENT_COLOR`: The surface will hold color content only.
- `CAIRO_CONTENT_ALPHA`: The surface will hold alpha content only.
- `CAIRO_CONTENT_COLOR_ALPHA`: The surface will hold color and alpha content.

See: https://cairographics.org/manual/cairo-cairo-surface-t.html#cairo-content-t
"
Class {
	#name : #AeCairoContent,
	#superclass : #AeEnumeration,
	#classVars : [
		'CAIRO_CONTENT_ALPHA',
		'CAIRO_CONTENT_COLOR',
		'CAIRO_CONTENT_COLOR_ALPHA'
	],
	#category : #'Alexandrie-Cairo-Context'
}

{ #category : #'accessing enum' }
AeCairoContent class >> CAIRO_CONTENT_ALPHA [
	"This method was automatically generated"
	^ CAIRO_CONTENT_ALPHA
]

{ #category : #'accessing enum' }
AeCairoContent class >> CAIRO_CONTENT_COLOR [
	"This method was automatically generated"
	^ CAIRO_CONTENT_COLOR
]

{ #category : #'accessing enum' }
AeCairoContent class >> CAIRO_CONTENT_COLOR_ALPHA [
	"This method was automatically generated"
	^ CAIRO_CONTENT_COLOR_ALPHA
]

{ #category : #'accessing enum' }
AeCairoContent class >> alphaOnly [

	^ CAIRO_CONTENT_ALPHA
]

{ #category : #'accessing enum' }
AeCairoContent class >> colorAndAlpha [

	^ CAIRO_CONTENT_COLOR_ALPHA
]

{ #category : #'accessing enum' }
AeCairoContent class >> colorOnly [

	^ CAIRO_CONTENT_COLOR
]

{ #category : #'enum declaration' }
AeCairoContent class >> enumDecl [
	"
	self rebuildEnumAccessors
	"

	^ #(
		CAIRO_CONTENT_COLOR 16r1000
		CAIRO_CONTENT_ALPHA 16r2000
		CAIRO_CONTENT_COLOR_ALPHA 16r3000
	)
]

{ #category : #hook }
AeCairoContent class >> underlinedNamePrefix [

	^ 'CAIRO_CONTENT_'
]
