"
An AeHbLanguageTest is a test class for testing the behavior of AeHbLanguage
"
Class {
	#name : #AeHbLanguageTest,
	#superclass : #TestCase,
	#category : #'Alexandrie-Harfbuzz-Tests'
}

{ #category : #tests }
AeHbLanguageTest >> testFromString [

	self
		assert: (AeHbLanguage fromString: 'en') getHandle
		equals: (AeHbLanguage fromString: 'en') getHandle.

	self
		deny: (AeHbLanguage fromString: 'en') getHandle
		equals: (AeHbLanguage fromString: 'fr') getHandle.

	self
		deny: (AeHbLanguage fromString: 'es-AR') getHandle
		equals: (AeHbLanguage fromString: 'es-MX') getHandle.

]
