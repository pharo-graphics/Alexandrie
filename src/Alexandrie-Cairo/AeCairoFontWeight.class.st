"
I am a Cairo FFI binding for `cairo_font_weight_t`.

Specifies variants of a font face based on their weight.

See: https://www.cairographics.org/manual/cairo-text.html#cairo-font-weight-t
"
Class {
	#name : #AeCairoFontWeight,
	#superclass : #AeEnumeration,
	#classVars : [
		'CAIRO_FONT_WEIGHT_BOLD',
		'CAIRO_FONT_WEIGHT_NORMAL'
	],
	#category : #'Alexandrie-Cairo-Enumerations'
}

{ #category : #'accessing enum' }
AeCairoFontWeight class >> CAIRO_FONT_WEIGHT_BOLD [
	"This method was automatically generated"
	^ CAIRO_FONT_WEIGHT_BOLD
]

{ #category : #'accessing enum' }
AeCairoFontWeight class >> CAIRO_FONT_WEIGHT_NORMAL [
	"This method was automatically generated"
	^ CAIRO_FONT_WEIGHT_NORMAL
]

{ #category : #'accessing enum' }
AeCairoFontWeight class >> bold [

	^ CAIRO_FONT_WEIGHT_BOLD
]

{ #category : #'enum declaration' }
AeCairoFontWeight class >> enumDecl [
	"
	self rebuildEnumAccessors
	"

	^ #(
		CAIRO_FONT_WEIGHT_NORMAL 0
		CAIRO_FONT_WEIGHT_BOLD 1
	)
]

{ #category : #'accessing enum' }
AeCairoFontWeight class >> normal [

	^ CAIRO_FONT_WEIGHT_NORMAL
]

{ #category : #hook }
AeCairoFontWeight class >> underlinedNamePrefix [
	
	^ 'CAIRO_FONT_WEIGHT_'
]
