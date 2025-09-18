Class {
	#name : #AeCairoContextTest,
	#superclass : #TestCase,
	#instVars : [
		'surface',
		'context'
	],
	#category : #'Alexandrie-Cairo-Tests'
}

{ #category : #'tests - text' }
AeCairoContextTest >> newSourceSansProRegularFontFace [

	| aFTLibrary aFTFace |
	aFTLibrary := AeFTLibrary newInitialized.
	aFTFace := AeSourceSansPro_Regular firstFaceUsing: aFTLibrary.
	^ AeCairoFreetypeFontFace newForFace: aFTFace
]

{ #category : #accessing }
AeCairoContextTest >> resources [

	^ { AeFTLibraryResource }
]

{ #category : #tests }
AeCairoContextTest >> testAntialias [

	surface := AeCairoImageSurface extent: 100 @ 100.
	context := surface newContext.
	
	self assert: context antialias equals: AeCairoAntialias default.

	context antialias: AeCairoAntialias gray.
	self assert: context antialias equals: AeCairoAntialias gray.

	context restoreStateAfter: [
		context antialias: AeCairoAntialias none.
		self assert: context antialias equals: AeCairoAntialias none ].

	"Assert antialias is restored"
	self assert: context antialias equals: AeCairoAntialias gray
]

{ #category : #tests }
AeCairoContextTest >> testClipExtents [

	surface := AeCairoImageSurface extent: 100 @ 100.
	context := surface newContext.
	
	self
		assert: context clipExtentsInUserSpace
		equals: (Rectangle origin: 0 @ 0 extent: 100 @ 100).
	self
		assert: context clipExtentsInDeviceSpace
		equals: (Rectangle origin: 0 @ 0 extent: 100 @ 100).
	
	context scaleByX: 0.5 y: 2.
	
	self
		assert: context clipExtentsInUserSpace
		equals: (Rectangle origin: 0 @ 0 corner: 200 @ 50).
	self
		assert: context clipExtentsInDeviceSpace
		equals: (Rectangle origin: 0 @ 0 corner: 100 @ 100).

	context
		moveTo: 5 @ 10;
		lineTo: 90 @ 50;
		clip.

	self
		assert: context clipExtentsInUserSpace
		equals: (Rectangle origin: 4 @ 10 corner: 90 @ 50).
	self
		assert: context clipExtentsInDeviceSpace
		equals: (Rectangle origin: 2 @ 20 corner: 45 @ 100).

	context resetClip.
	
	self
		assert: context clipExtentsInUserSpace
		equals: (Rectangle origin: 0 @ 0 extent: 200 @ 50).
	self
		assert: context clipExtentsInDeviceSpace
		equals: (Rectangle origin: 0 @ 0 corner: 100 @ 100).

]

{ #category : #tests }
AeCairoContextTest >> testCurrentPoint [

	surface := AeCairoImageSurface extent: 100 @ 100.
	context := surface newContext.
	
	self deny: context hasCurrentPoint.
	
	context
		translateBy: 3 @ 7;
		scaleByX: 0.5 y: 2.
		
	self deny: context hasCurrentPoint.

	context moveTo: 5 @ 11.
	
	self assert: context hasCurrentPoint.
	self
		assert: context currentPointInUserSpace
		equals: 5 @ 11.
	self
		assert: context currentPointInDeviceSpace
		equals: (3+(5*0.5)) @ (7+(11*2)).

	context stroke.

	self deny: context hasCurrentPoint.

]

{ #category : #tests }
AeCairoContextTest >> testCurrentTarget [

	surface := AeCairoImageSurface extent: 100 @ 100.
	context := surface newContext.
	
	self
		assert: context currentTarget getHandle
		equals: surface getHandle.

	context pushGroup.
	
	self
		deny: context currentTarget getHandle
		equals: surface getHandle.

]

{ #category : #'tests - text' }
AeCairoContextTest >> testDeviceScaleImpactsFontMatrix [

	| aSurface aContext aFontFace aScaledFont |
	aSurface := AeCairoImageSurface extent: 1@1.
	aSurface deviceScaleX: 2 y: 3.
	aContext := aSurface newContext.
	
	"Set up scaled font in the context"
	aFontFace := AeFTLibraryResource current sourceSansProRegularFTFace newCairoFontFace.
	aContext fontFace: aFontFace.
	aContext fontSize: 17.
	aScaledFont := aContext scaledFont.

	self
		assert: aScaledFont currentTransformationMatrix
		equals: (AeCairoMatrix newScalingByX: 2 y: 3)
]

{ #category : #tests }
AeCairoContextTest >> testFillPreservingPath [

	surface :=
		AeCairoImageSurface
			newWithFormat: AeCairoSurfaceFormat argb32
			width: 3
			height: 3.
	context := surface newContext.
	context rectangleX: 1 y: 1 width: 1 height: 1.

	context sourceColor: Color blue.
	context fillPreservingPath: true.
	self
		assert: context hasCurrentPoint
		description: 'Path is preserved after fill'.
	surface flush.
	"This pixel was included in the rectangle"
	self assert: (surface colorAtX: 1 y: 1) equals: Color blue.
	"These pixels were not, so they as untouched."
	self assert: (surface colorAtX: 0 y: 1) equals: Color transparent.
	self assert: (surface colorAtX: 2 y: 1) equals: Color transparent.


	context sourceColor: Color green.
	context fillPreservingPath: false.
	self
		deny: context hasCurrentPoint
		description: 'Path is not preserved after fill'.
	surface flush.
	"This pixel was included in the rectangle"
	self assert: (surface colorAtX: 1 y: 1) equals: Color green.
	"These pixels were not, so they as untouched."
	self assert: (surface colorAtX: 0 y: 1) equals: Color transparent.
	self assert: (surface colorAtX: 2 y: 1) equals: Color transparent
]

{ #category : #tests }
AeCairoContextTest >> testFillPreservingPathAlpha [

	surface :=
		AeCairoImageSurface
			newWithFormat: AeCairoSurfaceFormat argb32
			width: 3
			height: 3.
	context := surface newContext.
	context rectangleX: 1 y: 1 width: 1 height: 1.
	context sourceColor: (Color black alpha: 0.5).

	"Fill with alpha 0.5 using blue alpha 0.5, over a 0.0 in surface"
	context fillPreservingPath: true alpha: 0.5.
	self
		assert: context hasCurrentPoint
		description: 'Path is preserved after fill'.
	surface flush.
	"This pixel was included in the rectangle"
	self
		assert: (surface colorAtX: 1 y: 1) alpha
		closeTo: 0.25
		precision: 0.01.
	"These pixels were not, so they as untouched."
	self assert: (surface colorAtX: 0 y: 1) equals: Color transparent.
	self assert: (surface colorAtX: 2 y: 1) equals: Color transparent.


	"Fill with alpha 0.5 using blue alpha 0.5, over a 0.25 in surface"
	context fillPreservingPath: false alpha: 0.5.
	self
		deny: context hasCurrentPoint
		description: 'Path is not preserved after fill'.
	surface flush.
	"This pixel was included in the rectangle"
	self
		assert: (surface colorAtX: 1 y: 1) alpha
		closeTo: 0.43
		precision: 0.01.
	"These pixels were not, so they as untouched."
	self assert: (surface colorAtX: 0 y: 1) equals: Color transparent.
	self assert: (surface colorAtX: 2 y: 1) equals: Color transparent
]

{ #category : #tests }
AeCairoContextTest >> testFillPreservingPathAlphaOpaque [

	surface :=
		AeCairoImageSurface
			newWithFormat: AeCairoSurfaceFormat argb32
			width: 3
			height: 3.
	context := surface newContext.
	context rectangleX: 1 y: 1 width: 1 height: 1.

	"Fill with alpha 1 using blue alpha 1, over a 0.0 in surface"
	context sourceColor: Color blue.
	context fillPreservingPath: true alpha: 1.
	self
		assert: context hasCurrentPoint
		description: 'Path is preserved after fill'.
	surface flush.
	"This pixel was included in the rectangle"
	self
		assert: (surface colorAtX: 1 y: 1)
		equals: Color blue.
	"These pixels were not, so they as untouched."
	self assert: (surface colorAtX: 0 y: 1) equals: Color transparent.
	self assert: (surface colorAtX: 2 y: 1) equals: Color transparent.


	"Fill with alpha 0.5 using green alpha 1.0, over a 1.0 in surface"
	context sourceColor: Color green.
	context fillPreservingPath: false alpha: 0.5.
	self
		deny: context hasCurrentPoint
		description: 'Path is not preserved after fill'.
	surface flush.
	"This pixel was included in the rectangle"
	self
		assert: (surface colorAtX: 1 y: 1) blue
		closeTo: 0.5
		precision: 0.01.
	self
		assert: (surface colorAtX: 1 y: 1) green
		closeTo: 0.5
		precision: 0.01.
	self
		assert: (surface colorAtX: 1 y: 1) alpha
		closeTo: 1.0.
	"These pixels were not, so they as untouched."
	self assert: (surface colorAtX: 0 y: 1) equals: Color transparent.
	self assert: (surface colorAtX: 2 y: 1) equals: Color transparent
]

{ #category : #tests }
AeCairoContextTest >> testFillRule [

	surface := AeCairoImageSurface extent: 100 @ 100.
	context := surface newContext.

	"Default value"	
	self
		assert: context fillRule
		equals: AeCairoFillRule winding.

	"Change value"
	context fillRule: AeCairoFillRule evenOdd.
	self
		assert: context fillRule
		equals: AeCairoFillRule evenOdd.

	"Assert fillRule is restored"
	context restoreStateAfter: [
		context fillRule: AeCairoFillRule winding.
		self
			assert: context fillRule
			equals: AeCairoFillRule winding ].
	self
		assert: context fillRule
		equals: AeCairoFillRule evenOdd
]

{ #category : #'tests - text' }
AeCairoContextTest >> testFontExtents [

	| aSurface aContext aFontFace aScaledFont aFontExtents |
	aSurface := AeCairoImageSurface extent: 1@1.
	aContext := aSurface newContext.
	
	"Set up scaled font in the context"
	aFontFace := AeFTLibraryResource current sourceSansProRegularFTFace newCairoFontFace.
	aContext
		fontFace: aFontFace;
		fontSize: 17.

	"Measure glyphs extents"
	aFontExtents := aContext fontExtents.
	self assert: aFontExtents height closeTo: 21.
	self assert: aFontExtents ascent closeTo: 17.
	self assert: aFontExtents descent closeTo: 5.
	self assert: aFontExtents maxAdvance closeTo: 37@0.

	"Changing fontSize implies a new scaledFont is set"
	aContext fontSize: 71.
	aScaledFont := aContext scaledFont.
	aFontExtents := aContext fontExtents.
	self assert: aFontExtents height closeTo: 89.
	self assert: aFontExtents ascent closeTo: 70.
	self assert: aFontExtents descent closeTo: 20.
	self assert: aFontExtents maxAdvance closeTo: 156@0.

	"Switch back to fontSize=17 but via setting the matrix"	
	aContext fontMatrix: (AeCairoMatrix newScalingBy: 17 asPoint).
	aScaledFont := aContext scaledFont.
	aFontExtents := aContext fontExtents.
	self assert: aFontExtents height closeTo: 21.
	self assert: aFontExtents ascent closeTo: 17.
	self assert: aFontExtents descent closeTo: 5.
	self assert: aFontExtents maxAdvance closeTo: 37@0.

]

{ #category : #'tests - text' }
AeCairoContextTest >> testGlyphExtentsOf [

	| aSurface aContext string aScaledFont aGlyphArray aTextExtents aFontFace |
	aSurface := AeCairoImageSurface extent: 1@1.
	aContext := aSurface newContext.
	string := 'Hola'.
	
	"Set up scaled font in the context"
	aFontFace := AeFTLibraryResource current sourceSansProRegularFTFace newCairoFontFace.
	aContext
		fontFace: aFontFace;
		fontSize: 17.
	aScaledFont := aContext scaledFont.
	aGlyphArray := aScaledFont glyphArrayForString: string.
	aTextExtents := aContext glyphExtentsOf: aGlyphArray.
	self assert: aTextExtents extent closeTo: 33@13.
	self assert: aTextExtents bearing closeTo: 1@ -13.
	self assert: aTextExtents advance closeTo: 34@0.

	"Change and fetch different measurements"
	aContext fontSize: 71.
	aScaledFont := aContext scaledFont.
	aGlyphArray := aScaledFont glyphArrayForString: string.
	aTextExtents := aContext glyphExtentsOf: aGlyphArray.
	self assert: aTextExtents extent closeTo: 129@51.
	self assert: aTextExtents bearing closeTo: 6@ -50.
	self assert: aTextExtents advance closeTo: 139@0.

	"Switch back to fontSize=17, but this time via #fontMatrix:"
	aContext fontMatrix: (AeCairoMatrix newScalingBy: 17 asPoint).
	aScaledFont := aContext scaledFont.
	aGlyphArray := aScaledFont glyphArrayForString: string.
	aTextExtents := aContext glyphExtentsOf: aGlyphArray.
	self assert: aTextExtents extent closeTo: 33@13.
	self assert: aTextExtents bearing closeTo: 1@ -13.
	self assert: aTextExtents advance closeTo: 34@0
]

{ #category : #tests }
AeCairoContextTest >> testOperator [

	surface := AeCairoImageSurface extent: 100 @ 100.
	context := surface newContext.
	
	self
		assert: context operator
		equals: AeCairoOperator over.

	context setOperatorClear.

	self
		assert: context operator
		equals: AeCairoOperator clear.

	"Assert operator is restored"
	context restoreStateAfter: [
		context operator: AeCairoOperator screen.
		self
			assert: context operator
			equals: AeCairoOperator screen ].
	self
		assert: context operator
		equals: AeCairoOperator clear
]

{ #category : #tests }
AeCairoContextTest >> testPathExtents [

	surface := AeCairoImageSurface extent: 100 @ 100.
	context := surface newContext.
	
	self
		assert: context pathExtentsInUserSpace
		equals: (Rectangle origin: 0 asPoint extent: 0 asPoint).
	self
		assert: context pathExtentsInDeviceSpace
		equals: (Rectangle origin: 0 asPoint extent: 0 asPoint).
	
	context
		translateBy: -1 @ -2;
		scaleByX: 0.5 y: 2;
		moveTo: 5 @ 10;
		lineTo: 90 @ 50;
		fillPreservingPath.

	self
		assert: context pathExtentsInUserSpace
		equals: (Rectangle origin: 5.0 @ 10.0 corner: 90.0 @ 50.0).
	self
		assert: context pathExtentsInDeviceSpace
		equals: (Rectangle origin: 1.5 @ 18.0 corner: 44.0 @ 98.0).

	context fill.
	
	self
		assert: context pathExtentsInUserSpace
		equals: (Rectangle origin: 0 asPoint extent: 0 asPoint).
	self
		assert: context pathExtentsInDeviceSpace
		equals: (Rectangle origin: -1 @ -2 extent: 0 asPoint).

]

{ #category : #tests }
AeCairoContextTest >> testRotateByRadiansCenter [

	| radians matrix |
	surface := AeCairoImageSurface extent: 1 @ 1.
	context := surface newContext.

	radians := 180 degreesToRadians.
	context rotateByRadians: radians center: 20 @ 10.

	matrix := context matrix.
	
	self assert: matrix x   equals: 40.0.
	self assert: matrix y   equals: 20.0.
	self assert: matrix sx  equals: radians cos.
	self assert: matrix sy  equals: radians cos.
	self assert: matrix shx equals: radians sin negated.
	self assert: matrix shy equals: radians sin
]

{ #category : #'tests - text' }
AeCairoContextTest >> testScaledFont [

	| aSurface aContext aFontFace scaledFont17 scaledFont71 scaledFont17b |
	aSurface := AeCairoImageSurface extent: 1@1.
	aContext := aSurface newContext.
	
	"Set up scaled font in the context"
	aFontFace := self newSourceSansProRegularFontFace.
	aContext
		fontFace: aFontFace;
		fontSize: 17.
	scaledFont17 := aContext scaledFont.

	"Second time we get the same address (it's not a copy)."
	self
		assert: aContext scaledFont getHandle
		equals: scaledFont17 getHandle.

	"Changing fontSize implies a new scaledFont is set"
	aContext fontSize: 71.
	self
		deny: aContext scaledFont getHandle
		equals: scaledFont17 getHandle.
	scaledFont71 := aContext scaledFont.

	"Caching, when switching back to fontSize=17 via #fontMatrix:"
	aContext fontMatrix: (AeCairoMatrix newScalingBy: 17 asPoint).
	self
		deny: aContext scaledFont getHandle
		equals: scaledFont71 getHandle.
	scaledFont17b := aContext scaledFont.
	self
		assert: scaledFont17b getHandle
		equals: scaledFont17 getHandle.

	"Caching, also when switching back to fontSize=71 via #fontSize:"
	aContext fontSize: 71.
	self
		assert: aContext scaledFont getHandle
		equals: scaledFont71 getHandle.
	
	"There isn't cache when same cairo font face but in new instance."
	aContext fontFace: self newSourceSansProRegularFontFace.
	self
		deny: aContext scaledFont getHandle
		equals: scaledFont71 getHandle.

	"Getting back to original cairo font face instance, gets
	cached scaled font face."
	aContext fontFace: aFontFace.
	self
		assert: aContext scaledFont getHandle
		equals: scaledFont71 getHandle
]

{ #category : #tests }
AeCairoContextTest >> testStrokeDashPattern [

	surface := AeCairoImageSurface extent: 1@1.
	context := surface newContext.
	
	"By default it is empty. As an optimization, the answer is an Array."
	self deny: context hasStrokeDashPattern.
	self assert: context strokeDashPatternSize equals: 0.
	self assert: context strokeDashPattern class equals: Array.
	self assert: context strokeDashPattern isEmpty.
	
	"Set an Array. The bindings retrieve the pattern as an instance of AeFFIDoubleArray"
	context strokeDashPattern: #(1 2 3).
	self assert: context hasStrokeDashPattern.
	self assert: context strokeDashPatternSize equals: 3.
	self assert: context strokeDashPattern class equals: AeFFIDoubleArray.
	self deny: context strokeDashPattern isEmpty.
	self
		assert: context strokeDashPattern
		equals: (AeFFIDoubleArray newFrom: #(1 2 3)).

	"Setting an AeFFIDoubleArray is more direct. You can use it to avoid the creation of
	a temporary AeFFIDoubleArray and doing the conversion many times."
	context strokeDashPattern: (AeFFIDoubleArray newFrom: #(4 5)).
	self
		assert: context strokeDashPattern
		equals: (AeFFIDoubleArray newFrom: #(4 5))
]

{ #category : #tests }
AeCairoContextTest >> testStrokeExtents [

	surface := AeCairoImageSurface extent: 100 @ 100.
	context := surface newContext.
	
	self
		assert: context strokeExtentsInUserSpace
		equals: (Rectangle origin: 0 asPoint extent: 0 asPoint).
	self
		assert: context strokeExtentsInDeviceSpace
		equals: (Rectangle origin: 0 asPoint extent: 0 asPoint).
	
	context
		translateByX: -1 y: -2;
		scaleByX: 0.5 y: 2;
		moveToX: 5 y: 10;
		lineToX: 90 y: 50;
		strokeSize: 10;
		strokePreservingPath.

	self
		assert: context strokeExtentsInUserSpace 
		equals: ((2.8671875@5.4765625) corner: (92.1328125@54.5234375)).
	self
		assert: context strokeExtentsInDeviceSpace
		equals: ((0.43359375@8.953125) corner: (45.06640625@107.046875)).

	context stroke.
	
	self
		assert: context strokeExtentsInUserSpace
		equals: (Rectangle origin: 0 asPoint extent: 0 asPoint).
	self
		assert: context strokeExtentsInDeviceSpace
		equals: (Rectangle origin: -1 @ -2 extent: 0 asPoint).

]

{ #category : #tests }
AeCairoContextTest >> testStrokeSize [

	surface := AeCairoImageSurface extent: 1@1.
	context := surface newContext.
	
	"Assert on default value"
	self assert: context strokeSize equals: 2.0. 
	
	context strokeSize: 7.
	
	"Assert on new value"
	self assert: context strokeSize equals: 7.0
]

{ #category : #tests }
AeCairoContextTest >> testTolerance [

	surface := AeCairoImageSurface extent: 100 @ 100.
	context := surface newContext.
	
	self assert: context tolerance closeTo: 0.1.

	context tolerance: 0.5.
	self assert: context tolerance closeTo: 0.5.

	context restoreStateAfter: [
		context tolerance: 0.7.
		self assert: context tolerance closeTo: 0.7 ].

	"Assert tolerance is restored"
	self assert: context tolerance closeTo: 0.5.

]
