Class {
	#name : #AeCairoContextTest,
	#superclass : #TestCase,
	#instVars : [
		'surface',
		'context'
	],
	#category : #'Alexandrie-Cairo-Tests'
}

{ #category : #running }
AeCairoContextTest >> newSourceSansProRegularFontFace [

	| aFTLibrary aFTFace |
	aFTLibrary := AeFTLibrary newInitialized.
	aFTFace := AeSourceSansPro_Regular firstFaceUsing: aFTLibrary.
	^ AeCairoFreetypeFontFace newForFace: aFTFace
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

{ #category : #tests }
AeCairoContextTest >> testFillRule [

	surface := AeCairoImageSurface extent: 100 @ 100.
	context := surface newContext.
	
	self
		assert: context fillRule
		equals: AeCairoFillRule winding.

	context fillRule: AeCairoFillRule evenOdd.

	self
		assert: context fillRule
		equals: AeCairoFillRule evenOdd.

]

{ #category : #tests }
AeCairoContextTest >> testFontExtents [

	| aSurface aContext aScaledFont aFontExtents |
	aSurface := AeCairoImageSurface extent: 1@1.
	aContext := aSurface newContext.
	
	"Set up scaled font in the context"
	aContext
		fontFace: self newSourceSansProRegularFontFace;
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

{ #category : #tests }
AeCairoContextTest >> testGlyphExtentsOf [

	| aSurface aContext string aScaledFont aGlyphArray aTextExtents |
	aSurface := AeCairoImageSurface extent: 1@1.
	aContext := aSurface newContext.
	string := 'Hola'.
	
	"Set up scaled font in the context"
	aContext
		fontFace: self newSourceSansProRegularFontFace;
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
		fillPreserve.

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
AeCairoContextTest >> testScaledFont [

	| aSurface aContext aCairoFontFace scaledFont17 scaledFont71 scaledFont17b |
	aSurface := AeCairoImageSurface extent: 1@1.
	aContext := aSurface newContext.
	
	"Set up scaled font in the context"
	aCairoFontFace := self newSourceSansProRegularFontFace.
	aContext
		fontFace: aCairoFontFace;
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
	aContext fontFace: aCairoFontFace.
	self
		assert: aContext scaledFont getHandle
		equals: scaledFont71 getHandle
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
		translateBy: -1 @ -2;
		scaleByX: 0.5 y: 2;
		moveTo: 5 @ 10;
		lineTo: 90 @ 50;
		lineWidth: 10;
		strokePreserve.

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
