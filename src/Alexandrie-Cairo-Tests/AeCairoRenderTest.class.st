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
	
	aContext restoreStateAfter: [

		aContext sourceSurface: checkSurface x: 0 y: 0.
		
		aContext source
			filter: AeCairoSamplingFilter CAIRO_FILTER_NEAREST;
			extend: AeCairoExtendMode CAIRO_EXTEND_REPEAT.
		aContext paint
		
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
		extent: aPoint
		format: AeCairoSurfaceFormat CAIRO_FORMAT_RGB24.
	
	aContext := aSurface newContext.
	
	"light gray"
	aContext
		sourceColorR: 0.75 g: 0.75 b: 0.75;
		paint.
		
	"dark gray"
	aContext
		sourceColorR: 0.25 g: 0.25 b: 0.25;
		rectangleX: aPoint x / 2
			y: 0
			width: aPoint x / 2
			height: aPoint y / 2;
		rectangleX: 0
			y: aPoint y / 2
			width: aPoint x / 2
			height: aPoint y / 2;
		fill.

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
		sourceColorRGB: Color blue;
		fillPreserve;
		sourceColorRGB: Color red;
		stroke.

	aContext translateByX: size + (2 * pad) y: 0.

	aContext
		circleCenterX: pad + (size/2)
			y: pad + (size/2)
			radius: size/2;
		fillPreserve;
		sourceColorRGB: Color blue;
		stroke.

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
						source: fillPattern;
						fillPreserve;
						source: strokePattern;
						stroke ]
				alpha: 0.5 ].



	blue := AeCairoColorPattern newFrom: Color blue.
	red := AeCairoColorPattern newFrom: Color red.

	self drawTestPaintCheckeredOn: aContext.
	
	fillAndStrokeAlphaBlock
		value: [
			aContext rectangle: (pad asPoint extent: size asPoint) ]
		value: blue
		value: red.

	aContext translateByX: size + (2*pad) y: 0.

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
						source: fillPattern;
						fillPreserve.

					"Use DEST_OUT to subtract stroke from fill."
					aContext
						sourceColorRGB: Color black;
						operator: AeCairoCompositionOp CAIRO_OPERATOR_DEST_OUT;
						strokePreserve.
					
					"Then use ADD to draw the stroke without a seam."
					aContext
						source: strokePattern;
						operator: AeCairoCompositionOp CAIRO_OPERATOR_ADD;
						stroke ] ].



	blue := AeCairoColorPattern newFrom: (Color blue alpha: 0.8).
	red := AeCairoColorPattern newFrom: (Color red alpha: 0.2).

	self drawTestPaintCheckeredOn: aContext.
	
	fillAndStrokeBlock
		value: [
			aContext rectangle: (pad asPoint extent: size asPoint) ]
		value: blue
		value: red.

	aContext translateByX: size + (2*pad) y: 0.

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
AeCairoRenderTest >> surfaceWithFillDisjoint [
	"Tests filling unsorted rectangles.
	
	The goal is exercise a bug that existed in the xlib backend, where
	it assumed the rectangles generated by rectangular tessallator had
	any sorting guarantees.

	Based on: fill-disjoint.c"

	| surfaceSize aSurface aContext |
	surfaceSize := 300 asPoint.
	aSurface := self newSurfaceExtent: surfaceSize.
	aContext := aSurface newContext.

	"black background"
	aContext
		sourceColorRGB: Color black;
		paint.

	"white rectangles"
	aContext sourceColorRGB: Color white.

	"fill with a set of rectangles that the rectangular tessellator
	will not emit sorted."
	0 to: surfaceSize x - 10 by: 15 do: [ :each |
		aContext
			rectangleX: each
				y: each
				width: 10
				height: (surfaceSize y - (2*each));
			fill ].

	^ aSurface
]

