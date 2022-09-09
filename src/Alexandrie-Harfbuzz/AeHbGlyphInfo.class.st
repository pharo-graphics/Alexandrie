"
I represent FFI bindings to `hb_glyph_info_t` struct.

The `hb_glyph_info_t` is the structure that holds information about the glyphs and their relation to input text.

See: https://harfbuzz.github.io/harfbuzz-hb-buffer.html#hb-glyph-info-t
"
Class {
	#name : #AeHbGlyphInfo,
	#superclass : #FFIExternalStructure,
	#traits : 'AeTHarfbuzzLibrary',
	#classTraits : 'AeTHarfbuzzLibrary classTrait',
	#classVars : [
		'OFFSET_CLUSTER',
		'OFFSET_CODEPOINT'
	],
	#pools : [
		'AeHbTypes'
	],
	#category : #'Alexandrie-Harfbuzz-Structures'
}

{ #category : #'field definition' }
AeHbGlyphInfo class >> fieldsDesc [
	"
	self rebuildFieldAccessors
	"

	^ #(
		"hb_codepoint_t"uint32  codepoint
		"uint32_t" uint32       cluster
		)
]

{ #category : #'accessing - structure variables' }
AeHbGlyphInfo >> cluster [
	"This method was automatically generated"
	^handle unsignedLongAt: OFFSET_CLUSTER
]

{ #category : #'accessing - structure variables' }
AeHbGlyphInfo >> cluster: anObject [
	"This method was automatically generated"
	handle unsignedLongAt: OFFSET_CLUSTER put: anObject
]

{ #category : #'accessing - structure variables' }
AeHbGlyphInfo >> codepoint [
	"This method was automatically generated"
	^handle unsignedLongAt: OFFSET_CODEPOINT
]

{ #category : #'accessing - structure variables' }
AeHbGlyphInfo >> codepoint: anObject [
	"This method was automatically generated"
	handle unsignedLongAt: OFFSET_CODEPOINT put: anObject
]

{ #category : #printing }
AeHbGlyphInfo >> printOn: aStream [

	super printOn: aStream.
	#(codepoint cluster) do: [ :each |
		aStream
			space;
			nextPutAll: each;
			nextPutAll: ': ';
			print: (self perform: each).
		 ].

]
