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

	^ self fromString: 'en'
]

{ #category : #'instance creation' }
AeHbLanguage class >> fromString: aString [

	| encoded |
	encoded := aString asByteArray.
	^ self primLanguageFromString: encoded length: encoded size
]

{ #category : #'instance creation' }
AeHbLanguage class >> primLanguageFromString: str length: len [
	"See: https://harfbuzz.github.io/harfbuzz-hb-common.html#hb-language-from-string"

	^ self ffiCall: #(
		hb_language_t
		hb_language_from_string (
			const char *str,
			int len)
	)
]
