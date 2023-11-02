"
I am a Harfbuzz FFI binding for `hb_variation_t`, a data type for holding variation data. 

Registered OpenType variation-axis tags are listed in OpenType Axis Tag Registry.

See: https://harfbuzz.github.io/harfbuzz-hb-common.html#hb-variation-t
"
Class {
	#name : #AeHbVariableFontVariation,
	#superclass : #FFIExternalStructure,
	#traits : 'AeTHarfbuzzLibrary',
	#classTraits : 'AeTHarfbuzzLibrary classTrait',
	#classVars : [
		'OFFSET_TAG',
		'OFFSET_VALUE'
	],
	#pools : [
		'AeHbTypes'
	],
	#category : #'Alexandrie-HarfbuzzVariableFonts'
}

{ #category : #'field definition' }
AeHbVariableFontVariation class >> fieldsDesc [
	"
	self rebuildFieldAccessors
	"

	^ #(
		hb_tag_t tag;
		float    value;
		)
]

{ #category : #printing }
AeHbVariableFontVariation >> printOn: aStream [

	super printOn: aStream.
	#(tagString value) do: [ :each |
		aStream
			space;
			nextPutAll: each;
			nextPutAll: ': ';
			print: (self perform: each) ]

]

{ #category : #'accessing - structure variables' }
AeHbVariableFontVariation >> tag [
	"This method was automatically generated"
	^handle unsignedLongAt: OFFSET_TAG
]

{ #category : #'accessing - structure variables' }
AeHbVariableFontVariation >> tag: anObject [
	"This method was automatically generated"
	handle unsignedLongAt: OFFSET_TAG put: anObject
]

{ #category : #'accessing - structure variables' }
AeHbVariableFontVariation >> tagString [

	^ self tag asHbTagString
]

{ #category : #'accessing - structure variables' }
AeHbVariableFontVariation >> value [
	"This method was automatically generated"
	^handle floatAt: OFFSET_VALUE
]

{ #category : #'accessing - structure variables' }
AeHbVariableFontVariation >> value: anObject [
	"This method was automatically generated"
	handle floatAt: OFFSET_VALUE put: anObject
]
