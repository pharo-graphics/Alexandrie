"
I represent FFI bindings to `hb_language_t` struct.

Each `hb_language_t` corresponds to a BCP 47 language tag.

See: https://harfbuzz.github.io/harfbuzz-hb-common.html#hb-language-t
"
Class {
	#name : #AeHbLanguage,
	#superclass : #FFIExternalObject,
	#traits : 'AeTHarfbuzzLibrary',
	#classTraits : 'AeTHarfbuzzLibrary classTrait',
	#classVars : [
		'EN'
	],
	#pools : [
		'AeHbTypes'
	],
	#category : #'Alexandrie-Harfbuzz-Core'
}

{ #category : #'instance creation' }
AeHbLanguage class >> en [

	^ EN ifNil: [ EN := self fromBCP47Tag: 'en' ]
]

{ #category : #'instance creation' }
AeHbLanguage class >> fromBCP47ByteArray: str length: len [
	"Converts str representing a BCP 47 language tag. Library-owned, don't free manually.
	
	See: https://harfbuzz.github.io/harfbuzz-hb-common.html#hb-language-from-string"

	^ self ffiCall: #(
		AeHbLanguage
		hb_language_from_string (
			const char * str,
			int len)
	)
]

{ #category : #'instance creation' }
AeHbLanguage class >> fromBCP47Tag: aString [

	| encoded |
	encoded := aString asByteArray.
	^ self fromBCP47ByteArray: encoded length: encoded size
]

{ #category : #initialization }
AeHbLanguage class >> initialize [

	SessionManager default registerSystemClassNamed: self name
]

{ #category : #'system startup' }
AeHbLanguage class >> resetKnownInstances [

	EN := nil.
]

{ #category : #'system startup' }
AeHbLanguage class >> startUp: isResuming [
	
	isResuming ifTrue: [ self resetKnownInstances ]
]

{ #category : #printing }
AeHbLanguage >> printOn: aStream [

	super printOn: aStream.
	aStream
		nextPut: $(;
		print: self toString;
		nextPut: $)
]

{ #category : #converting }
AeHbLanguage >> toString [
	"Answer a string representation.
	
	See: https://harfbuzz.github.io/harfbuzz-hb-common.html#hb-language-to-string"

	^ self ffiCall: #(
		const char * hb_language_to_string ( self )
	)
]
