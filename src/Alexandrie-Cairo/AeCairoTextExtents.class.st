"
I am a Cairo FFI binding for `cairo_text_extents_t`.

The `cairo_text_extents_t` structure stores the extents of a single glyph or a string of glyphs in user-space coordinates. Because text extents are in user-space coordinates, they are mostly, but not entirely, independent of the current transformation matrix. If you call cairo_scale(cr, 2.0, 2.0), text will be drawn twice as big, but the reported text extents will not be doubled. They will change slightly due to hinting (so you can't assume that metrics are independent of the transformation matrix), but otherwise will remain unchanged.

See: https://www.cairographics.org/manual/cairo-cairo-scaled-font-t.html#cairo-text-extents-t
"
Class {
	#name : #AeCairoTextExtents,
	#superclass : #FFIExternalStructure,
	#classVars : [
		'OFFSET_ADVANCEX',
		'OFFSET_ADVANCEY',
		'OFFSET_BEARINGX',
		'OFFSET_BEARINGY',
		'OFFSET_HEIGHT',
		'OFFSET_WIDTH'
	],
	#category : #'Alexandrie-Cairo-Text'
}

{ #category : #'field definition' }
AeCairoTextExtents class >> fieldsDesc [
	"
	self rebuildFieldAccessors
	"
	^ #(
		double bearingX;
		double bearingY;
		double width;
		double height;
		double advanceX;
		double advanceY;
	)
]

{ #category : #'accessing structure variables' }
AeCairoTextExtents >> advanceX [
	"This method was automatically generated"
	^handle doubleAt: OFFSET_ADVANCEX
]

{ #category : #'accessing structure variables' }
AeCairoTextExtents >> advanceX: anObject [
	"This method was automatically generated"
	handle doubleAt: OFFSET_ADVANCEX put: anObject
]

{ #category : #'accessing structure variables' }
AeCairoTextExtents >> advanceY [
	"This method was automatically generated"
	^handle doubleAt: OFFSET_ADVANCEY
]

{ #category : #'accessing structure variables' }
AeCairoTextExtents >> advanceY: anObject [
	"This method was automatically generated"
	handle doubleAt: OFFSET_ADVANCEY put: anObject
]

{ #category : #'accessing structure variables' }
AeCairoTextExtents >> bearingX [
	"This method was automatically generated"
	^handle doubleAt: OFFSET_BEARINGX
]

{ #category : #'accessing structure variables' }
AeCairoTextExtents >> bearingX: anObject [
	"This method was automatically generated"
	handle doubleAt: OFFSET_BEARINGX put: anObject
]

{ #category : #'accessing structure variables' }
AeCairoTextExtents >> bearingY [
	"This method was automatically generated"
	^handle doubleAt: OFFSET_BEARINGY
]

{ #category : #'accessing structure variables' }
AeCairoTextExtents >> bearingY: anObject [
	"This method was automatically generated"
	handle doubleAt: OFFSET_BEARINGY put: anObject
]

{ #category : #'accessing structure variables' }
AeCairoTextExtents >> height [
	"This method was automatically generated"
	^handle doubleAt: OFFSET_HEIGHT
]

{ #category : #'accessing structure variables' }
AeCairoTextExtents >> height: anObject [
	"This method was automatically generated"
	handle doubleAt: OFFSET_HEIGHT put: anObject
]

{ #category : #'accessing structure variables' }
AeCairoTextExtents >> width [
	"This method was automatically generated"
	^handle doubleAt: OFFSET_WIDTH
]

{ #category : #'accessing structure variables' }
AeCairoTextExtents >> width: anObject [
	"This method was automatically generated"
	handle doubleAt: OFFSET_WIDTH put: anObject
]
