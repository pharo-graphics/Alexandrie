Class {
	#name : #AthensAeCairoSurface,
	#superclass : #AthensSurface,
	#instVars : [
		'cairoSurface',
		'canvas',
		'pathBuilder'
	],
	#category : #'Alexandrie-Athens'
}

{ #category : #'instance creation' }
AthensAeCairoSurface class >> extent: aPoint [

	self flag: #athens. "Extra vertical line without explanation,
		based on: AthensCairoSurface class>>#extent:format:"

	^ self on: (AeCairoImageSurface extent: aPoint + (0@1))
]

{ #category : #'instance creation' }
AthensAeCairoSurface class >> on: aCairoSurface [

	^ self basicNew
		initializeOn: aCairoSurface;
		yourself
]

{ #category : #converting }
AthensAeCairoSurface >> asForm [

	^ cairoSurface asForm
]

{ #category : #public }
AthensAeCairoSurface >> attemptToRecurseDrawing [

	^ self flag: #athens. "Should signal a warning or error"
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

{ #category : #paints }
AthensAeCairoSurface >> createLinearGradient: aColorRamp start: aStartPoint stop: aStopPoint [

	^ AeCairoLinearGradientPattern
		from: aStartPoint
		to: aStopPoint
		addStopsFrom: aColorRamp
]

{ #category : #paths }
AthensAeCairoSurface >> createPath: aPathCreatingBlock [

	^ pathBuilder createPath: aPathCreatingBlock
]

{ #category : #paints }
AthensAeCairoSurface >> createRadialGradient: colorRamp center: aCenter radius: aRadius focalPoint: fp [

	^ AeCairoRadialGradientPattern
		innerCenter: fp
		innerRadius: 0.0
		outerCenter: aCenter
		outerRadius: aRadius
		addStopsFrom: colorRamp
]

{ #category : #paints }
AthensAeCairoSurface >> createStrokePaintFor: aPaint [

	^ AthensAeCairoStrokePaint new
		  fillPaint: aPaint;
		  yourself
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

{ #category : #accessing }
AthensAeCairoSurface >> flush [
	
	cairoSurface flush
]

{ #category : #initialization }
AthensAeCairoSurface >> initializeOn: aCairoSurface [

	self initialize.
	
	cairoSurface := aCairoSurface.
	canvas := self newCanvas.
	pathBuilder := AthensAeCairoPathBuilder on: canvas cairoContext
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
