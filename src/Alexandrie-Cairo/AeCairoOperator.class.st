"
I am a Cairo FFI binding for `cairo_operator_t`.

This enum represents the compositing operator for all cairo drawing operations.

The default operator is `CAIRO_OPERATOR_OVER`.

The operators marked as unbounded modify their destination even outside of the mask layer (that is, their effect is not bound by the mask layer). However, their effect can still be limited by way of clipping.

To keep things simple, the operator descriptions here document the behavior for when both source and destination are either fully transparent or fully opaque. The actual implementation works for translucent layers too.

See: https://cairographics.org/operators/
See: https://www.cairographics.org/manual/cairo-cairo-t.html#cairo-operator-t
See: `AeCairoExamplesRenderTest>>#surfaceWithAllOperators`
"
Class {
	#name : #AeCairoOperator,
	#superclass : #AeEnumeration,
	#classVars : [
		'CAIRO_OPERATOR_ADD',
		'CAIRO_OPERATOR_ATOP',
		'CAIRO_OPERATOR_CLEAR',
		'CAIRO_OPERATOR_COLOR_BURN',
		'CAIRO_OPERATOR_COLOR_DODGE',
		'CAIRO_OPERATOR_DARKEN',
		'CAIRO_OPERATOR_DEST',
		'CAIRO_OPERATOR_DEST_ATOP',
		'CAIRO_OPERATOR_DEST_IN',
		'CAIRO_OPERATOR_DEST_OUT',
		'CAIRO_OPERATOR_DEST_OVER',
		'CAIRO_OPERATOR_DIFFERENCE',
		'CAIRO_OPERATOR_EXCLUSION',
		'CAIRO_OPERATOR_HARD_LIGHT',
		'CAIRO_OPERATOR_HSL_COLOR',
		'CAIRO_OPERATOR_HSL_HUE',
		'CAIRO_OPERATOR_HSL_LUMINOSITY',
		'CAIRO_OPERATOR_HSL_SATURATION',
		'CAIRO_OPERATOR_IN',
		'CAIRO_OPERATOR_LIGHTEN',
		'CAIRO_OPERATOR_MULTIPLY',
		'CAIRO_OPERATOR_OUT',
		'CAIRO_OPERATOR_OVER',
		'CAIRO_OPERATOR_OVERLAY',
		'CAIRO_OPERATOR_SATURATE',
		'CAIRO_OPERATOR_SCREEN',
		'CAIRO_OPERATOR_SOFT_LIGHT',
		'CAIRO_OPERATOR_SOURCE',
		'CAIRO_OPERATOR_XOR'
	],
	#category : #'Alexandrie-Cairo-Enumerations'
}

