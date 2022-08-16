"
An AeCanvasTest is a test class for testing the behavior of AeCanvas
"
Class {
	#name : #AeCanvasTest,
	#superclass : #TestCase,
	#category : #'Alexandrie-Canvas-Tests-Base'
}

{ #category : #tests }
AeCanvasTest >> testAsForm [

	| aCanvas |
	aCanvas := AeCanvas extent: 200 asPoint.

	aCanvas flush.
	self assert: aCanvas asForm class equals: Form

]

{ #category : #tests }
AeCanvasTest >> testDrawArbitraryFigure [

	| aeCanvas |
	aeCanvas := AeCanvas extent: 200 asPoint.

	"aeCanvas setBackgroundOff."
	aeCanvas
		setBackgroundWith: [ aeCanvas setSourceColor: Color blue ]
		alpha: 1.0.
	aeCanvas setBorderOff.

	aeCanvas
		setPathKey: self
		hasJoins: true
		hasCaps: true
		block: [ :cairoContext |
			cairoContext
				rectangle: (0 asPoint extent: 20 asPoint);
				circleRadius: 20 ].

	aeCanvas drawFigure.


	aeCanvas flush.
	self assert: aeCanvas asForm class equals: Form

]

{ #category : #tests }
AeCanvasTest >> testDrawClosedFigure [

	| aeCanvas |
	aeCanvas := AeCanvas extent: 200 asPoint.

	"aeCanvas setBackgroundOff."
	aeCanvas
		setBackgroundWith: [ aeCanvas setSourceColor: Color blue ]
		alpha: 1.0.
	aeCanvas setBorderOff.

	aeCanvas drawClosedPathWith: [ :cairoContext |
		cairoContext rectangle: (10 asPoint extent: 20 asPoint) ].

	aeCanvas drawFigure.


	aeCanvas flush.
	self assert: aeCanvas asForm class equals: Form

]

{ #category : #tests }
AeCanvasTest >> testDrawCurvedFigure [

	| aeCanvas |
	aeCanvas := AeCanvas extent: 200 asPoint.

	"aeCanvas setBackgroundOff."
	aeCanvas
		setBackgroundWith: [ aeCanvas setSourceColor: Color blue ]
		alpha: 1.0.
	aeCanvas setBorderOff.

	aeCanvas drawClosedCurvedPathWith: [ :cairoContext |
		cairoContext circleRadius: 10 ].

	aeCanvas drawFigure.


	aeCanvas flush.
	self assert: aeCanvas asForm class equals: Form

]

{ #category : #tests }
AeCanvasTest >> testDrawOpenFigure [

	| aeCanvas |
	aeCanvas := AeCanvas extent: 200 asPoint.

	"aeCanvas setBackgroundOff."
	aeCanvas
		setBackgroundWith: [ aeCanvas setSourceColor: Color blue ]
		alpha: 1.0.
	aeCanvas setBorderOff.

	aeCanvas drawOpenPathWith: [ :cairoContext |
		cairoContext lineTo: 10 asPoint ].

	aeCanvas drawFigure.


	aeCanvas flush.
	self assert: aeCanvas asForm class equals: Form

]
