"
I'm an AthensCanvas that uses Alexandrie as backend.
"
Class {
	#name : #AthensAeCairoCanvas,
	#superclass : #AthensCanvas,
	#instVars : [
		'cairoContext',
		'pathTransform',
		'paintTransform',
		'currentClipRect',
		'freetypeRenderer'
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

{ #category : #clipping }
AthensAeCairoCanvas >> clipBy: aRectangle during: aBlock [
	"Set a clipping rectangle during drawing operations performed in aBlock.
	Note that the clipping rectangle is intersected with the currently active clipping rectangle"

	| oldClip transformedClipRectangle newClip |
	oldClip := currentClipRect.
	transformedClipRectangle := pathTransform transformRectangle: aRectangle.
	newClip := oldClip
		ifNil: [ transformedClipRectangle ]
		ifNotNil: [
			oldClip
				intersect: transformedClipRectangle
				ifNone:[ ^ self ] ].

	self setPathMatrix.
	cairoContext saveState.
	self pushClipRect: aRectangle.

	currentClipRect := newClip.

	aBlock ensure: [
		cairoContext restoreState.
		currentClipRect := oldClip ]
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

{ #category : #drawing }
AthensAeCairoCanvas >> fillRuleEvenOdd [

	cairoContext useFillRuleEvenOdd
]

{ #category : #accessing }
AthensAeCairoCanvas >> fillRuleWinding [
	
	cairoContext useFillRuleWinding
]

{ #category : #accessing }
AthensAeCairoCanvas >> fontRendererForLogicalFont: aFont [ 
	
	^ self freetypeRenderer
		  logicalFont: aFont;
		  advance: 0 @ 0;
		  yourself
]

{ #category : #accessing }
AthensAeCairoCanvas >> freetypeRenderer [

	^ freetypeRenderer ifNil: [
		freetypeRenderer := AthensAeCairoFreetypeRenderer on: self ]
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

{ #category : #clipping }
AthensAeCairoCanvas >> pushClipRect: aRectangle [

	self
		newPath;
		rectangle: aRectangle.
	cairoContext clip
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

	cairoContext resetStrokeDashPattern
]

{ #category : #'drawing text' }
AthensAeCairoCanvas >> setFont: aFont [

	fontRenderer := aFont athensAeCairoFontRendererFor: self
]

{ #category : #initialization }
AthensAeCairoCanvas >> setFontSize: aNumber [ 

	cairoContext fontSize: aNumber
]

{ #category : #drawing }
AthensAeCairoCanvas >> setPathMatrix [

	cairoContext matrix: pathTransform cairoMatrix

]

{ #category : #'drawing text' }
AthensAeCairoCanvas >> setScaledFont: aCairoScaledFont [
	
	cairoContext scaledFont: aCairoScaledFont
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
