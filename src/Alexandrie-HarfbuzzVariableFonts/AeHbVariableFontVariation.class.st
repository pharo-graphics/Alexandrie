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

{ #category : #parsing }
AeHbVariableFontVariation >> readFrom: stringByteArray size: stringByteArraySize into: anAddress [
	"Parse variations from a string and set them in self. The answer indicates success.

	The format for specifying variation settings follows. All valid CSS font-variation-settings values other than 'normal' and 'inherited' are also accepted, though, not documented below.

	The format is a tag, optionally followed by an equals sign, followed by a number. For example wght=500, or slnt=-7.5.

	See: https://harfbuzz.github.io/harfbuzz-hb-common.html#hb-variation-from-string"

	^ self ffiCall: #(
		hb_bool_t
		hb_variation_from_string (
			char * stringByteArray,
			int stringByteArraySize,
			void * anAddress) )
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

{ #category : #accessing }
AeHbVariableFontVariation >> tagString: aString [ 
	"Set my tag with the integer representation of the received tag.
	
	See: https://harfbuzz.github.io/harfbuzz-hb-common.html#hb-tag-t"

	self tag: aString asHbTagInteger
]

{ #category : #parsing }
AeHbVariableFontVariation >> updateFromString: aString [

	| aByteArray |
	aByteArray := aString utf8Encoded.

	^ self
		readFrom: aByteArray
		size: aByteArray size
		into: self getHandle
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
