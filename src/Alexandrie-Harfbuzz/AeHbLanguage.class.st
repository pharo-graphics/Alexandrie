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

	^ EN
]

{ #category : #'instance creation' }
AeHbLanguage class >> fromBCP47ByteArray: str length: len [
	"Converts str representing a BCP 47 language tag. Library-owned, don't free manually.
	
	See: https://harfbuzz.github.io/harfbuzz-hb-common.html#hb-language-from-string"

	^ self ffiCall: #(
		hb_language_t
		hb_language_from_string (
			const char *str,
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

	EN := self fromString: 'en'.
]
