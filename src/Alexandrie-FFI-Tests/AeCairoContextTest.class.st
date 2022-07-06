Class {
	#name : #AeCairoContextTest,
	#superclass : #TestCase,
	#instVars : [
		'surface',
		'context'
	],
	#category : #'Alexandrie-FFI-Tests'
}

{ #category : #tests }
AeCairoContextTest >> testCreate [

	surface := AeCairoImageSurface extent: 100 @ 50.
	context := surface newContext.

	self deny: context isNil
]
