Class {
	#name : #AthensAeCairoMatrix,
	#superclass : #Object,
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
AthensAeCairoMatrix >> loadIdentity [
	
	cairoMatrix beIdentity 
]

{ #category : #'as yet unclassified' }
AthensAeCairoMatrix >> loadInvertedOnPattern: aPattern [

	aPattern matrix:
		(cairoMatrix isIdentity
			ifTrue: [ cairoMatrix ]
			ifFalse: [ cairoMatrix inverted ])
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

{ #category : #transforming }
AthensAeCairoMatrix >> translateBy: aPoint [

	self translateX: aPoint x Y: aPoint y
]

{ #category : #transformations }
AthensAeCairoMatrix >> translateX: x Y: y [
	
	cairoMatrix translateByX: x y: y
]
