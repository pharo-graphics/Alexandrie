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
AeCairoContextTest >> testClipExtents [

	surface := AeCairoImageSurface extent: 100 @ 100.
	context := surface newContext.
	
	self
		assert: context clipExtentsInUserSpace
		equals: (Rectangle origin: 0 @ 0 extent: 100 @ 100).
	self
		assert: context clipExtentsInDeviceSpace
		equals: (Rectangle origin: 0 @ 0 extent: 100 @ 100).
	
	context scaleByX: 0.5 y: 2.
	
	self
		assert: context clipExtentsInUserSpace
		equals: (Rectangle origin: 0 @ 0 corner: 200 @ 50).
	self
		assert: context clipExtentsInDeviceSpace
		equals: (Rectangle origin: 0 @ 0 corner: 100 @ 100).

	context
		moveTo: 5 @ 10;
		lineTo: 90 @ 50;
		clip.

	self
		assert: context clipExtentsInUserSpace
		equals: (Rectangle origin: 4 @ 10 corner: 90 @ 50).
	self
		assert: context clipExtentsInDeviceSpace
		equals: (Rectangle origin: 2 @ 20 corner: 45 @ 100).

	context resetClip.
	
	self
		assert: context clipExtentsInUserSpace
		equals: (Rectangle origin: 0 @ 0 extent: 200 @ 50).
	self
		assert: context clipExtentsInDeviceSpace
		equals: (Rectangle origin: 0 @ 0 corner: 100 @ 100).

]

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
AeCairoContextTest >> testCurrentTarget [

	surface := AeCairoImageSurface extent: 100 @ 100.
	context := surface newContext.
	
	self
		assert: context currentTarget getHandle
		equals: surface getHandle.

	context pushGroup.
	
	self
		deny: context currentTarget getHandle
		equals: surface getHandle.

]

{ #category : #tests }
AeCairoContextTest >> testFillRule [

	surface := AeCairoImageSurface extent: 100 @ 100.
	context := surface newContext.
	
	self
		assert: context fillRule
		equals: AeCairoFillRule winding.

	context fillRule: AeCairoFillRule evenOdd.

	self
		assert: context fillRule
		equals: AeCairoFillRule evenOdd.

]

{ #category : #tests }
AeCairoContextTest >> testOperator [

	surface := AeCairoImageSurface extent: 100 @ 100.
	context := surface newContext.
	
	self
		assert: context operator
		equals: AeCairoCompositionOp over.

	context setOperatorClear.

	self
		assert: context operator
		equals: AeCairoCompositionOp clear.

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

{ #category : #tests }
AeCairoContextTest >> testStrokeExtents [

	surface := AeCairoImageSurface extent: 100 @ 100.
	context := surface newContext.
	
	self
		assert: context strokeExtentsInUserSpace
		equals: (Rectangle origin: 0 asPoint extent: 0 asPoint).
	self
		assert: context strokeExtentsInDeviceSpace
		equals: (Rectangle origin: 0 asPoint extent: 0 asPoint).
	
	context
		translateBy: -1 @ -2;
		scaleByX: 0.5 y: 2;
		moveTo: 5 @ 10;
		lineTo: 90 @ 50;
		lineWidth: 10;
		strokePreserve.

	self
		assert: context strokeExtentsInUserSpace 
		equals: ((2.8671875@5.4765625) corner: (92.1328125@54.5234375)).
	self
		assert: context strokeExtentsInDeviceSpace
		equals: ((0.43359375@8.953125) corner: (45.06640625@107.046875)).

	context stroke.
	
	self
		assert: context strokeExtentsInUserSpace
		equals: (Rectangle origin: 0 asPoint extent: 0 asPoint).
	self
		assert: context strokeExtentsInDeviceSpace
		equals: (Rectangle origin: -1 @ -2 extent: 0 asPoint).

]
