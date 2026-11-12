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

{ #category : #clipping }
AthensAeCairoCanvas >> clipRect [

	| origin |
	currentClipRect ifNil: [
		origin := pathTransform
			ifNotNil: [ pathTransform inverted transform: 0 @ 0 ]
			ifNil: [ 0 @ 0 ].
		currentClipRect := origin extent: self surface extent ].

	^ currentClipRect
]

{ #category : #drawing }
AthensAeCairoCanvas >> copyPage [

	surface copyPage
]

{ #category : #drawing }
AthensAeCairoCanvas >> draw [
	"Fill the currently selected shape (applying path matrix) with currently selected paint (applying paint matrix)"

	self setPathMatrix.

	^ shape paintFillsUsing: paint on: self
]

{ #category : #'drawing text' }
AthensAeCairoCanvas >> drawString: aString [

	fontRenderer ifNil: [ self setFont: StandardFonts defaultFont ].
	^ super drawString: aString
]

{ #category : #'drawing text' }
AthensAeCairoCanvas >> drawString: aString from: startIndex to: endIndex [

	fontRenderer ifNil: [ self setFont: StandardFonts defaultFont ].
	^ super drawString: aString from: startIndex to: endIndex
]

{ #category : #drawing }
AthensAeCairoCanvas >> drawWithAlpha: aNumber [

	cairoContext paintWithAlpha: aNumber asFloat
]

{ #category : #drawing }
AthensAeCairoCanvas >> fill [
	
	cairoContext fill
]

{ #category : #drawing }
AthensAeCairoCanvas >> fillPreserve [

	cairoContext fillPreserve
]

{ #category : #drawing }
AthensAeCairoCanvas >> fillRule [

	^ cairoContext fillRule
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

{ #category : #drawing }
AthensAeCairoCanvas >> getCurrentPoint [

	^ cairoContext currentPointInUserSpace
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
AthensAeCairoCanvas >> loadPath: anAthensPath [

	anAthensPath loadOnCairoCanvas: self
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

{ #category : #clipping }
AthensAeCairoCanvas >> resetClip [

	cairoContext resetClip.
	currentClipRect := nil
]

{ #category : #drawing }
AthensAeCairoCanvas >> resetDash [

	cairoContext resetStrokeDashPattern
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

{ #category : #drawing }
AthensAeCairoCanvas >> showPage [

	surface showPage
]

{ #category : #'API - painting' }
AthensAeCairoCanvas >> stroke [
	
	cairoContext stroke
]

{ #category : #'drawing text' }
AthensAeCairoCanvas >> text: aString extents: aCairoTextExtents [

	cairoContext getTextExtentsOf: aString utf8Encoded into: aCairoTextExtents
]

{ #category : #transformations }
AthensAeCairoCanvas >> transformBy: aDisplayTransform withClip: aClipRectangle in: aSubRectangle during: aDrawBlock [

	self clipBy: currentClipRect during: [
		| subClip oldClip |
		subClip := aDisplayTransform globalBoundsToLocal: aClipRectangle.
		oldClip := currentClipRect.
		currentClipRect := aDisplayTransform globalBoundsToLocal: self clipRect.
		pathTransform restoreAfter: [
			pathTransform translateBy: aDisplayTransform offset negated.
			pathTransform rotateByRadians: aDisplayTransform angle negated.
			pathTransform scaleBy: aDisplayTransform scale.
			self clipBy: subClip during: [ aDrawBlock value: self ] ].
		currentClipRect := oldClip ]
]
