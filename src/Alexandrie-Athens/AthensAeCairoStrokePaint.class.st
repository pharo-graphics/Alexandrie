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
		rectangle: aRectangle;
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

{ #category : #'setting - join styles' }
AthensAeCairoStrokePaint >> joinMiter [
	
	joinStyle := AeCairoJoinStyle miter
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
