"
An AeHbLanguageTest is a test class for testing the behavior of AeHbLanguage
"
Class {
	#name : #AeHbLanguageTest,
	#superclass : #TestCase,
	#category : #'Alexandrie-Harfbuzz-Tests'
}

{ #category : #tests }
AeHbLanguageTest >> testBCP47Tag [

	self
		assert: (AeHbLanguage fromBCP47Tag: 'en') getHandle
		equals: (AeHbLanguage fromBCP47Tag: 'en') getHandle.

	self
		assert: (AeHbLanguage fromBCP47Tag: 'en') getHandle
		equals: AeHbLanguage en getHandle.

	self
		deny: (AeHbLanguage fromBCP47Tag: 'en') getHandle
		equals: (AeHbLanguage fromBCP47Tag: 'fr') getHandle.

	self
		deny: (AeHbLanguage fromBCP47Tag: 'es-AR') getHandle
		equals: (AeHbLanguage fromBCP47Tag: 'es-MX') getHandle.

]
