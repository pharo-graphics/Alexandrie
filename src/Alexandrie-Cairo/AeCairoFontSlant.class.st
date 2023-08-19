"
I am a Cairo FFI binding for `cairo_font_slant_t`.

Specifies variants of a font face based on their slant.

See: https://www.cairographics.org/manual/cairo-text.html#cairo-font-slant-t
"
Class {
	#name : #AeCairoFontSlant,
	#superclass : #AeEnumeration,
	#classVars : [
		'CAIRO_FONT_SLANT_ITALIC',
		'CAIRO_FONT_SLANT_NORMAL',
		'CAIRO_FONT_SLANT_OBLIQUE'
	],
	#category : #'Alexandrie-Cairo-Enumerations'
}

{ #category : #'accessing enum' }
AeCairoFontSlant class >> CAIRO_FONT_SLANT_ITALIC [
	"This method was automatically generated"
	^ CAIRO_FONT_SLANT_ITALIC
]

{ #category : #'accessing enum' }
AeCairoFontSlant class >> CAIRO_FONT_SLANT_NORMAL [
	"This method was automatically generated"
	^ CAIRO_FONT_SLANT_NORMAL
]

{ #category : #'accessing enum' }
AeCairoFontSlant class >> CAIRO_FONT_SLANT_OBLIQUE [
	"This method was automatically generated"
	^ CAIRO_FONT_SLANT_OBLIQUE
]

{ #category : #'enum declaration' }
AeCairoFontSlant class >> enumDecl [
	"
	self rebuildEnumAccessors
	"

	^ #(
		CAIRO_FONT_SLANT_NORMAL 0
		CAIRO_FONT_SLANT_ITALIC 1
		CAIRO_FONT_SLANT_OBLIQUE 2
	)
]

{ #category : #'accessing enum' }
AeCairoFontSlant class >> italic [

	^ CAIRO_FONT_SLANT_ITALIC
]

{ #category : #'accessing enum' }
AeCairoFontSlant class >> normal [

	^ CAIRO_FONT_SLANT_NORMAL
]

{ #category : #'accessing enum' }
AeCairoFontSlant class >> oblique [

	^ CAIRO_FONT_SLANT_OBLIQUE
]

{ #category : #hook }
AeCairoFontSlant class >> underlinedNamePrefix [
	
	^ 'CAIRO_FONT_SLANT_'
]
