Class {
	#name : #AeCairoRenderTest,
	#superclass : #AePixelMatchTest,
	#category : #'Alexandrie-Cairo-Tests'
}

{ #category : #hooks }
AeCairoRenderTest >> actualFormFor: aSymbol [

	^ (self perform: aSymbol) asForm
]

{ #category : #hooks }
AeCairoRenderTest >> allFormSelectors [

	^ self class selectors select: [ :each | each beginsWith: 'surfaceWith' ]
]

{ #category : #convenience }
AeCairoRenderTest >> deleteAllExports [
	<script: 'self new deleteAllExports' >

	super deleteAllExports
]

{ #category : #private }
AeCairoRenderTest >> drawTestPaintCheckeredOn: aContext [
	"Based on the cairo_test_paint_checkered function, defined in cairo-test.c"

	| checkSurface |
	checkSurface := self newCheckSurfaceExtent: 12 @ 12.
	
	aContext restoreAfter: [

		aContext primSetSourceSurface: checkSurface x: 0 y: 0.
		
		aContext primGetSource
			primSetFilter: AeCairoSamplingFilter CAIRO_FILTER_NEAREST;
			primSetExtend: AeCairoExtendMode CAIRO_EXTEND_REPEAT.
		aContext primPaint
		
		]
]

{ #category : #hooks }
AeCairoRenderTest >> expectedFormsDirectory [

	^ AeFilesystemResources cairoDirectory
]

{ #category : #convenience }
AeCairoRenderTest >> exportAll [
	<script: 'self new exportAll' >

	super exportAll
]

{ #category : #private }
AeCairoRenderTest >> newCheckSurfaceExtent: aPoint [
	"Based on the _draw_check function, defined in cairo-test.c"
	
	| aSurface aContext |
	aSurface := AeCairoImageSurface
		createExtent: aPoint
		format: AeCairoSurfaceFormat CAIRO_FORMAT_RGB24.
	
	aContext := aSurface newContext.
	
	"light gray"
	aContext
		primSetSourceR: 0.75 g: 0.75 b: 0.75;
		primPaint.
		
	"dark gray"
	aContext
		primSetSourceR: 0.25 g: 0.25 b: 0.25;
		primRectangleX: aPoint x / 2
			y: 0
			width: aPoint x / 2
			height: aPoint y / 2;
		primRectangleX: 0
			y: aPoint y / 2
			width: aPoint x / 2
			height: aPoint y / 2;
		primFill.

	^ aSurface
]

{ #category : #private }
AeCairoRenderTest >> newSurfaceExtent: aPoint [

	^ AeCairoImageSurface extent: aPoint
]

{ #category : #tests }
AeCairoRenderTest >> surfaceWithFillAndStroke [
	"Tests using cairo_fill_preserve/cairo_stroke to fill/stroke the same path.
	
	Based on: fill-and-stroke.c"

	| surfaceSize aSurface aContext size pad |
	pad := 2.
	size := 10.
	surfaceSize := ((2 * size) + (4 * pad)) @ (size + (2 * pad)).
	
	aSurface := self newSurfaceExtent: surfaceSize.
	aContext := aSurface newContext.

	aContext
		rectangle: (pad asPoint extent: size asPoint);
		setSourceRGBColor: Color blue;
		primFillPreserve;
		setSourceRGBColor: Color red;
		primStroke.

	aContext primTranslateX: size + (2 * pad) y: 0.

	aContext
		circleCenterX: pad + (size/2)
			y: pad + (size/2)
			radius: size/2;
		primFillPreserve;
		setSourceRGBColor: Color blue;
		primStroke.

	^ aSurface
]

{ #category : #tests }
AeCairoRenderTest >> surfaceWithFillAndStrokeAlpha [
	"Use a group to fill/stroke a path then blend the result with alpha onto the destination.
	
	Based on: fill-and-stroke-alpha.c"

	| surfaceSize aSurface aContext size pad blue red fillAndStrokeAlphaBlock |
	pad := 2.
	size := 10.
	surfaceSize := ((2 * size) + (4 * pad)) @ (size + (2 * pad)).
	aSurface := self newSurfaceExtent: surfaceSize.
	aContext := aSurface newContext.

	"Given a path-generating function and two opaque patterns, fill and
	stroke the path with the patterns (to an offscreen group), then
	blend the result into the destination with the given alpha value."
	fillAndStrokeAlphaBlock :=
		[ :pathBlock :fillPattern :strokePattern |
			aContext
				paintGroupWith: [
					pathBlock value.
					aContext
						primSetSource: fillPattern;
						primFillPreserve;
						primSetSource: strokePattern;
						primStroke ]
				alpha: 0.5 ].



	blue := AeCairoColorPattern newFrom: Color blue.
	red := AeCairoColorPattern newFrom: Color red.

	self drawTestPaintCheckeredOn: aContext.
	
	fillAndStrokeAlphaBlock
		value: [
			aContext rectangle: (pad asPoint extent: size asPoint) ]
		value: blue
		value: red.

	aContext primTranslateX: size + (2*pad) y: 0.

	fillAndStrokeAlphaBlock
		value: [
			aContext
				circleCenterX: pad + (size/2)
					y: pad + (size/2)
					radius: size / 2 ]
		value: red
		value: blue.

	^ aSurface
]

{ #category : #tests }
AeCairoRenderTest >> surfaceWithFillAndStrokeAlphaAdd [
	"Use a group to fill/stroke a path (each with different alpha) using DEST_OUT and ADD to combine.
	
	Based on: fill-and-stroke-alpha-add.c"

	| surfaceSize aSurface aContext size pad blue red fillAndStrokeBlock |
	pad := 2.
	size := 10.
	surfaceSize := ((2 * size) + (4 * pad)) @ (size + (2 * pad)).
	aSurface := self newSurfaceExtent: surfaceSize.
	aContext := aSurface newContext.
	
	"Helper:
	Given a path-generating function and two opaque patterns, fill and
	stroke the path with the patterns (to an offscreen group), then
	blend the result into the destination with the given alpha value."
	fillAndStrokeBlock :=
		[ :pathBlock :fillPattern :strokePattern |
			aContext
				paintGroupWith: [
					pathBlock value.
					aContext
						primSetSource: fillPattern;
						primFillPreserve.

					"Use DEST_OUT to subtract stroke from fill."
					aContext
						setSourceRGBColor: Color black;
						primSetOperator: AeCairoCompositionOp CAIRO_OPERATOR_DEST_OUT;
						primStrokePreserve.
					
					"Then use ADD to draw the stroke without a seam."
					aContext
						primSetSource: strokePattern;
						primSetOperator: AeCairoCompositionOp CAIRO_OPERATOR_ADD;
						primStroke ] ].



	blue := AeCairoColorPattern newFrom: (Color blue alpha: 0.8).
	red := AeCairoColorPattern newFrom: (Color red alpha: 0.2).

	self drawTestPaintCheckeredOn: aContext.
	
	fillAndStrokeBlock
		value: [
			aContext rectangle: (pad asPoint extent: size asPoint) ]
		value: blue
		value: red.

	aContext primTranslateX: size + (2*pad) y: 0.

	fillAndStrokeBlock
		value: [
			aContext
				circleCenterX: pad + (size/2)
					y: pad + (size/2)
					radius: size / 2 ]
		value: red
		value: blue.

	^ aSurface
]

{ #category : #tests }
AeCairoRenderTest >> surfaceWithGradientAlpha [
	"Tests drawing of a gradient with various alpha values in the color stops.
	
	Based on: gradient-alpha.c"

	| surfaceSize aSurface aContext aGradient |
	surfaceSize := 10 @ 10.
	aSurface := self newSurfaceExtent: surfaceSize.
	aContext := aSurface newContext.

	aGradient := AeCairoLinearGradientPattern
		from: 0 @ surfaceSize y negated
		to: 0 @ surfaceSize y.
	aGradient addStopAt: 0.0 color: Color red.
	aGradient addStopAt: 1.0 color: (Color blue alpha: 0.5).
	
	aContext
		primSetSource: aGradient;
		primPaint.
	
	^ aSurface
]

{ #category : #tests }
AeCairoRenderTest >> surfaceWithGradientConstantAlpha [
	"Tests drawing of a gradient with constant alpha values in the color stops.
	
	Based on: gradient-constant-alpha.c"

	| surfaceSize aSurface aContext aGradient |
	surfaceSize := 10 @ 10.
	aSurface := self newSurfaceExtent: surfaceSize.
	aContext := aSurface newContext.

	aGradient := AeCairoLinearGradientPattern
		from: 0 @ 0
		to: 0 @ surfaceSize y.
	aGradient addStopAt: 0.0 color: (Color red alpha: 0.5).
	aGradient addStopAt: 0.0 color: (Color green alpha: 0.5).
	aGradient addStopAt: 1.0 color: (Color blue alpha: 0.5).
	
	aContext
		primSetSource: aGradient;
		primPaint.
	
	^ aSurface
]

{ #category : #tests }
AeCairoRenderTest >> surfaceWithGradientZeroStops [
	"Verifies that gradients with no stops don't cause problems.
	
	Based on: gradient-zero-stops.c"

	| surfaceSize aSurface aContext aLinearGradient aRadialGradient |
	surfaceSize := 2 @ 2.
	aSurface := self newSurfaceExtent: surfaceSize.
	aContext := aSurface newContext.

	aLinearGradient := AeCairoLinearGradientPattern
		from: 0 @ 0
		to: 1 @ 1.
	aContext
		primSetSource: aLinearGradient;
		primPaint.

	aRadialGradient := AeCairoRadialGradientPattern 
		innerCenter: 0@0
		innerRadius: 0
		outerCenter: 1@1
		outerRadius: 1.
	aContext
		primSetSource: aRadialGradient;
		primPaint.

	^ aSurface
]

{ #category : #tests }
AeCairoRenderTest >> surfaceWithGradientZeroStopsMask [
	"Verifies that gradients with no stops are considered clear.
	
	Based on: gradient-zero-stops-mask.c"

	| surfaceSize aSurface aContext aLinearGradient aRadialGradient |
	surfaceSize := 2 @ 2.
	aSurface := self newSurfaceExtent: surfaceSize.
	aContext := aSurface newContext.

	aContext setSourceRGBColor: Color red.

	aLinearGradient := AeCairoLinearGradientPattern
		from: 0 @ 0
		to: 1 @ 1.
	aContext primMask: aLinearGradient.

	aRadialGradient := AeCairoRadialGradientPattern 
		innerCenter: 0@0
		innerRadius: 0
		outerCenter: 1@1
		outerRadius: 1.
	aContext primMask: aRadialGradient.

	^ aSurface
]

{ #category : #tests }
AeCairoRenderTest >> surfaceWithGroupClip [
	"Test preserving paths across groups.
	
	Based on: group-clip.c"

	| surfaceSize aSurface aContext |
	surfaceSize := (40 + 25) @ (40 + 25).
	aSurface := self newSurfaceExtent: surfaceSize.
	aContext := aSurface newContext.

	aContext
		setSourceRGBColor: Color white;
		primPaint.

	aContext
		rectangle: (25@25 extent: surfaceSize);
		primClipPreserve;
		primPushGroup;
		setSourceRGBColor: Color blue;
		primFill;
		rectangle: (0@0 extent: surfaceSize);
		primPopGroupToSource;
		primPaint.

	aContext
		primResetClip;
		primClipPreserve;
		setSourceRGBAColor: (Color red alpha: 0.5);
		primPaint.

	^ aSurface
]

{ #category : #tests }
AeCairoRenderTest >> surfaceWithGroupPaint [
	"Based on: group-paint.c"

	| surfaceSize aSurface aContext |
	surfaceSize := 10 @ 10.
	aSurface := self newSurfaceExtent: surfaceSize.
	aContext := aSurface newContext.

	aContext primPushGroup.

	aContext
		setSourceRGBColor: Color blue;
		primPaint.

	aContext
		primPopGroupToSource;
		setOperatorSource;
		primPaint.

	^ aSurface
]

{ #category : #tests }
AeCairoRenderTest >> surfaceWithGroupUnaligned [
	"Based on: group-unaligned.c"

	| surfaceSize aSurface aContext |
	surfaceSize := 35.5 @ 35.5.
	aSurface := self newSurfaceExtent: surfaceSize.
	aContext := aSurface newContext.

	aContext
		setSourceRGBColor: Color white;
		primPaint.

	aContext
		setSourceRGBColor: Color red;
		circleCenterX: 12.5 y: 12.5 radius: 10.0;
		primFill.

	aContext
		primPushGroup;
		setSourceRGBColor: Color blue;
		circleCenterX: 12.5 y: 12.5 radius: 10.0;
		primFill;
		primPopGroupToSource;
		primPaint.
		
	^ aSurface
]
