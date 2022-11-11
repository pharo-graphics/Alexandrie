"
I am a Cairo FFI binding for `cairo_ft_synthesize_t`.

A set of synthesis options to control how FreeType renders the glyphs for a particular font face.

See: https://www.cairographics.org/manual/cairo-FreeType-Fonts.html#cairo-ft-synthesize-t
"
Class {
	#name : #AeCairoFreetypeSynthesize,
	#superclass : #AeEnumeration,
	#classVars : [
		'CAIRO_FT_SYNTHESIZE_BOLD',
		'CAIRO_FT_SYNTHESIZE_OBLIQUE'
	],
	#category : #'Alexandrie-Cairo-Enumerations'
}

{ #category : #'accessing enum' }
AeCairoFreetypeSynthesize class >> CAIRO_FT_SYNTHESIZE_BOLD [
	"This method was automatically generated"
	^ CAIRO_FT_SYNTHESIZE_BOLD
]

{ #category : #'accessing enum' }
AeCairoFreetypeSynthesize class >> CAIRO_FT_SYNTHESIZE_OBLIQUE [
	"This method was automatically generated"
	^ CAIRO_FT_SYNTHESIZE_OBLIQUE
]

{ #category : #'enum declaration' }
AeCairoFreetypeSynthesize class >> enumDecl [
	"
	self rebuildEnumAccessors
	"

	^ #(
		CAIRO_FT_SYNTHESIZE_BOLD 1
		CAIRO_FT_SYNTHESIZE_OBLIQUE 2
	)
]

{ #category : #hook }
AeCairoFreetypeSynthesize class >> underlinedNamePrefix [
	
	^ 'CAIRO_FT_SYNTHESIZE_'
]
