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
	#name : #AeHbFeature,
	#superclass : #FFIExternalStructure,
	#traits : 'AeTHarfbuzzLibrary',
	#classTraits : 'AeTHarfbuzzLibrary classTrait',
	#classVars : [
		'OFFSET_TAG',
		'OFFSET_VALUE',
		'OFFSET_ZEROBASEDEND',
		'OFFSET_ZEROBASEDSTART'
	],
	#pools : [
		'AeHbTypes'
	],
	#category : #'Alexandrie-Harfbuzz-Structures'
}

{ #category : #'field definition' }
AeHbFeature class >> fieldsDesc [
	"
	self rebuildFieldAccessors
	"

	^ #(
		hb_tag_t      tag
		uint32_t      value
		uint  zeroBasedStart "start"
		uint  zeroBasedEnd   "end"
		)
]

{ #category : #accessing }
AeHbFeature class >> globalEnd [

	^ self zeroBasedGlobalEnd + 1
]

{ #category : #accessing }
AeHbFeature class >> globalStart [

	^ self zeroBasedGlobalStart + 1
]

{ #category : #'instance creation' }
AeHbFeature class >> readFrom: aString [

	^ self new
		readIntoSelf: aString;
		yourself
]

{ #category : #accessing }
AeHbFeature class >> zeroBasedGlobalEnd [
	"Special setting to apply a feature up to the end of the buffer.
	
	Migrated from src/hb-common.h:
		`#define HB_FEATURE_GLOBAL_END	((unsigned int) -1)`
	"

	^ 16rffffffff
]

{ #category : #accessing }
AeHbFeature class >> zeroBasedGlobalStart [
	"Special setting to apply a feature from the end of the buffer.
	
	Migrated from src/hb-common.h:
		`#define HB_FEATURE_GLOBAL_START	0`
	"

	^ 0
]

{ #category : #'accessing - structure variables' }
AeHbFeature >> end [

	^ self zeroBasedEnd + 1
]

{ #category : #'accessing - structure variables' }
AeHbFeature >> end: anInteger [
	"Establish my end index, which is a one-based index."

	self zeroBasedEnd: anInteger - 1
]

{ #category : #'accessing - structure variables' }
AeHbFeature >> endsAtGlobalEnd [

	^ self zeroBasedEnd = self class zeroBasedGlobalEnd
]

{ #category : #printing }
AeHbFeature >> printOn: aStream [

	super printOn: aStream.
	aStream nextPutAll: (
		'({1}[{3}:{4}]={2})'
			format: (#(tagString value start end)
				collect: [ :each | self perform: each ]))

]

{ #category : #parsing }
AeHbFeature >> readIntoSelf: aString [

	| utf8Encoded |
	utf8Encoded := aString utf8Encoded.
	
	^ self readIntoSelf: utf8Encoded size: utf8Encoded size
]

{ #category : #parsing }
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

{ #category : #'accessing - structure variables' }
AeHbFeature >> setGlobalEnd [

	self zeroBasedEnd: self class zeroBasedGlobalEnd
]

{ #category : #'accessing - structure variables' }
AeHbFeature >> setGlobalStart [

	self zeroBasedStart: self class zeroBasedGlobalStart
]

{ #category : #'accessing - structure variables' }
AeHbFeature >> start [
	
	^ self zeroBasedStart + 1
]

{ #category : #'accessing - structure variables' }
AeHbFeature >> start: anInteger [
	"Establish my start index, which is a one-based index."

	^ self zeroBasedStart: anInteger - 1
]

{ #category : #'accessing - structure variables' }
AeHbFeature >> startsAtGlobalStart [

	^ self zeroBasedStart = self class zeroBasedGlobalStart
]

{ #category : #'accessing - structure variables' }
AeHbFeature >> tag [
	"This method was automatically generated"
	^handle unsignedLongAt: OFFSET_TAG
]

{ #category : #'accessing - structure variables' }
AeHbFeature >> tag: anObject [
	"This method was automatically generated"
	handle unsignedLongAt: OFFSET_TAG put: anObject
]

{ #category : #'accessing - structure variables' }
AeHbFeature >> tagString [

	^ self tag asHbTagString
]

{ #category : #accessing }
AeHbFeature >> tagString: aString [ 
	"Set my tag with the integer representation of the received tag.
	
	See: https://harfbuzz.github.io/harfbuzz-hb-common.html#hb-tag-t"

	self tag: aString asHbTagInteger
]

{ #category : #'accessing - structure variables' }
AeHbFeature >> value [
	"This method was automatically generated"
	^handle unsignedLongAt: OFFSET_VALUE
]

{ #category : #'accessing - structure variables' }
AeHbFeature >> value: anObject [
	"This method was automatically generated"
	handle unsignedLongAt: OFFSET_VALUE put: anObject
]

{ #category : #'accessing - structure variables' }
AeHbFeature >> zeroBasedEnd [
	"This method was automatically generated"
	^handle unsignedLongAt: OFFSET_ZEROBASEDEND
]

{ #category : #'accessing - structure variables' }
AeHbFeature >> zeroBasedEnd: anObject [
	"This method was automatically generated"
	handle unsignedLongAt: OFFSET_ZEROBASEDEND put: anObject
]

{ #category : #'accessing - structure variables' }
AeHbFeature >> zeroBasedStart [
	"This method was automatically generated"
	^handle unsignedLongAt: OFFSET_ZEROBASEDSTART
]

{ #category : #'accessing - structure variables' }
AeHbFeature >> zeroBasedStart: anObject [
	"This method was automatically generated"
	handle unsignedLongAt: OFFSET_ZEROBASEDSTART put: anObject
]
