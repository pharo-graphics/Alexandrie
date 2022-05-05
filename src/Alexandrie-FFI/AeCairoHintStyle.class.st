Class {
	#name : #AeCairoHintStyle,
	#superclass : #AeEnumeration,
	#classVars : [
		'CAIRO_HINT_STYLE_DEFAULT',
		'CAIRO_HINT_STYLE_FULL',
		'CAIRO_HINT_STYLE_MEDIUM',
		'CAIRO_HINT_STYLE_NONE',
		'CAIRO_HINT_STYLE_SLIGHT'
	],
	#category : #'Alexandrie-FFI-Enumerations'
}

{ #category : #'accessing enum' }
AeCairoHintStyle class >> CAIRO_HINT_STYLE_DEFAULT [
	"This method was automatically generated"
	^ CAIRO_HINT_STYLE_DEFAULT
]

{ #category : #'accessing enum' }
AeCairoHintStyle class >> CAIRO_HINT_STYLE_FULL [
	"This method was automatically generated"
	^ CAIRO_HINT_STYLE_FULL
]

{ #category : #'accessing enum' }
AeCairoHintStyle class >> CAIRO_HINT_STYLE_MEDIUM [
	"This method was automatically generated"
	^ CAIRO_HINT_STYLE_MEDIUM
]

{ #category : #'accessing enum' }
AeCairoHintStyle class >> CAIRO_HINT_STYLE_NONE [
	"This method was automatically generated"
	^ CAIRO_HINT_STYLE_NONE
]

{ #category : #'accessing enum' }
AeCairoHintStyle class >> CAIRO_HINT_STYLE_SLIGHT [
	"This method was automatically generated"
	^ CAIRO_HINT_STYLE_SLIGHT
]

{ #category : #'enum declaration' }
AeCairoHintStyle class >> enumDecl [
	"
	self rebuildEnumAccessors
	"

	^ #(
		CAIRO_HINT_STYLE_DEFAULT 0
		CAIRO_HINT_STYLE_NONE 1
		CAIRO_HINT_STYLE_SLIGHT 2
		CAIRO_HINT_STYLE_MEDIUM 3
		CAIRO_HINT_STYLE_FULL 4
	)
]
