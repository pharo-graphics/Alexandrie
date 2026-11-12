Class {
	#name : #AthensAeCairoPathTest,
	#superclass : #TestCase,
	#category : #'Alexandrie-Athens-Tests'
}

{ #category : #tests }
AthensAeCairoPathTest >> testCcwArc [

	| surface path |
	surface := AthensAeCairoSurface extent: 100 @ 100.
	path := surface createPath: [ :builder |
		builder
			absolute;
			moveTo: 50 @ 10;
			ccwArcTo: 10 @ 50 angle: Float halfPi;
			close ].
	self assert: (path isKindOf: AthensAeCairoPath)
]

{ #category : #tests }
AthensAeCairoPathTest >> testCwArc [

	| surface path |
	surface := AthensAeCairoSurface extent: 100 @ 100.
	path := surface createPath: [ :builder |
		builder
			absolute;
			moveTo: 10 @ 50;
			cwArcTo: 50 @ 10 angle: Float halfPi;
			close ].
	self assert: (path isKindOf: AthensAeCairoPath)
]

{ #category : #tests }
AthensAeCairoPathTest >> testGetCurrentPoint [

	| surface currentPt |
	surface := AthensAeCairoSurface extent: 100 @ 100.
	surface createPath: [ :builder |
		builder
			absolute;
			moveTo: 25 @ 35.
		currentPt := builder getCurrentPoint ].
	self assert: currentPt equals: 25.0 @ 35.0
]

{ #category : #tests }
AthensAeCairoPathTest >> testReflectedCurve [

	| surface path |
	surface := AthensAeCairoSurface extent: 100 @ 100.
	path := surface createPath: [ :builder |
		builder
			absolute;
			moveTo: 10 @ 10;
			curveVia: 20 @ 30 and: 40 @ 30 to: 50 @ 10;
			reflectedCurveVia: 80 @ -10 to: 90 @ 10 ].
	self assert: (path isKindOf: AthensAeCairoPath)
]

{ #category : #tests }
AthensAeCairoPathTest >> testSimpleLines [

	| surface path |
	surface := AthensAeCairoSurface extent: 100 @ 100.
	path := surface createPath: [ :builder |
		builder
			absolute;
			moveTo: 10 @ 10;
			lineTo: 50 @ 10;
			lineTo: 50 @ 50;
			close ].
	self assert: (path isKindOf: AthensAeCairoPath).
	self assert: path cairoPath isNotNil
]
