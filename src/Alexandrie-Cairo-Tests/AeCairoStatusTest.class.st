"
An AeCairoStatusTest is a test class for testing the behavior of AeCairoStatus
"
Class {
	#name : 'AeCairoStatusTest',
	#superclass : 'TestCase',
	#category : 'Alexandrie-Cairo-Tests',
	#package : 'Alexandrie-Cairo-Tests'
}

{ #category : 'test' }
AeCairoStatusTest >> testSuccess [

	| aSurface |
	aSurface :=
		AeCairoImageSurface
			extent: 1@1
			format: AeCairoSurfaceFormat a8.
	
	self
		shouldnt: [ aSurface status ensureIsSuccess ]
		raise: AeCairoStatusError.
	
	self
		assert: aSurface status description
		equals: 'no error has occurred'
]

{ #category : 'test' }
AeCairoStatusTest >> testUnsuccessfulCreation [

	| anInvalidSurface anInvalidContext expectedStatusDescription |
	anInvalidSurface :=
		AeCairoImageSurface
			extent: (1@1) negated
			format: AeCairoSurfaceFormat argb32.
	expectedStatusDescription := 'invalid value (typically too big) for the size of the input (surface, pattern, etc.)'.
	
	self
		should: [ anInvalidSurface status ensureIsSuccess ]
		raise: AeCairoStatusError
		whoseDescriptionIncludes: expectedStatusDescription
		description: 'Invalid extent'.
	
	anInvalidContext := anInvalidSurface newContext.
	self
		should: [ anInvalidContext status ensureIsSuccess ]
		raise: AeCairoStatusError
		whoseDescriptionIncludes: expectedStatusDescription
		description: 'Invalid surface'.

]
