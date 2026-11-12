Class {
	#name : #AthensAeCairoMatrix,
	#superclass : #AthensTransform,
	#instVars : [
		'cairoMatrix'
	],
	#category : #'Alexandrie-Athens'
}

{ #category : #accessing }
AthensAeCairoMatrix >> cairoMatrix [

	^ cairoMatrix
]

{ #category : #initialization }
AthensAeCairoMatrix >> initialize [

	super initialize.
	
	cairoMatrix := AeCairoMatrix newIdentity
]

{ #category : #transformations }
AthensAeCairoMatrix >> inverseTransform: aPoint [

	^ self inverted transform: aPoint
]

{ #category : #transformations }
AthensAeCairoMatrix >> invert [

	cairoMatrix invert
]

{ #category : #transformations }
AthensAeCairoMatrix >> inverted [

	^ self copy
		invert;
		yourself
]

{ #category : #testing }
AthensAeCairoMatrix >> isAffineTransform [

	^ true
]

{ #category : #testing }
AthensAeCairoMatrix >> isIdentity [

	^ cairoMatrix isIdentity
]

{ #category : #transformations }
AthensAeCairoMatrix >> loadAffineTransform: anAthensTransform [

	cairoMatrix
		sx: anAthensTransform sx;
		sy: anAthensTransform sy;
		shx: anAthensTransform shx;
		shy: anAthensTransform shy;
		x: anAthensTransform x;
		y: anAthensTransform y
]

{ #category : #transformations }
AthensAeCairoMatrix >> loadIdentity [
	
	cairoMatrix beIdentity 
]

{ #category : #transformations }
AthensAeCairoMatrix >> loadInvertedOnPattern: aPattern [

	aPattern matrix:
		(cairoMatrix isIdentity
			ifTrue: [ cairoMatrix ]
			ifFalse: [ cairoMatrix inverted ])
]

{ #category : #transformations }
AthensAeCairoMatrix >> multiplyBy: anAthensTransform [

	| operandMatrix |
	operandMatrix := self class new loadAffineTransform: anAthensTransform.
	cairoMatrix preMultiply: operandMatrix cairoMatrix
]

{ #category : #copying }
AthensAeCairoMatrix >> postCopy [

	super postCopy.
	cairoMatrix := cairoMatrix copy
]

{ #category : #transformations }
AthensAeCairoMatrix >> restoreAfter: aBlock [

	| aMatrix |
	aMatrix := cairoMatrix copy.
	aBlock ensure: [ cairoMatrix := aMatrix ]
]

{ #category : #transformations }
AthensAeCairoMatrix >> rotateByDegrees: angle [

	self rotateByRadians: angle degreesToRadians
]

{ #category : #transformations }
AthensAeCairoMatrix >> rotateByRadians: angle [

	cairoMatrix rotateByRadians: angle
]

{ #category : #transforming }
AthensAeCairoMatrix >> scaleBy: factor [
	"If factor is number, do a uniform scale.
	If not, then factor is a Point containing non-uniform scale for each axis"

	factor isPoint
		ifTrue: [ self scaleX: factor x asFloat Y: factor y asFloat ]
		ifFalse: [ self scaleX: factor asFloat Y: factor asFloat ]
]

{ #category : #transformations }
AthensAeCairoMatrix >> scaleX: fx Y: fy [

	cairoMatrix scaleByX: fx y: fy
]

{ #category : #accessing }
AthensAeCairoMatrix >> shx [

	^ cairoMatrix shx
]

{ #category : #accessing }
AthensAeCairoMatrix >> shx: aNumber [

	cairoMatrix shx: aNumber
]

{ #category : #accessing }
AthensAeCairoMatrix >> shy [

	^ cairoMatrix shy
]

{ #category : #accessing }
AthensAeCairoMatrix >> shy: aNumber [

	cairoMatrix shy: aNumber
]

{ #category : #accessing }
AthensAeCairoMatrix >> sx [

	^ cairoMatrix sx
]

{ #category : #accessing }
AthensAeCairoMatrix >> sx: aNumber [

	cairoMatrix sx: aNumber
]

{ #category : #accessing }
AthensAeCairoMatrix >> sy [

	^ cairoMatrix sy
]

{ #category : #accessing }
AthensAeCairoMatrix >> sy: aNumber [

	cairoMatrix sy: aNumber
]

{ #category : #accessing }
AthensAeCairoMatrix >> transform: aPoint [

	^ cairoMatrix value: aPoint
]

{ #category : #transformations }
AthensAeCairoMatrix >> transformRectangle: aRectangle [

	^ Rectangle encompassing: {
		self transform: aRectangle bottomLeft.
		self transform: aRectangle bottomRight.
		self transform: aRectangle topLeft.
		self transform: aRectangle topRight }
]

{ #category : #transformations }
AthensAeCairoMatrix >> transformX: px Y: py [

	^ cairoMatrix valueOnX: px onY: py
]

{ #category : #transforming }
AthensAeCairoMatrix >> translateBy: aPoint [

	self translateX: aPoint x Y: aPoint y
]

{ #category : #transformations }
AthensAeCairoMatrix >> translateX: x Y: y [
	
	cairoMatrix translateByX: x y: y
]

{ #category : #accessing }
AthensAeCairoMatrix >> x [

	^ cairoMatrix x
]

{ #category : #accessing }
AthensAeCairoMatrix >> x: aNumber [

	cairoMatrix x: aNumber
]

{ #category : #accessing }
AthensAeCairoMatrix >> y [

	^ cairoMatrix y
]

{ #category : #accessing }
AthensAeCairoMatrix >> y: aNumber [

	cairoMatrix y: aNumber
]
