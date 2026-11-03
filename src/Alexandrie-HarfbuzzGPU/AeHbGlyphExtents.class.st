"
I represent FFI bindings to `hb_glyph_extents_t`.

Glyph extent values, measured in font units. Note that height is negative, in coordinate systems that grow up.

See: https://harfbuzz.github.io/
"
Class {
	#name : #AeHbGlyphExtents,
	#superclass : #FFIStructure,
	#classVars : [
		'OFFSET_HEIGHT',
		'OFFSET_WIDTH',
		'OFFSET_XBEARING',
		'OFFSET_YBEARING'
	],
	#pools : [
		'AeHbTypes'
	],
	#category : #'Alexandrie-HarfbuzzGPU-Structures'
}

{ #category : #'field definition' }
AeHbGlyphExtents class >> fieldsDesc [
	"
	self rebuildFieldAccessors
	"

	^ #(
		hb_position_t xBearing
		hb_position_t yBearing
		hb_position_t width
		hb_position_t height )
]

{ #category : #'accessing - structure variables' }
AeHbGlyphExtents >> height [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_HEIGHT
]

{ #category : #'accessing - structure variables' }
AeHbGlyphExtents >> height: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_HEIGHT put: anObject
]

{ #category : #'accessing - structure variables' }
AeHbGlyphExtents >> width [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_WIDTH
]

{ #category : #'accessing - structure variables' }
AeHbGlyphExtents >> width: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_WIDTH put: anObject
]

{ #category : #'accessing - structure variables' }
AeHbGlyphExtents >> xBearing [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_XBEARING
]

{ #category : #'accessing - structure variables' }
AeHbGlyphExtents >> xBearing: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_XBEARING put: anObject
]

{ #category : #'accessing - structure variables' }
AeHbGlyphExtents >> yBearing [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_YBEARING
]

{ #category : #'accessing - structure variables' }
AeHbGlyphExtents >> yBearing: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_YBEARING put: anObject
]
