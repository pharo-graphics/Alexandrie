Class {
	#name : #AeCairoExtendMode,
	#superclass : #AeEnumeration,
	#classVars : [
		'CAIRO_EXTEND_NONE',
		'CAIRO_EXTEND_PAD',
		'CAIRO_EXTEND_REFLECT',
		'CAIRO_EXTEND_REPEAT'
	],
	#category : #'Alexandrie-FFI-Enumerations'
}

{ #category : #'accessing enum' }
AeCairoExtendMode class >> CAIRO_EXTEND_NONE [
	"This method was automatically generated"
	^ CAIRO_EXTEND_NONE
]

{ #category : #'accessing enum' }
AeCairoExtendMode class >> CAIRO_EXTEND_PAD [
	"This method was automatically generated"
	^ CAIRO_EXTEND_PAD
]

{ #category : #'accessing enum' }
AeCairoExtendMode class >> CAIRO_EXTEND_REFLECT [
	"This method was automatically generated"
	^ CAIRO_EXTEND_REFLECT
]

{ #category : #'accessing enum' }
AeCairoExtendMode class >> CAIRO_EXTEND_REPEAT [
	"This method was automatically generated"
	^ CAIRO_EXTEND_REPEAT
]

{ #category : #'enum declaration' }
AeCairoExtendMode class >> enumDecl [
	"
	self rebuildEnumAccessors
	"

	^ #(
		CAIRO_EXTEND_NONE 0
		CAIRO_EXTEND_REPEAT 1
		CAIRO_EXTEND_REFLECT 2
		CAIRO_EXTEND_PAD 3
	)
]