{ #category : #'accessing enum' }
AeCairoOperator class >> CAIRO_OPERATOR_ADD [
	"This method was automatically generated"
	^ CAIRO_OPERATOR_ADD
]

{ #category : #'accessing enum' }
AeCairoOperator class >> CAIRO_OPERATOR_ATOP [
	"This method was automatically generated"
	^ CAIRO_OPERATOR_ATOP
]

{ #category : #'accessing enum' }
AeCairoOperator class >> CAIRO_OPERATOR_CLEAR [
	"This method was automatically generated"
	^ CAIRO_OPERATOR_CLEAR
]

{ #category : #'accessing enum' }
AeCairoOperator class >> CAIRO_OPERATOR_COLOR_BURN [
	"This method was automatically generated"
	^ CAIRO_OPERATOR_COLOR_BURN
]

{ #category : #'accessing enum' }
AeCairoOperator class >> CAIRO_OPERATOR_COLOR_DODGE [
	"This method was automatically generated"
	^ CAIRO_OPERATOR_COLOR_DODGE
]

{ #category : #'accessing enum' }
AeCairoOperator class >> CAIRO_OPERATOR_DARKEN [
	"This method was automatically generated"
	^ CAIRO_OPERATOR_DARKEN
]

{ #category : #'accessing enum' }
AeCairoOperator class >> CAIRO_OPERATOR_DEST [
	"This method was automatically generated"
	^ CAIRO_OPERATOR_DEST
]

{ #category : #'accessing enum' }
AeCairoOperator class >> CAIRO_OPERATOR_DEST_ATOP [
	"This method was automatically generated"
	^ CAIRO_OPERATOR_DEST_ATOP
]

{ #category : #'accessing enum' }
AeCairoOperator class >> CAIRO_OPERATOR_DEST_IN [
	"This method was automatically generated"
	^ CAIRO_OPERATOR_DEST_IN
]

{ #category : #'accessing enum' }
AeCairoOperator class >> CAIRO_OPERATOR_DEST_OUT [
	"This method was automatically generated"
	^ CAIRO_OPERATOR_DEST_OUT
]

{ #category : #'accessing enum' }
AeCairoOperator class >> CAIRO_OPERATOR_DEST_OVER [
	"This method was automatically generated"
	^ CAIRO_OPERATOR_DEST_OVER
]

{ #category : #'accessing enum' }
AeCairoOperator class >> CAIRO_OPERATOR_DIFFERENCE [
	"This method was automatically generated"
	^ CAIRO_OPERATOR_DIFFERENCE
]

{ #category : #'accessing enum' }
AeCairoOperator class >> CAIRO_OPERATOR_EXCLUSION [
	"This method was automatically generated"
	^ CAIRO_OPERATOR_EXCLUSION
]

{ #category : #'accessing enum' }
AeCairoOperator class >> CAIRO_OPERATOR_HARD_LIGHT [
	"This method was automatically generated"
	^ CAIRO_OPERATOR_HARD_LIGHT
]

{ #category : #'accessing enum' }
AeCairoOperator class >> CAIRO_OPERATOR_HSL_COLOR [
	"This method was automatically generated"
	^ CAIRO_OPERATOR_HSL_COLOR
]

{ #category : #'accessing enum' }
AeCairoOperator class >> CAIRO_OPERATOR_HSL_HUE [
	"This method was automatically generated"
	^ CAIRO_OPERATOR_HSL_HUE
]

{ #category : #'accessing enum' }
AeCairoOperator class >> CAIRO_OPERATOR_HSL_LUMINOSITY [
	"This method was automatically generated"
	^ CAIRO_OPERATOR_HSL_LUMINOSITY
]

{ #category : #'accessing enum' }
AeCairoOperator class >> CAIRO_OPERATOR_HSL_SATURATION [
	"This method was automatically generated"
	^ CAIRO_OPERATOR_HSL_SATURATION
]

{ #category : #'accessing enum' }
AeCairoOperator class >> CAIRO_OPERATOR_IN [
	"This method was automatically generated"
	^ CAIRO_OPERATOR_IN
]

{ #category : #'accessing enum' }
AeCairoOperator class >> CAIRO_OPERATOR_LIGHTEN [
	"This method was automatically generated"
	^ CAIRO_OPERATOR_LIGHTEN
]

{ #category : #'accessing enum' }
AeCairoOperator class >> CAIRO_OPERATOR_MULTIPLY [
	"This method was automatically generated"
	^ CAIRO_OPERATOR_MULTIPLY
]

{ #category : #'accessing enum' }
AeCairoOperator class >> CAIRO_OPERATOR_OUT [
	"This method was automatically generated"
	^ CAIRO_OPERATOR_OUT
]

{ #category : #'accessing enum' }
AeCairoOperator class >> CAIRO_OPERATOR_OVER [
	"This method was automatically generated"
	^ CAIRO_OPERATOR_OVER
]

{ #category : #'accessing enum' }
AeCairoOperator class >> CAIRO_OPERATOR_OVERLAY [
	"This method was automatically generated"
	^ CAIRO_OPERATOR_OVERLAY
]

{ #category : #'accessing enum' }
AeCairoOperator class >> CAIRO_OPERATOR_SATURATE [
	"This method was automatically generated"
	^ CAIRO_OPERATOR_SATURATE
]

{ #category : #'accessing enum' }
AeCairoOperator class >> CAIRO_OPERATOR_SCREEN [
	"This method was automatically generated"
	^ CAIRO_OPERATOR_SCREEN
]

{ #category : #'accessing enum' }
AeCairoOperator class >> CAIRO_OPERATOR_SOFT_LIGHT [
	"This method was automatically generated"
	^ CAIRO_OPERATOR_SOFT_LIGHT
]

{ #category : #'accessing enum' }
AeCairoOperator class >> CAIRO_OPERATOR_SOURCE [
	"This method was automatically generated"
	^ CAIRO_OPERATOR_SOURCE
]

{ #category : #'accessing enum' }
AeCairoOperator class >> CAIRO_OPERATOR_XOR [
	"This method was automatically generated"
	^ CAIRO_OPERATOR_XOR
]

{ #category : #'accessing enum camelcased' }
AeCairoOperator class >> add [

	^ CAIRO_OPERATOR_ADD
]

{ #category : #'accessing enum camelcased' }
AeCairoOperator class >> atop [

	^ CAIRO_OPERATOR_ATOP
]

{ #category : #'accessing enum camelcased' }
AeCairoOperator class >> clear [

	^ CAIRO_OPERATOR_CLEAR
]

{ #category : #'accessing enum camelcased' }
AeCairoOperator class >> colorBurn [

	^ CAIRO_OPERATOR_COLOR_BURN
]

{ #category : #'accessing enum camelcased' }
AeCairoOperator class >> colorDodge [

	^ CAIRO_OPERATOR_COLOR_DODGE
]

{ #category : #'accessing enum camelcased' }
AeCairoOperator class >> darken [

	^ CAIRO_OPERATOR_DARKEN
]

{ #category : #'accessing enum camelcased' }
AeCairoOperator class >> dest [

	^ CAIRO_OPERATOR_DEST
]

{ #category : #'accessing enum camelcased' }
AeCairoOperator class >> destAtop [

	^ CAIRO_OPERATOR_DEST_ATOP
]

{ #category : #'accessing enum camelcased' }
AeCairoOperator class >> destIn [

	^ CAIRO_OPERATOR_DEST_IN
]

{ #category : #'accessing enum camelcased' }
AeCairoOperator class >> destOut [

	^ CAIRO_OPERATOR_DEST_OUT
]

{ #category : #'accessing enum camelcased' }
AeCairoOperator class >> destOver [

	^ CAIRO_OPERATOR_DEST_OVER
]

{ #category : #'accessing enum camelcased' }
AeCairoOperator class >> difference [

	^ CAIRO_OPERATOR_DIFFERENCE
]

{ #category : #'enum declaration' }
AeCairoOperator class >> enumDecl [
	"
	self rebuildEnumAccessors
	"

	^ #(
		CAIRO_OPERATOR_CLEAR 0

		CAIRO_OPERATOR_SOURCE 1
		CAIRO_OPERATOR_OVER 2
		CAIRO_OPERATOR_IN 3
		CAIRO_OPERATOR_OUT 4
		CAIRO_OPERATOR_ATOP 5

		CAIRO_OPERATOR_DEST 6
		CAIRO_OPERATOR_DEST_OVER 7
		CAIRO_OPERATOR_DEST_IN 8
		CAIRO_OPERATOR_DEST_OUT 9
		CAIRO_OPERATOR_DEST_ATOP 10

		CAIRO_OPERATOR_XOR 11
		CAIRO_OPERATOR_ADD 12
		CAIRO_OPERATOR_SATURATE 13

		CAIRO_OPERATOR_MULTIPLY 14
		CAIRO_OPERATOR_SCREEN 15
		CAIRO_OPERATOR_OVERLAY 16
		CAIRO_OPERATOR_DARKEN 17
		CAIRO_OPERATOR_LIGHTEN 18
		CAIRO_OPERATOR_COLOR_DODGE 19
		CAIRO_OPERATOR_COLOR_BURN 20
		CAIRO_OPERATOR_HARD_LIGHT 21
		CAIRO_OPERATOR_SOFT_LIGHT 22
		CAIRO_OPERATOR_DIFFERENCE 23
		CAIRO_OPERATOR_EXCLUSION 24
		CAIRO_OPERATOR_HSL_HUE 25
		CAIRO_OPERATOR_HSL_SATURATION 26
		CAIRO_OPERATOR_HSL_COLOR 27
		CAIRO_OPERATOR_HSL_LUMINOSITY 28
	)
]

{ #category : #'accessing enum camelcased' }
AeCairoOperator class >> exclusion [

	^ CAIRO_OPERATOR_EXCLUSION
]

{ #category : #'accessing enum camelcased' }
AeCairoOperator class >> hardLight [

	^ CAIRO_OPERATOR_HARD_LIGHT
]

{ #category : #'accessing enum camelcased' }
AeCairoOperator class >> hslColor [

	^ CAIRO_OPERATOR_HSL_COLOR
]

{ #category : #'accessing enum camelcased' }
AeCairoOperator class >> hslHue [

	^ CAIRO_OPERATOR_HSL_HUE
]

{ #category : #'accessing enum camelcased' }
AeCairoOperator class >> hslLuminosity [

	^ CAIRO_OPERATOR_HSL_LUMINOSITY
]

{ #category : #'accessing enum camelcased' }
AeCairoOperator class >> hslSaturation [

	^ CAIRO_OPERATOR_HSL_SATURATION
]

{ #category : #'accessing enum camelcased' }
AeCairoOperator class >> in [

	^ CAIRO_OPERATOR_IN
]

{ #category : #'accessing enum camelcased' }
AeCairoOperator class >> lighten [

	^ CAIRO_OPERATOR_LIGHTEN
]

{ #category : #'accessing enum camelcased' }
AeCairoOperator class >> multiply [

	^ CAIRO_OPERATOR_MULTIPLY
]

{ #category : #'accessing enum camelcased' }
AeCairoOperator class >> out [

	^ CAIRO_OPERATOR_OUT
]

{ #category : #'accessing enum camelcased' }
AeCairoOperator class >> over [

	^ CAIRO_OPERATOR_OVER
]

{ #category : #'accessing enum camelcased' }
AeCairoOperator class >> overlay [

	^ CAIRO_OPERATOR_OVERLAY
]

{ #category : #'accessing enum camelcased' }
AeCairoOperator class >> saturate [

	^ CAIRO_OPERATOR_SATURATE
]

{ #category : #'accessing enum camelcased' }
AeCairoOperator class >> screen [

	^ CAIRO_OPERATOR_SCREEN
]

{ #category : #'accessing enum camelcased' }
AeCairoOperator class >> softLight [

	^ CAIRO_OPERATOR_SOFT_LIGHT
]

{ #category : #'accessing enum camelcased' }
AeCairoOperator class >> source [

	^ CAIRO_OPERATOR_SOURCE
]

{ #category : #hook }
AeCairoOperator class >> underlinedNamePrefix [
	
	^ 'CAIRO_OPERATOR_'
]

{ #category : #'accessing enum camelcased' }
AeCairoOperator class >> xor [

	^ CAIRO_OPERATOR_XOR
]
