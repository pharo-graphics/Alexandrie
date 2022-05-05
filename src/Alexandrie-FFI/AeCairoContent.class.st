Class {
	#name : #AeCairoContent,
	#superclass : #AeEnumeration,
	#classVars : [
		'CAIRO_CONTENT_ALPHA',
		'CAIRO_CONTENT_COLOR',
		'CAIRO_CONTENT_COLOR_ALPHA'
	],
	#category : #'Alexandrie-FFI-Enumerations'
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
