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
AeCairoContextTest >> testCurrentPoint [

	surface := AeCairoImageSurface extent: 100 @ 100.
	context := surface newContext.
	
	self deny: context hasCurrentPoint.
	
	context
		translateBy: 3 @ 7;
		scaleByX: 0.5 y: 2.
		
	self deny: context hasCurrentPoint.

	context moveTo: 5 @ 11.
	
	self assert: context hasCurrentPoint.
	self
		assert: context currentPointInUserSpace
		equals: 5 @ 11.
	self
		assert: context currentPointInDeviceSpace
		equals: (3+(5*0.5)) @ (7+(11*2)).

	context stroke.

	self deny: context hasCurrentPoint.

]

{ #category : #tests }
AeCairoContextTest >> testPathExtents [

	surface := AeCairoImageSurface extent: 100 @ 100.
	context := surface newContext.
	
	self
		assert: context pathExtentsInUserSpace
		equals: (Rectangle origin: 0 asPoint extent: 0 asPoint).
	self
		assert: context pathExtentsInDeviceSpace
		equals: (Rectangle origin: 0 asPoint extent: 0 asPoint).
	
	context
		translateBy: -1 @ -2;
		scaleByX: 0.5 y: 2;
		moveTo: 5 @ 10;
		lineTo: 90 @ 50;
		fillPreserve.

	self
		assert: context pathExtentsInUserSpace
		equals: (Rectangle origin: 5.0 @ 10.0 corner: 90.0 @ 50.0).
	self
		assert: context pathExtentsInDeviceSpace
		equals: (Rectangle origin: 1.5 @ 18.0 corner: 44.0 @ 98.0).

	context fill.
	
	self
		assert: context pathExtentsInUserSpace
		equals: (Rectangle origin: 0 asPoint extent: 0 asPoint).
	self
		assert: context pathExtentsInDeviceSpace
		equals: (Rectangle origin: -1 @ -2 extent: 0 asPoint).

]
