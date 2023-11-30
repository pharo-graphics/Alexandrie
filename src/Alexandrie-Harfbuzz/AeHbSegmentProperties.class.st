"
I represent FFI bindings to `hb_segment_properties_t` struct.

Such structure holds various text properties of an `hb_buffer_t`.

See: https://harfbuzz.github.io/harfbuzz-hb-buffer.html#hb-segment-properties-t
"
Class {
	#name : 'AeHbSegmentProperties',
	#superclass : 'FFIExternalStructure',
	#classVars : [
		'OFFSET_DIRECTION',
		'OFFSET_LANGUAGEADDRESS',
		'OFFSET_RESERVED1',
		'OFFSET_RESERVED2',
		'OFFSET_SCRIPT'
	],
	#pools : [
		'AeHbTypes'
	],
	#category : 'Alexandrie-Harfbuzz-Structures',
	#package : 'Alexandrie-Harfbuzz',
	#tag : 'Structures'
}

{ #category : 'field definition' }
AeHbSegmentProperties class >> fieldsDesc [
	"
	self rebuildFieldAccessors
	"

	^ #(
		hb_direction_t  direction
		hb_script_t     script
		hb_language_t   languageAddress

		void           *reserved1 "(private)"
		void           *reserved2 "(private)"
		)
]

{ #category : 'accessing - structure variables' }
AeHbSegmentProperties >> direction [
	"This method was automatically generated"
	^AeHbDirection fromInteger: (handle unsignedLongAt: OFFSET_DIRECTION)
]

{ #category : 'accessing - structure variables' }
AeHbSegmentProperties >> direction: anObject [
	"This method was automatically generated"
	handle unsignedLongAt: OFFSET_DIRECTION put: anObject value
]

{ #category : 'accessing - structure variables' }
AeHbSegmentProperties >> language [

	^ AeHbLanguage fromHandle: self languageAddress
]

{ #category : 'accessing - structure variables' }
AeHbSegmentProperties >> languageAddress [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_LANGUAGEADDRESS) type: ExternalType void asPointerType
]

{ #category : 'accessing - structure variables' }
AeHbSegmentProperties >> languageAddress: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_LANGUAGEADDRESS put: anObject getHandle.
]

{ #category : 'printing' }
AeHbSegmentProperties >> printOn: aStream [

	super printOn: aStream.
	aStream nextPut: $(.

	#(direction script language) do: [ :each |
		aStream
			nextPutAll: each asMutator;
			space;
			print: (self perform: each) ]
		separatedBy: [ aStream space ].

	aStream nextPut: $)
]

{ #category : 'accessing - structure variables' }
AeHbSegmentProperties >> script [
	"This method was automatically generated"
	^AeHbScript fromInteger: (handle unsignedLongAt: OFFSET_SCRIPT)
]

{ #category : 'accessing - structure variables' }
AeHbSegmentProperties >> script: anObject [
	"This method was automatically generated"
	handle unsignedLongAt: OFFSET_SCRIPT put: anObject value
]
