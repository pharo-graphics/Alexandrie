"
I represent FFI bindings to `hb_glyph_position_t`.

The `hb_glyph_position_t` is the structure that holds the positions of the glyph in both horizontal and vertical directions. All positions in `hb_glyph_position_t` are relative to the current point.

See: https://harfbuzz.github.io/harfbuzz-hb-buffer.html#hb-glyph-position-t
"
Class {
	#name : 'AeHbGlyphPosition',
	#superclass : 'FFIExternalStructure',
	#classVars : [
		'OFFSET_VAR',
		'OFFSET_XADVANCE',
		'OFFSET_XOFFSET',
		'OFFSET_YADVANCE',
		'OFFSET_YOFFSET'
	],
	#pools : [
		'AeHbTypes'
	],
	#category : 'Alexandrie-Harfbuzz-Structures',
	#package : 'Alexandrie-Harfbuzz',
	#tag : 'Structures'
}

{ #category : 'field definition' }
AeHbGlyphPosition class >> fieldsDesc [
	"
	self rebuildFieldAccessors
	"

	^ #(
		hb_position_t  xAdvance "x_advance"
		hb_position_t  yAdvance "y_advance"
		hb_position_t  xOffset  "x_offset"
		hb_position_t  yOffset  "y_offset"
		hb_var_int_t var        "(private)"
		)
]

{ #category : 'printing' }
AeHbGlyphPosition >> printOn: aStream [

	super printOn: aStream.
	#(xAdvance yAdvance xOffset yOffset) do: [ :each |
		aStream
			space;
			nextPutAll: each;
			nextPutAll: ': ';
			print: (self perform: each).
		 ]

]

{ #category : 'accessing - structure variables' }
AeHbGlyphPosition >> xAdvance [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_XADVANCE
]

{ #category : 'accessing - structure variables' }
AeHbGlyphPosition >> xAdvance: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_XADVANCE put: anObject
]

{ #category : 'accessing' }
AeHbGlyphPosition >> xAdvanceFrom26Dot6 [

	^ self xAdvance from26Dot6FractionalPoint
]

{ #category : 'accessing - structure variables' }
AeHbGlyphPosition >> xOffset [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_XOFFSET
]

{ #category : 'accessing - structure variables' }
AeHbGlyphPosition >> xOffset: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_XOFFSET put: anObject
]

{ #category : 'accessing' }
AeHbGlyphPosition >> xOffsetFrom26Dot6 [

	^ self xOffset from26Dot6FractionalPoint
]

{ #category : 'accessing - structure variables' }
AeHbGlyphPosition >> yAdvance [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_YADVANCE
]

{ #category : 'accessing - structure variables' }
AeHbGlyphPosition >> yAdvance: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_YADVANCE put: anObject
]

{ #category : 'accessing' }
AeHbGlyphPosition >> yAdvanceFrom26Dot6 [

	^ self yAdvance from26Dot6FractionalPoint
]

{ #category : 'accessing - structure variables' }
AeHbGlyphPosition >> yOffset [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_YOFFSET
]

{ #category : 'accessing - structure variables' }
AeHbGlyphPosition >> yOffset: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_YOFFSET put: anObject
]

{ #category : 'accessing' }
AeHbGlyphPosition >> yOffsetFrom26Dot6 [

	^ self yOffset from26Dot6FractionalPoint
]
