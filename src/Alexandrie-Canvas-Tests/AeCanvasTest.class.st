"
An AeCanvasTest is a test class for testing the behavior of AeCanvas
"
Class {
	#name : #AeCanvasTest,
	#superclass : #TestCase,
	#category : #'Alexandrie-Canvas-Tests-Base'
}

{ #category : #tests }
AeCanvasTest >> testClear [

	| aeCanvas |
	aeCanvas := AeCanvas extent: 50 asPoint.
	aeCanvas clear: Color green.
	aeCanvas clearTransparent.
	aeCanvas flush.
	self assert: aeCanvas asForm class equals: Form

]

{ #category : #tests }
AeCanvasTest >> testDrawArbitraryFigure [

	| aeCanvas |
	aeCanvas := AeCanvas extent: 200 asPoint.

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
	aeCanvas := AeCanvas extent: 50 asPoint.

	aeCanvas setBackgroundOff.

	aeCanvas setOutskirtsCentered.
	aeCanvas setBorderBlock: [
		aeCanvas setSourceColor: Color red.
		aeCanvas setDashes: #(4 6) offset: 2.
		aeCanvas setLineJoinBlock: [ aeCanvas setJoinRound ].
		aeCanvas setLineCapBlock: [ aeCanvas setCapSquare ].
		aeCanvas setBorderWidth: 4 ].

	aeCanvas drawOpenPathWith: [ :cairoContext |
		cairoContext
			moveTo: 20@10;
			lineTo: 30@40 ].

	aeCanvas drawFigure.

	aeCanvas flush.
	self assert: aeCanvas asForm class equals: Form

]
