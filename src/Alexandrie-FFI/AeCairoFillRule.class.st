Class {
	#name : #AeCairoFillRule,
	#superclass : #AeEnumeration,
	#classVars : [
		'CAIRO_FILL_RULE_EVEN_ODD',
		'CAIRO_FILL_RULE_WINDING'
	],
	#category : #'Alexandrie-FFI-Enumerations'
}

{ #category : #'accessing enum' }
AeCairoFillRule class >> CAIRO_FILL_RULE_EVEN_ODD [
	"This method was automatically generated"
	^ CAIRO_FILL_RULE_EVEN_ODD
]

{ #category : #'accessing enum' }
AeCairoFillRule class >> CAIRO_FILL_RULE_WINDING [
	"This method was automatically generated"
	^ CAIRO_FILL_RULE_WINDING
]

{ #category : #'enum declaration' }
AeCairoFillRule class >> enumDecl [
	"
	self rebuildEnumAccessors
	"

	^ #(
		CAIRO_FILL_RULE_WINDING 0
		CAIRO_FILL_RULE_EVEN_ODD 1
	)
]
