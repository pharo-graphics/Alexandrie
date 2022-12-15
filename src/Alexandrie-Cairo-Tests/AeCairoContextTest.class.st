Class {
	#name : #AeCairoContextTest,
	#superclass : #TestCase,
	#instVars : [
		'surface',
		'context'
	],
	#category : #'Alexandrie-Cairo-Tests'
}

{ #category : #tests }
AeCairoContextTest >> testisPathExtents [

	surface := AeCairoImageSurface extent: 100 @ 100.
	context := surface newContext.
	
	self
		assert: context pathExtents
		equals: (Rectangle origin: 0 asPoint extent: 0 asPoint).
	
	context
		moveTo: 5@10;
		lineTo: 90@50;
		fillPreserve.

	self
		assert: context pathExtents
		equals: (Rectangle origin: 5.0@10.0 corner: 90.0@50.0).

	context fill.
	
	self
		assert: context pathExtents
		equals: (Rectangle origin: 0 asPoint extent: 0 asPoint).

]
