"
I am a Cairo FFI binding for `cairo_line_join_t`.

Specifies how to render the junction of two lines when stroking.

The default line join style is `CAIRO_LINE_JOIN_MITER`.

Members:

- `CAIRO_LINE_JOIN_MITER`: use a sharp (angled) corner, see cairo_set_miter_limit() (Since 1.0)
- `CAIRO_LINE_JOIN_ROUND`: use a rounded join, the center of the circle is the joint point (Since 1.0)
- `CAIRO_LINE_JOIN_BEVEL`: use a cut-off join, the join is cut off at half the line width from the joint point (Since 1.0)

See: https://www.cairographics.org/manual/cairo-cairo-t.html#cairo-line-join-t
"
Class {
	#name : #AeCairoJoinStyle,
	#superclass : #AeEnumeration,
	#classVars : [
		'CAIRO_LINE_JOIN_BEVEL',
		'CAIRO_LINE_JOIN_MITER',
		'CAIRO_LINE_JOIN_ROUND'
	],
	#category : #'Alexandrie-Cairo-Enumerations'
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

{ #category : #'accessing enum' }
AeCairoJoinStyle class >> bevel [

	^ CAIRO_LINE_JOIN_BEVEL
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

{ #category : #'accessing enum' }
AeCairoJoinStyle class >> miter [

	^ CAIRO_LINE_JOIN_MITER
]

{ #category : #'accessing enum' }
AeCairoJoinStyle class >> round [

	^ CAIRO_LINE_JOIN_ROUND
]

{ #category : #hook }
AeCairoJoinStyle class >> underlinedNamePrefix [
	
	^ 'CAIRO_LINE_JOIN_'
]
