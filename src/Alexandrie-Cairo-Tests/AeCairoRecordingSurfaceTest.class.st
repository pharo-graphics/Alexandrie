Class {
	#name : #AeCairoRecordingSurfaceTest,
	#superclass : #TestCase,
	#category : #'Alexandrie-Cairo-Tests'
}

{ #category : #tests }
AeCairoRecordingSurfaceTest >> testInkExtentsInBoundedSurface [

	| aRectangle aRecordingSurface |
	aRectangle := 5 @ 10 extent: 15 @ 20.

	aRecordingSurface :=
		AeCairoRecordingSurface
			newContentType: AeCairoContent colorOnly
			bounds: (AeCairoRectangle origin: aRectangle origin extent: aRectangle extent).

	aRecordingSurface newContext
		sourceColor: Color cyan;
		rectangle: aRectangle;
		strokeSize: 10; 
		stroke.

	self
		assert: aRecordingSurface inkBounds
		equals: aRectangle "Stroke was clipped"
]

{ #category : #tests }
AeCairoRecordingSurfaceTest >> testInkExtentsInUnboundedSurface [

	| aRectangle aRecordingSurface |
	aRectangle := 5 @ 10 extent: 15 @ 20.

	aRecordingSurface :=
		AeCairoRecordingSurface
			newContentType: AeCairoContent colorOnly
			bounds: AeCairoRectangle null.

	aRecordingSurface newContext
		sourceColor: Color cyan;
		rectangle: aRectangle;
		strokeSize: 10; 
		stroke.

	self
		assert: aRecordingSurface inkBounds
		equals: (aRectangle expandBy: 5). "Half of line width"
]