{ #category : #tests }
AeCairoRenderTest >> surfaceWithFillEmpty [
	"Test filling with an empty path.
	
	Based on: fill-empty.c"

	| surfaceSize aSurface aContext size |
	size := 10.
	surfaceSize := size asPoint.
	aSurface := self newSurfaceExtent: surfaceSize.
	aContext := aSurface newContext.

	aContext
		sourceColorRGB: Color blue;
		paint.

	aContext sourceColorRGB: Color red.
	
	"first drawn an ordinary empty path"
	aContext restoreStateAfter: [
		aContext
			rectangle: (0 asPoint extent: size @ (size/2));
			clip;
			fill ].

	"and then an unbounded empty path"
	aContext restoreStateAfter: [ 
		aContext
			rectangle: (0 @ (size / 2) extent: size @ (size/2));
			clip;
			operator: AeCairoCompositionOp CAIRO_OPERATOR_DEST_IN;
			fill ].
	
	^ aSurface
]

{ #category : #tests }
AeCairoRenderTest >> surfaceWithFillMissedStop [
	"Tests that the tessellator doesn't miss stop events when generating trapezoids.
	
    /* What it should look like, with # marking the filled areas:
     *
     * |\    |\
     * |#\   |#\
     * |##\__|##\
     *     \#|
     *      \|
     *
     * What it looke like with the bug, when the rightmost edge's end
     * is missed:
     *
     * |\    |\
     * |#\   |#\
     * |##\__|##\
     *     \#####|
     *      \####|
     */

	Based on: fill-missed-stop.c"

	| surfaceSize aSurface aContext size |
	size := 50.
	surfaceSize := (size + 3) asPoint.
	aSurface := self newSurfaceExtent: surfaceSize.
	aContext := aSurface newContext.

	aContext
		sourceColorRGB: Color red;
		translateByX: 1 y: 1.

	aContext
		moveToX: 0 y: 0;
		lineToX: size/2 y: size;
		lineToX: size/2 y: 0;
		lineToX: size y: size/2;
		lineToX: 0 y: size/2;
		closePath;
		fill.

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
		source: aGradient;
		paint.
	
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
		source: aGradient;
		paint.
	
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
		source: aLinearGradient;
		paint.

	aRadialGradient := AeCairoRadialGradientPattern 
		innerCenter: 0@0
		innerRadius: 0
		outerCenter: 1@1
		outerRadius: 1.
	aContext
		source: aRadialGradient;
		paint.

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

	aContext sourceColorRGB: Color red.

	aLinearGradient := AeCairoLinearGradientPattern
		from: 0 @ 0
		to: 1 @ 1.
	aContext mask: aLinearGradient.

	aRadialGradient := AeCairoRadialGradientPattern 
		innerCenter: 0@0
		innerRadius: 0
		outerCenter: 1@1
		outerRadius: 1.
	aContext mask: aRadialGradient.

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
		sourceColorRGB: Color white;
		paint.

	aContext
		rectangle: (25@25 extent: surfaceSize);
		clipPreserve;
		pushGroup;
		sourceColorRGB: Color blue;
		fill;
		rectangle: (0@0 extent: surfaceSize);
		popGroupToSource;
		paint.

	aContext
		resetClip;
		clipPreserve;
		sourceColorRGBA: (Color red alpha: 0.5);
		paint.

	^ aSurface
]

{ #category : #tests }
AeCairoRenderTest >> surfaceWithGroupPaint [
	"Based on: group-paint.c"

	| surfaceSize aSurface aContext |
	surfaceSize := 10 @ 10.
	aSurface := self newSurfaceExtent: surfaceSize.
	aContext := aSurface newContext.

	aContext pushGroup.

	aContext
		sourceColorRGB: Color blue;
		paint.

	aContext
		popGroupToSource;
		setOperatorSource;
		paint.

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
		sourceColorRGB: Color white;
		paint.

	aContext
		sourceColorRGB: Color red;
		circleCenterX: 12.5 y: 12.5 radius: 10.0;
		fill.

	aContext
		pushGroup;
		sourceColorRGB: Color blue;
		circleCenterX: 12.5 y: 12.5 radius: 10.0;
		fill;
		popGroupToSource;
		paint.
		
	^ aSurface
]