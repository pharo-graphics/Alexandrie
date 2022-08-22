"
I am a Cairo FFI binding for `cairo_font_extents_t`.

A `cairo_font_extents_t` structure stores metric information for a font. Values are given in the current user-space coordinate system.

See: https://www.cairographics.org/manual/cairo-cairo-scaled-font-t.html#cairo-font-extents-t
"
Class {
	#name : #AeCairoFontExtents,
	#superclass : #FFIExternalStructure,
	#classVars : [
		'OFFSET_ASCENT',
		'OFFSET_DESCENT',
		'OFFSET_HEIGHT',
		'OFFSET_MAXADVANCEX',
		'OFFSET_MAXADVANCEY'
	],
	#category : #'Alexandrie-Cairo-Text'
}

{ #category : #'field definition' }
AeCairoFontExtents class >> fieldsDesc [
	"
	self rebuildFieldAccessors
	"
	^ #(
		double ascent;
		double descent;
		double height;
		double maxAdvanceX;
		double maxAdvanceY;
	)
]

{ #category : #'accessing structure variables' }
AeCairoFontExtents >> ascent [
	"This method was automatically generated"
	^handle doubleAt: OFFSET_ASCENT
]

{ #category : #'accessing structure variables' }
AeCairoFontExtents >> ascent: anObject [
	"This method was automatically generated"
	handle doubleAt: OFFSET_ASCENT put: anObject
]

{ #category : #'accessing structure variables' }
AeCairoFontExtents >> descent [
	"This method was automatically generated"
	^handle doubleAt: OFFSET_DESCENT
]

{ #category : #'accessing structure variables' }
AeCairoFontExtents >> descent: anObject [
	"This method was automatically generated"
	handle doubleAt: OFFSET_DESCENT put: anObject
]

{ #category : #'accessing structure variables' }
AeCairoFontExtents >> height [
	"This method was automatically generated"
	^handle doubleAt: OFFSET_HEIGHT
]

{ #category : #'accessing structure variables' }
AeCairoFontExtents >> height: anObject [
	"This method was automatically generated"
	handle doubleAt: OFFSET_HEIGHT put: anObject
]

{ #category : #'accessing structure variables' }
AeCairoFontExtents >> maxAdvanceX [
	"This method was automatically generated"
	^handle doubleAt: OFFSET_MAXADVANCEX
]

{ #category : #'accessing structure variables' }
AeCairoFontExtents >> maxAdvanceX: anObject [
	"This method was automatically generated"
	handle doubleAt: OFFSET_MAXADVANCEX put: anObject
]

{ #category : #'accessing structure variables' }
AeCairoFontExtents >> maxAdvanceY [
	"This method was automatically generated"
	^handle doubleAt: OFFSET_MAXADVANCEY
]

{ #category : #'accessing structure variables' }
AeCairoFontExtents >> maxAdvanceY: anObject [
	"This method was automatically generated"
	handle doubleAt: OFFSET_MAXADVANCEY put: anObject
]
