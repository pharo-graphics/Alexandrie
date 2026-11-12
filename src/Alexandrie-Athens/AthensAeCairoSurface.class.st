Class {
	#name : #AthensAeCairoSurface,
	#superclass : #AthensSurface,
	#instVars : [
		'cairoSurface',
		'canvas',
		'pathBuilder',
		'freetypeRenderer'
	],
	#category : #'Alexandrie-Athens'
}

{ #category : #'instance creation' }
AthensAeCairoSurface class >> createFromFile: aFileName ifFailed: aBlock [

	| fileReference imageSurface |
	fileReference := aFileName asFileReference.
	fileReference exists ifFalse: [ ^ aBlock value: #fileNotFound ].
	imageSurface := [ AeCairoImageSurface newFromPngFileAt: fileReference ]
		on: Error
		do: [ :anError | ^ aBlock value: anError description ].
	^ self on: imageSurface
]

{ #category : #'instance creation' }
AthensAeCairoSurface class >> extent: aPoint [

	^ self on: (AeCairoImageSurface extent: aPoint)
]

{ #category : #'instance creation' }
AthensAeCairoSurface class >> extent: aPoint format: anAeCairoSurfaceFormat [

	^ self on: (AeCairoImageSurface extent: aPoint format: anAeCairoSurfaceFormat)
]

{ #category : #'instance creation' }
AthensAeCairoSurface class >> fromForm: aForm [

	^ self on: (AeCairoImageSurface fromForm: (aForm asFormOfDepth: 32))
]

{ #category : #'instance creation' }
AthensAeCairoSurface class >> on: aCairoSurface [

	^ self basicNew
		initializeOn: aCairoSurface;
		yourself
]

{ #category : #converting }
AthensAeCairoSurface >> asAthensPaintOn: aCanvas [

	^ AthensAeCairoPatternPaint on: cairoSurface asCairoPattern
]

{ #category : #converting }
AthensAeCairoSurface >> asForm [

	^ cairoSurface asForm
]

{ #category : #public }
AthensAeCairoSurface >> attemptToRecurseDrawing [

	^ self flag: #athens. "Should signal a warning or error"
]

{ #category : #caching }
AthensAeCairoSurface >> cacheAt: anObject ifAbsentPut: aBlock [

	^ AthensAeCairoBackendCache soleInstance at: anObject ifAbsentPut: aBlock
]

{ #category : #accessing }
AthensAeCairoSurface >> cairoSurface [

	^ cairoSurface
]

{ #category : #public }
AthensAeCairoSurface >> checkSession [

	cairoSurface isNull ifTrue: [ 
		self error: 'Attempt to use invalid external resource (left from previous session)' ]
]

{ #category : #public }
AthensAeCairoSurface >> clear [
	
	canvas cairoContext clearTransparent
]

{ #category : #public }
AthensAeCairoSurface >> clear: clearPaint [

	currentCanvas pathTransform restoreAfter: [
		currentCanvas pathTransform loadIdentity.
		currentCanvas paintMode restoreAfter: [
			currentCanvas paintMode source.
			currentCanvas
				setPaint: clearPaint;
				drawShape: (0@0 extent: self extent) ] ]
]

{ #category : #drawing }
AthensAeCairoSurface >> copyPage [

	cairoSurface copyPage
]

{ #category : #paints }
AthensAeCairoSurface >> createFormPaint: aForm [

	| newSurface |
	newSurface := AeCairoImageSurface fromForm: (aForm asFormOfDepth: 32).
	^ AthensAeCairoPatternPaint on: newSurface asCairoPattern
]

{ #category : #paints }
AthensAeCairoSurface >> createLinearGradient: aColorRamp start: aStartPoint stop: aStopPoint [

	| pattern |
	pattern := AeCairoLinearGradientPattern from: aStartPoint to: aStopPoint addStopsFrom: aColorRamp.
	^ AthensAeCairoPaint on: pattern
]

{ #category : #paints }
AthensAeCairoSurface >> createMeshGradientWithPatches: aListOfMeshPatches [

	^ AthensAeCairoMeshGradientPaint withPatches: aListOfMeshPatches
]

{ #category : #paths }
AthensAeCairoSurface >> createPath: aPathCreatingBlock [

	^ pathBuilder createPath: aPathCreatingBlock
]

{ #category : #paints }
AthensAeCairoSurface >> createRadialGradient: colorRamp center: aCenter radius: aRadius focalPoint: aFocalPoint [

	| pattern |
	pattern := AeCairoRadialGradientPattern
		innerCenter: aFocalPoint
		innerRadius: 0.0
		outerCenter: aCenter
		outerRadius: aRadius
		addStopsFrom: colorRamp.
	^ AthensAeCairoPaint on: pattern
]

{ #category : #paints }
AthensAeCairoSurface >> createSolidColorPaint: aColor [

	^ AthensAeCairoPaint on: (AeCairoColorPattern newFrom: aColor)
]

{ #category : #paints }
AthensAeCairoSurface >> createStrokePaintFor: aPaint [

	^ AthensAeCairoStrokePaint new
		fillPaint: aPaint;
		yourself
]

{ #category : #public }
AthensAeCairoSurface >> deviceScale: aNumber [

	cairoSurface deviceScale: aNumber asFloat
]

{ #category : #public }
AthensAeCairoSurface >> deviceScaleX: sx y: sy [

	cairoSurface deviceScaleX: sx asFloat y: sy asFloat
]

{ #category : #public }
AthensAeCairoSurface >> displayOnMorphicCanvas: aCanvas at: aPoint [

	aCanvas
		image: self asForm
		at: aPoint
		sourceRect: (0 @ 0 extent: self extent)
		rule: 34
]

{ #category : #public }
AthensAeCairoSurface >> drawDuring: aBlock [

	self checkSession.

	currentCanvas ifNotNil: [ self attemptToRecurseDrawing ].
	[
		currentCanvas := canvas.
		currentCanvas prepareToDraw.
		aBlock value: currentCanvas.
		self flush.
	] ensure: [ currentCanvas := nil ]
]

{ #category : #accessing }
AthensAeCairoSurface >> extent [

	^ cairoSurface extent
]

{ #category : #'rendering dispatch' }
AthensAeCairoSurface >> fillPath: aCairoPath withSolidColor: aColor [ 

	self loadSolidColor: aColor.

	currentCanvas cairoContext
		resetPath;
		appendPath: aCairoPath;
		fill
]

{ #category : #'rendering dispatch' }
AthensAeCairoSurface >> fillRectangle: aRectangle withSolidColor: aColor [

	self loadSolidColor: aColor.

	currentCanvas
		newPath;
		rectangleX: aRectangle left asFloat
		y: aRectangle top asFloat
		width: aRectangle width asFloat
		height: aRectangle height asFloat;
		fill
]

{ #category : #public }
AthensAeCairoSurface >> finish [

	cairoSurface finish
]

{ #category : #accessing }
AthensAeCairoSurface >> flush [
	
	cairoSurface flush
]

{ #category : #caching }
AthensAeCairoSurface >> flushCacheAt: anObject [

	AthensAeCairoBackendCache soleInstance removeAt: anObject
]

{ #category : #'text support' }
AthensAeCairoSurface >> getFreetypeFontRendererFor: aFreeTypeFont [

	^ freetypeRenderer
		  font: aFreeTypeFont;
		  advance: 0 @ 0;
		  yourself
]

{ #category : #'text support' }
AthensAeCairoSurface >> getStrikeFontRendererFor: aStrikeFont [

	^ AthensAeCairoStrikeFontRenderer on: canvas forFont: aStrikeFont
]

{ #category : #initialization }
AthensAeCairoSurface >> initializeOn: aCairoSurface [

	self initialize.
	
	cairoSurface := aCairoSurface.
	canvas := self newCanvas.
	pathBuilder := AthensAeCairoPathBuilder on: canvas cairoContext.
	freetypeRenderer := AthensAeCairoFreetypeRenderer on: canvas.
]

{ #category : #'debugging - new tools' }
AthensAeCairoSurface >> inspectionOfSurfaceAsForm: aBuilder [
	<inspectorPresentationOrder: 0 title: 'Surface'>

	^ cairoSurface inspectionAsForm: aBuilder
]

{ #category : #'rendering dispatch' }
AthensAeCairoSurface >> loadSolidColor: aColor [

	currentCanvas
		setSourceR: aColor red
		g: aColor green
		b: aColor blue
		a: aColor alpha;
		resetDash
]

{ #category : #private }
AthensAeCairoSurface >> newCanvas [

	^ AthensAeCairoCanvas on: self
]

{ #category : #drawing }
AthensAeCairoSurface >> showPage [

	cairoSurface showPage
]

{ #category : #public }
AthensAeCairoSurface >> writeToPng: aFileName [

	cairoSurface writePngToPathString: aFileName asFileReference fullName
]
