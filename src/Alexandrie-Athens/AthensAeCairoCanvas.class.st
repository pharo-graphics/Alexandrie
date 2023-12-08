Class {
	#name : #AthensAeCairoCanvas,
	#superclass : #AthensCanvas,
	#instVars : [
		'cairoContext',
		'pathTransform',
		'paintTransform'
	],
	#category : #'Alexandrie-Athens'
}

{ #category : #'instance creation' }
AthensAeCairoCanvas class >> on: aSurface [

	^ self basicNew
		initializeWithSurface: aSurface;
		yourself
]

{ #category : #accessing }
AthensAeCairoCanvas >> cairoContext [

	^ cairoContext
]

{ #category : #drawing }
AthensAeCairoCanvas >> draw [
	"Fill the currently selected shape (applying path matrix) with currently selected paint (applying paint matrix)"

	self setPathMatrix.

	^ shape paintFillsUsing: paint on: self
]

{ #category : #drawing }
AthensAeCairoCanvas >> fill [
	
	cairoContext fill
]

{ #category : #initialization }
AthensAeCairoCanvas >> initializeWithSurface: aSurface [

	super initializeWithSurface: aSurface.

	pathTransform := AthensAeCairoMatrix new.
	paintTransform := AthensAeCairoMatrix new.
	
	cairoContext := aSurface cairoSurface newContext.
	cairoContext antialias: AeCairoAntialias good.

	paintMode := AthensAeCairoPaintMode on: cairoContext
]

{ #category : #private }
AthensAeCairoCanvas >> loadPath: aCairoPath [ 

	cairoContext appendPath: aCairoPath
]

{ #category : #'instance creation' }
AthensAeCairoCanvas >> newPath [
	
	cairoContext resetPath
]

{ #category : #'transformation matrices' }
AthensAeCairoCanvas >> paintTransform [
	
	^ paintTransform
]

{ #category : #'transformation matrices' }
AthensAeCairoCanvas >> pathTransform [
	
	^ pathTransform
]

{ #category : #drawing }
AthensAeCairoCanvas >> prepareToDraw [

	pathTransform loadIdentity.
	paintTransform loadIdentity.
	paintMode over
]

{ #category : #drawing }
AthensAeCairoCanvas >> rectangle: aRectangle [

	cairoContext rectangle: aRectangle
]

{ #category : #drawing }
AthensAeCairoCanvas >> rectangleX: x y: y width: aWidth height: aHeight [

	cairoContext
		rectangleX: x
		y: y
		width: aWidth
		height: aHeight
]

{ #category : #drawing }
AthensAeCairoCanvas >> resetDash [

	cairoContext dashDisable
]

{ #category : #drawing }
AthensAeCairoCanvas >> setPathMatrix [

	cairoContext matrix: pathTransform cairoMatrix

]

{ #category : #drawing }
AthensAeCairoCanvas >> setSourceR: red g: green b: blue a: alpha [

	cairoContext
		sourceColorR: red
		g: green
		b: blue
		a: alpha
]

{ #category : #'API - painting' }
AthensAeCairoCanvas >> stroke [
	
	cairoContext stroke
]
