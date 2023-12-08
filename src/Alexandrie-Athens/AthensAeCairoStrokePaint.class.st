Class {
	#name : #AthensAeCairoStrokePaint,
	#superclass : #AthensStrokePaint,
	#instVars : [
		'capStyle',
		'joinStyle',
		'dashLenghts'
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
		rectangleX: aRectangle left
			y: aRectangle right
			width: aRectangle width
			height: aRectangle height;
		stroke
]

{ #category : #'setting - cap styles' }
AthensAeCairoStrokePaint >> capButt [
	
	capStyle := AeCairoCapStyle butt
]

{ #category : #'setting - join styles' }
AthensAeCairoStrokePaint >> joinBevel [

	joinStyle := AeCairoJoinStyle bevel
]

{ #category : #private }
AthensAeCairoStrokePaint >> prepareForDrawingOn: aCanvas [

	fillPaint loadOnCairoCanvas: aCanvas.

	aCanvas cairoContext
		lineWidth: width;
		lineJoin: joinStyle;
		lineCap: capStyle.

	dashLenghts
		ifNil: [ aCanvas resetDash ]
		ifNotNil: [ self setDashesOn: aCanvas ]
]
