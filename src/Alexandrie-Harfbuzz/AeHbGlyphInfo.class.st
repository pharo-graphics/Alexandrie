"
I represent FFI bindings to `hb_glyph_info_t` struct.

The `hb_glyph_info_t` is the structure that holds information about the glyphs and their relation to input text.

The relevant values are:

- **codepoint**: either a Unicode code point (before shaping) or a glyph index (after shaping).
- **cluster**: the index of the character in the original text that corresponds to this `hb_glyph_info_t`, or whatever the client passes to `hb_buffer_add()`. More than one `hb_glyph_info_t` can have the same cluster value, if they resulted from the same character (e.g. one to many glyph substitution), and when more than one character gets merged in the same glyph (e.g. many to one glyph substitution) the `hb_glyph_info_t` will have the smallest cluster value of them. By default some characters are merged into the same cluster (e.g. combining marks have the same cluster as their bases) even if they are separate glyphs, `hb_buffer_set_cluster_level()` allow selecting more fine-grained cluster handling.

See: https://harfbuzz.github.io/harfbuzz-hb-buffer.html#hb-glyph-info-t
"
Class {
	#name : 'AeHbGlyphInfo',
	#superclass : 'FFIExternalStructure',
	#classVars : [
		'OFFSET_CLUSTER',
		'OFFSET_CODEPOINT',
		'OFFSET_MASK',
		'OFFSET_VAR1',
		'OFFSET_VAR2'
	],
	#pools : [
		'AeHbTypes'
	],
	#category : 'Alexandrie-Harfbuzz-Structures',
	#package : 'Alexandrie-Harfbuzz',
	#tag : 'Structures'
}

{ #category : 'field definition' }
AeHbGlyphInfo class >> fieldsDesc [
	"
	self rebuildFieldAccessors
	"

	^ #(
		hb_codepoint_t codepoint
		
		"<private> hb_mask_t      mask;"
		hb_mask_t mask

		uint32_t       cluster

		"/*< private >*/
		  hb_var_int_t   var1;
		  hb_var_int_t   var2;"
		uint32 var1
		uint32 var2
		)
]

{ #category : 'accessing - structure variables' }
AeHbGlyphInfo >> cluster [
	"This method was automatically generated"
	^handle unsignedLongAt: OFFSET_CLUSTER
]

{ #category : 'accessing - structure variables' }
AeHbGlyphInfo >> cluster: anObject [
	"This method was automatically generated"
	handle unsignedLongAt: OFFSET_CLUSTER put: anObject
]

{ #category : 'accessing - structure variables' }
AeHbGlyphInfo >> codepoint [
	"This method was automatically generated"
	^handle unsignedLongAt: OFFSET_CODEPOINT
]

{ #category : 'accessing - structure variables' }
AeHbGlyphInfo >> codepoint: anObject [
	"This method was automatically generated"
	handle unsignedLongAt: OFFSET_CODEPOINT put: anObject
]

{ #category : 'accessing - structure variables' }
AeHbGlyphInfo >> mask [
	"This method was automatically generated"
	^handle unsignedLongAt: OFFSET_MASK
]

{ #category : 'accessing - structure variables' }
AeHbGlyphInfo >> mask: anObject [
	"This method was automatically generated"
	handle unsignedLongAt: OFFSET_MASK put: anObject
]

{ #category : 'printing' }
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

{ #category : 'accessing - structure variables' }
AeHbGlyphInfo >> var1 [
	"This method was automatically generated"
	^handle unsignedLongAt: OFFSET_VAR1
]

{ #category : 'accessing - structure variables' }
AeHbGlyphInfo >> var1: anObject [
	"This method was automatically generated"
	handle unsignedLongAt: OFFSET_VAR1 put: anObject
]

{ #category : 'accessing - structure variables' }
AeHbGlyphInfo >> var2 [
	"This method was automatically generated"
	^handle unsignedLongAt: OFFSET_VAR2
]

{ #category : 'accessing - structure variables' }
AeHbGlyphInfo >> var2: anObject [
	"This method was automatically generated"
	handle unsignedLongAt: OFFSET_VAR2 put: anObject
]
