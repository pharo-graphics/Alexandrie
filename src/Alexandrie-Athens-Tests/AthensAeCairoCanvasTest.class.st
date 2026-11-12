Class {
	#name : #AthensAeCairoCanvasTest,
	#superclass : #TestCase,
	#category : #'Alexandrie-Athens-Tests'
}

{ #category : #tests }
AthensAeCairoCanvasTest >> testClipRect [

	| surface |
	surface := AthensAeCairoSurface extent: 100 @ 100.
	surface drawDuring: [ :canvas |
			self assert: canvas clipRect equals: (0 @ 0 extent: 100 @ 100).
			canvas clipBy: (10 @ 10 corner: 50 @ 50) during: [ self assert: canvas clipRect equals: (10 @ 10 corner: 50 @ 50) ] ]
]

{ #category : #tests }
AthensAeCairoCanvasTest >> testDrawWithAlpha [

	| surface |
	surface := AthensAeCairoSurface extent: 20 @ 20.
	surface drawDuring: [ :canvas |
		canvas setPaint: Color red.
		canvas drawWithAlpha: 0.5 ].
	self assert: surface asForm isNotNil
]

{ #category : #tests }
AthensAeCairoCanvasTest >> testFillRule [

	| surface |
	surface := AthensAeCairoSurface extent: 100 @ 100.
	surface drawDuring: [ :canvas |
		canvas fillRuleWinding.
		self assert: canvas fillRule equals: AeCairoFillRule winding.
		canvas fillRuleEvenOdd.
		self assert: canvas fillRule equals: AeCairoFillRule evenOdd ]
]

{ #category : #tests }
AthensAeCairoCanvasTest >> testGetCurrentPoint [

	| surface |
	surface := AthensAeCairoSurface extent: 100 @ 100.
	surface drawDuring: [ :canvas |
		canvas cairoContext moveToX: 25.0 y: 35.0.
		self assert: canvas getCurrentPoint equals: 25.0 @ 35.0 ]
]

{ #category : #tests }
AthensAeCairoCanvasTest >> testResetClip [

	| surface |
	surface := AthensAeCairoSurface extent: 100 @ 100.
	surface drawDuring: [ :canvas |
		canvas clipBy: (10 @ 10 corner: 50 @ 50) during: [
			canvas resetClip.
			self assert: canvas clipRect equals: (0 @ 0 extent: 100 @ 100) ] ]
]

{ #category : #tests }
AthensAeCairoCanvasTest >> testTextExtentsAnswerValidData [

	| surface cairoExtents |
	surface := AthensAeCairoSurface extent: 100 @ 100.
	surface drawDuring: [ :aCanvas |
		cairoExtents := AeCairoTextExtents new.
		self assert: cairoExtents width equals: 0.0.
		aCanvas text: 'Test' extents: cairoExtents.
		self deny: cairoExtents width equals: 0.0 ]
]
