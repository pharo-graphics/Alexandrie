Class {
	#name : #AeCairoFreetypeSynthesize,
	#superclass : #AeEnumeration,
	#classVars : [
		'CAIRO_FT_SYNTHESIZE_BOLD',
		'CAIRO_FT_SYNTHESIZE_OBLIQUE'
	],
	#category : #'Alexandrie-FFI-Enumerations'
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
