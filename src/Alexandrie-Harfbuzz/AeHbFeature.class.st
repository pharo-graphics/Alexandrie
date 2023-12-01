"
I represent FFI bindings to `hb_feature_t` struct.

The `hb_feature_t` is the structure that holds information about requested feature application. The feature will be applied with the given value to all glyphs which are in clusters between start (inclusive) and end (exclusive). Setting start to `HB_FEATURE_GLOBAL_START` (0) and end to `HB_FEATURE_GLOBAL_END` (-1) specifies that the feature always applies to the entire buffer.

Members:
* tag: The `hb_tag_t` tag of the feature
* value: The value of the feature. 0 disables the feature, non-zero (usually 1) enables the feature. For features implemented as lookup type 3 (like 'salt') the value is a one based index into the alternates.
* start: the cluster to start applying this feature setting (inclusive).
* end: the cluster to end applying this feature setting (exclusive).

See: https://harfbuzz.github.io/harfbuzz-hb-common.html#hb-feature-t
"
Class {
	#name : 'AeHbFeature',
	#superclass : 'FFIExternalStructure',
	#traits : 'AeTHarfbuzzLibrary',
	#classTraits : 'AeTHarfbuzzLibrary classTrait',
	#classVars : [
		'OFFSET_END',
		'OFFSET_START',
		'OFFSET_TAG',
		'OFFSET_VALUE'
	],
	#pools : [
		'AeHbTypes'
	],
	#category : 'Alexandrie-Harfbuzz-Structures',
	#package : 'Alexandrie-Harfbuzz',
	#tag : 'Structures'
}

{ #category : 'field definition' }
AeHbFeature class >> fieldsDesc [
	"
	self rebuildFieldAccessors
	"

	^ #(
		hb_tag_t      tag
		uint32_t      value
		uint  start
		uint  end
		)
]

{ #category : 'accessing' }
AeHbFeature class >> globalEnd [
	"Special setting to apply a feature up to the end of the buffer.
	
	Migrated from src/hb-common.h:
		`#define HB_FEATURE_GLOBAL_END	((unsigned int) -1)`
	"

	^ 16rffffffff
]

{ #category : 'accessing' }
AeHbFeature class >> globalStart [
	"Special setting to apply a feature from the end of the buffer.
	
	Migrated from src/hb-common.h:
		`#define HB_FEATURE_GLOBAL_START	0`
	"

	^ 0
]

{ #category : 'instance creation' }
AeHbFeature class >> readFrom: aString [

	^ self new
		readIntoSelf: aString;
		yourself
]

{ #category : 'accessing - structure variables' }
AeHbFeature >> end [
	"This method was automatically generated"
	^handle unsignedLongAt: OFFSET_END
]

{ #category : 'accessing - structure variables' }
AeHbFeature >> end: anObject [
	"This method was automatically generated"
	handle unsignedLongAt: OFFSET_END put: anObject
]

{ #category : 'accessing - structure variables' }
AeHbFeature >> endsAtGlobalEnd [

	^ self end = self class globalEnd
]

{ #category : 'printing' }
AeHbFeature >> printOn: aStream [

	super printOn: aStream.
	aStream nextPutAll: (
		'({1}[{3}:{4}]={2})'
			format: (#(tagString value start end)
				collect: [ :each | self perform: each ]))

]

{ #category : 'parsing' }
AeHbFeature >> readIntoSelf: aString [

	| utf8Encoded |
	utf8Encoded := aString utf8Encoded.
	
	^ self readIntoSelf: utf8Encoded size: utf8Encoded size
]

{ #category : 'parsing' }
AeHbFeature >> readIntoSelf: string size: stringSize [
	"Parses a string into myself. The boolean answer indicates success.
	
	See: https://harfbuzz.github.io/harfbuzz-hb-common.html#hb-feature-from-string"

	^ self ffiCall: #(
		hb_bool_t
		hb_feature_from_string (
			const char *string,
			int stringSize,
			self )
		)
]

{ #category : 'accessing - structure variables' }
AeHbFeature >> setGlobalEnd [

	self end: self class globalEnd
]

{ #category : 'accessing - structure variables' }
AeHbFeature >> setGlobalStart [

	self start: self class globalStart
]

{ #category : 'accessing - structure variables' }
AeHbFeature >> start [
	"This method was automatically generated"
	^handle unsignedLongAt: OFFSET_START
]

{ #category : 'accessing - structure variables' }
AeHbFeature >> start: anObject [
	"This method was automatically generated"
	handle unsignedLongAt: OFFSET_START put: anObject
]

{ #category : 'accessing - structure variables' }
AeHbFeature >> startsAtGlobalStart [

	^ self start = self class globalStart
]

{ #category : 'accessing - structure variables' }
AeHbFeature >> tag [
	"This method was automatically generated"
	^handle unsignedLongAt: OFFSET_TAG
]

{ #category : 'accessing - structure variables' }
AeHbFeature >> tag: anObject [
	"This method was automatically generated"
	handle unsignedLongAt: OFFSET_TAG put: anObject
]

{ #category : 'accessing - structure variables' }
AeHbFeature >> tagString [

	^ self tag asHbTagString
]

{ #category : 'accessing' }
AeHbFeature >> tagString: aString [ 
	"Set my tag with the integer representation of the received tag.
	
	See: https://harfbuzz.github.io/harfbuzz-hb-common.html#hb-tag-t"

	self tag: aString asHbTagInteger
]

{ #category : 'accessing - structure variables' }
AeHbFeature >> value [
	"This method was automatically generated"
	^handle unsignedLongAt: OFFSET_VALUE
]

{ #category : 'accessing - structure variables' }
AeHbFeature >> value: anObject [
	"This method was automatically generated"
	handle unsignedLongAt: OFFSET_VALUE put: anObject
]
