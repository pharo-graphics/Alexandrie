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
	context := AeCairoContext create: surface.

	self deny: context isNil
]
