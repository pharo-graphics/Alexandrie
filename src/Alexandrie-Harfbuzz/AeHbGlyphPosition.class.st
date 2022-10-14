"
I represent FFI bindings to `hb_glyph_position_t`.

The `hb_glyph_position_t` is the structure that holds the positions of the glyph in both horizontal and vertical directions. All positions in `hb_glyph_position_t` are relative to the current point.

See: https://harfbuzz.github.io/harfbuzz-hb-buffer.html#hb-glyph-position-t
"
Class {
	#name : #AeHbGlyphPosition,
	#superclass : #FFIExternalStructure,
	#traits : 'AeTHarfbuzzLibrary',
	#classTraits : 'AeTHarfbuzzLibrary classTrait',
	#classVars : [
		'OFFSET_VAR',
		'OFFSET_X_ADVANCE',
		'OFFSET_X_OFFSET',
		'OFFSET_Y_ADVANCE',
		'OFFSET_Y_OFFSET'
	],
	#pools : [
		'AeHbTypes'
	],
	#category : #'Alexandrie-Harfbuzz-Structures'
}

{ #category : #'field definition' }
AeHbGlyphPosition class >> fieldsDesc [
	"
	self rebuildFieldAccessors
	"

	^ #(
		hb_position_t  x_advance
		hb_position_t  y_advance
		hb_position_t  x_offset
		hb_position_t  y_offset
		uint32 var "<private> hb_var_int_t   var;"
		)
]

{ #category : #printing }
AeHbGlyphPosition >> printOn: aStream [

	super printOn: aStream.
	#(x_advance y_advance x_offset y_offset) do: [ :each |
		aStream
			space;
			nextPutAll: each;
			nextPutAll: ': ';
			print: (self perform: each).
		 ]

]

{ #category : #'accessing - structure variables' }
AeHbGlyphPosition >> var [
	"This method was automatically generated"
	^handle unsignedLongAt: OFFSET_VAR
]

{ #category : #'accessing - structure variables' }
AeHbGlyphPosition >> var: anObject [
	"This method was automatically generated"
	handle unsignedLongAt: OFFSET_VAR put: anObject
]

{ #category : #accessing }
AeHbGlyphPosition >> xAdvanceFrom26Dot6 [

	^ self x_advance from26Dot6FractionalPoint
]

{ #category : #accessing }
AeHbGlyphPosition >> xOffsetFrom26Dot6 [

	^ self x_offset from26Dot6FractionalPoint
]

{ #category : #'accessing - structure variables' }
AeHbGlyphPosition >> x_advance [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_X_ADVANCE
]

{ #category : #'accessing - structure variables' }
AeHbGlyphPosition >> x_advance: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_X_ADVANCE put: anObject
]

{ #category : #'accessing - structure variables' }
AeHbGlyphPosition >> x_offset [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_X_OFFSET
]

{ #category : #'accessing - structure variables' }
AeHbGlyphPosition >> x_offset: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_X_OFFSET put: anObject
]

{ #category : #accessing }
AeHbGlyphPosition >> yAdvanceFrom26Dot6 [

	^ self y_advance from26Dot6FractionalPoint
]

{ #category : #accessing }
AeHbGlyphPosition >> yOffsetFrom26Dot6 [

	^ self y_offset from26Dot6FractionalPoint
]

{ #category : #'accessing - structure variables' }
AeHbGlyphPosition >> y_advance [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_Y_ADVANCE
]

{ #category : #'accessing - structure variables' }
AeHbGlyphPosition >> y_advance: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_Y_ADVANCE put: anObject
]

{ #category : #'accessing - structure variables' }
AeHbGlyphPosition >> y_offset [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_Y_OFFSET
]

{ #category : #'accessing - structure variables' }
AeHbGlyphPosition >> y_offset: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_Y_OFFSET put: anObject
]
