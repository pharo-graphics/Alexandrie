Class {
	#name : #AeCairoJoinStyle,
	#superclass : #AeEnumeration,
	#classVars : [
		'CAIRO_LINE_JOIN_BEVEL',
		'CAIRO_LINE_JOIN_MITER',
		'CAIRO_LINE_JOIN_ROUND'
	],
	#category : #'Alexandrie-FFI-Enumerations'
}

{ #category : #'accessing enum' }
AeCairoJoinStyle class >> CAIRO_LINE_JOIN_BEVEL [
	"This method was automatically generated"
	^ CAIRO_LINE_JOIN_BEVEL
]

{ #category : #'accessing enum' }
AeCairoJoinStyle class >> CAIRO_LINE_JOIN_MITER [
	"This method was automatically generated"
	^ CAIRO_LINE_JOIN_MITER
]

{ #category : #'accessing enum' }
AeCairoJoinStyle class >> CAIRO_LINE_JOIN_ROUND [
	"This method was automatically generated"
	^ CAIRO_LINE_JOIN_ROUND
]

{ #category : #'enum declaration' }
AeCairoJoinStyle class >> enumDecl [
	"
	self rebuildEnumAccessors
	"

	^ #(
		CAIRO_LINE_JOIN_MITER 0
		CAIRO_LINE_JOIN_ROUND 1
		CAIRO_LINE_JOIN_BEVEL 2
	)
]
