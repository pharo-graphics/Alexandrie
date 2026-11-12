Class {
	#name : #AthensAeCairoStrokePaint,
	#superclass : #AthensStrokePaint,
	#instVars : [
		'capStyle',
		'joinStyle',
		'dashOffset',
		'dashLengths'
	],
	#category : #'Alexandrie-Athens'
}

{ #category : #rendering }
AthensAeCairoStrokePaint >> athensFillPath: aPath on: aCanvas [

	self prepareForDrawingOn: aCanvas.

	aCanvas
		newPath;
		loadPath: aPath;
		stroke
]

{ #category : #rendering }
AthensAeCairoStrokePaint >> athensFillRectangle: aRectangle on: aCanvas [

	self prepareForDrawingOn: aCanvas.

	aCanvas
		newPath;
		rectangle: aRectangle;
		stroke
]

{ #category : #'setting - cap styles' }
AthensAeCairoStrokePaint >> capButt [
	
	capStyle := AeCairoStrokeCap butt
]

{ #category : #'setting - cap styles' }
AthensAeCairoStrokePaint >> capRound [

	capStyle := AeCairoStrokeCap round
]

{ #category : #'setting - cap styles' }
AthensAeCairoStrokePaint >> capSquare [

	capStyle := AeCairoStrokeCap square
]

{ #category : #'setting - dashes' }
AthensAeCairoStrokePaint >> dashes: anAlternateCollectionOfLengths offset: anOffset [

	dashLengths := anAlternateCollectionOfLengths.
	dashOffset := anOffset asFloat
]

{ #category : #'setting - join styles' }
AthensAeCairoStrokePaint >> joinBevel [

	joinStyle := AeCairoStrokeJoin bevel
]

{ #category : #'setting - join styles' }
AthensAeCairoStrokePaint >> joinMiter [
	
	joinStyle := AeCairoStrokeJoin miter
]

{ #category : #'setting - join styles' }
AthensAeCairoStrokePaint >> joinRound [

	joinStyle := AeCairoStrokeJoin round
]

{ #category : #private }
AthensAeCairoStrokePaint >> prepareForDrawingOn: aCanvas [

	fillPaint isColor
		ifTrue: [
			aCanvas
				setSourceR: fillPaint red
				g: fillPaint green
				b: fillPaint blue
				a: fillPaint alpha ]
		ifFalse: [
			fillPaint loadOnCairoCanvas: aCanvas ].

	aCanvas cairoContext
		strokeSize: width;
		strokeJoin: joinStyle;
		strokeCap: capStyle.

	dashLengths ifNil: [ aCanvas resetDash ] ifNotNil: [ self setDashesOn: aCanvas ]
]

{ #category : #private }
AthensAeCairoStrokePaint >> setDashesOn: aCanvas [

	aCanvas cairoContext strokeDashPattern: dashLengths offset: dashOffset
]
