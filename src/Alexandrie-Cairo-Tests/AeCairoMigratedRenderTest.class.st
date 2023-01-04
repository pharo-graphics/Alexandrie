"
My tests are migrated from Cairo C code.

Most tests are regression tests located in ""test/"" directory of Cairo C repository. 
For example, `#surfaceWithFillEmpty` was migrated from ""test/fill-empty.c"".
Reference Cairo version: v1.17.4. Not all tests were migrated, there are many!

The `#testWithOutsideClipping` is based on an example in the official website (2022). 

Each test has a link on its comment, to trace the original source.

"
Class {
	#name : #AeCairoMigratedRenderTest,
	#superclass : #AeCairoRenderTest,
	#category : #'Alexandrie-Cairo-Tests'
}

{ #category : #convenience }
AeCairoMigratedRenderTest class >> exportAll [
	<script: 'self exportAll' >

	super exportAll
]

{ #category : #convenience }
AeCairoMigratedRenderTest class >> inspectAll [
	<script: 'self inspectAll' >

	super inspectAll
]

{ #category : #convenience }
AeCairoMigratedRenderTest class >> inspectMismatches [
	<script: 'self inspectMismatches' >

	super inspectMismatches
]

{ #category : #private }
AeCairoMigratedRenderTest >> drawTestPaintCheckeredOn: aContext [
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

{ #category : #private }
AeCairoMigratedRenderTest >> newCheckSurfaceExtent: aPoint [
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
AeCairoMigratedRenderTest >> newSurfaceExtent: aPoint [

	^ AeCairoImageSurface
		  extent: aPoint
		  format: AeCairoSurfaceFormat CAIRO_FORMAT_ARGB32
]

{ #category : #tests }
AeCairoMigratedRenderTest >> surfaceWithFillAndStroke [
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
AeCairoMigratedRenderTest >> surfaceWithFillAndStrokeAlpha [
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
AeCairoMigratedRenderTest >> surfaceWithFillAndStrokeAlphaAdd [
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
AeCairoMigratedRenderTest >> surfaceWithFillDisjoint [
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
AeCairoMigratedRenderTest >> surfaceWithFillEmpty [
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
AeCairoMigratedRenderTest >> surfaceWithFillMissedStop [
	"Tests that the tessellator doesn't miss stop events when generating trapezoids.
	
    /* What it should look like, with # marking the filled areas:
     *
     * |\    |\
     * |#\   |#\
     * |##\__|##\
     *     \#|
     *      \|
     *
     * What it looked like with the bug, when the rightmost edge's end
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
AeCairoMigratedRenderTest >> surfaceWithGradientAlpha [
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
AeCairoMigratedRenderTest >> surfaceWithGradientConstantAlpha [
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
AeCairoMigratedRenderTest >> surfaceWithGradientZeroStops [
	"Verifies that gradients with no stops don't cause problems.
	
	Based on: gradient-zero-stops.c"

	| surfaceSize aSurface aContext aLinearGradient aRadialGradient |
	surfaceSize := 2 @ 2.
	aSurface := self newSurfaceExtent: surfaceSize.
	aContext := aSurface newContext.

	aLinearGradient :=
		AeCairoLinearGradientPattern
			from: 0 @ 0
			to: 1 @ 1.
	aContext
		source: aLinearGradient;
		paint.

	aRadialGradient :=
		AeCairoRadialGradientPattern 
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
AeCairoMigratedRenderTest >> surfaceWithGradientZeroStopsMask [
	"Verifies that gradients with no stops are considered clear.
	
	Based on: gradient-zero-stops-mask.c"

	| surfaceSize aSurface aContext aLinearGradient aRadialGradient |
	surfaceSize := 2 @ 2.
	aSurface := self newSurfaceExtent: surfaceSize.
	aContext := aSurface newContext.

	aContext sourceColorRGB: Color red.

	aLinearGradient :=
		AeCairoLinearGradientPattern
			from: 0 @ 0
			to: 1 @ 1.
	aContext mask: aLinearGradient.

	aRadialGradient :=
		AeCairoRadialGradientPattern 
			innerCenter: 0@0
			innerRadius: 0
			outerCenter: 1@1
			outerRadius: 1.
	aContext mask: aRadialGradient.

	^ aSurface
]

{ #category : #tests }
AeCairoMigratedRenderTest >> surfaceWithGroupClip [
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
AeCairoMigratedRenderTest >> surfaceWithGroupPaint [
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
AeCairoMigratedRenderTest >> surfaceWithGroupUnaligned [
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

{ #category : #tests }
AeCairoMigratedRenderTest >> surfaceWithInvertedClip [
	"Clip + InvertedClip should be opaque.
	
	Note: the original reference PNG in Cairo has a slight difference with the output of this test. Didn't dig more into this.
	
	Based on: inverted-clip.c"

	| surfaceSize aSurface aContext |
	surfaceSize := 100@100.
	aSurface := self newSurfaceExtent: surfaceSize.
	aContext := aSurface newContext.

	aContext
		useFillRuleEvenOdd;
		sourceColorRGB: Color green;
		arcCenterX: 50
			centerY: 50
			radius: 40
			startAngle: 0
			endAngle: Float twoPi;
		clipPreserve;
		paint.

	aContext
		rectangleX: 0
			y: 0
			width: 100
			height: 100;
		resetClip;
		clip;
		paint.

	^ aSurface
]

{ #category : #tests }
AeCairoMigratedRenderTest >> surfaceWithMeshPatternOverlap [
	"Paint a mesh pattern with a simple fold.
	
	Based on: mesh-pattern-overlap.c"

	| surfaceSize aSurface aContext size pad aMesh |
	size := 100.
	pad := 15.
	surfaceSize := (pad + size + pad) asPoint.
	aSurface := self newSurfaceExtent: surfaceSize.
	aContext := aSurface newContext.

	self drawTestPaintCheckeredOn: aContext.
	aContext translateByX: pad y: pad.
	
	aMesh := AeCairoMeshPattern newEmpty.
	aMesh beginPatch.
	
	aMesh
		moveToX: 0 y: 0;
		curveViaX:  30 y: -30 viaX: 60 y:  30 toX: 100 y: 0;
		curveViaX: 130 y: 140 viaX: 60 y: -40 toX: 100 y: 100;
		curveViaX:  60 y:  70 viaX: 30 y: 130 toX:   0 y: 100;
		curveViaX: -30 y: -40 viaX: 30 y: 140 toX:   0 y: 0.

	aMesh
		cornerAt: 0 putColorRGB: Color red;
		cornerAt: 1 putColorRGB: Color green;
		cornerAt: 2 putColorRGB: Color blue;
		cornerAt: 3 putColorRGB: Color yellow.
		
	aMesh endPatch.

	aContext
		source: aMesh;
		paint.

	^ aSurface
]

{ #category : #tests }
AeCairoMigratedRenderTest >> surfaceWithOutsideClipping [
	"Clipping outside a region.
	
	Based on: https://www.cairographics.org/cookbook/outside_clipping/"

	| surfaceSize aSurface aContext size |
	size := 30.
	surfaceSize := size @ size.
	aSurface := self newSurfaceExtent: surfaceSize.
	aContext := aSurface newContext.

	aContext
		operator: AeCairoCompositionOp CAIRO_OPERATOR_SOURCE;
		sourceColorRGB: Color white;
		paint.

	"Do two drawing passes, once clipped inside the region, then clipped outside.
	Because of the clipping, the second pass does not overwrite the first."
	{ false. true } do: [ :isOutside |
		aContext
			resetClip;
			resetPath;
			arcCenterX: size / 2.0
				centerY: size / 2.0
				radius: size / 4.0
				startAngle: 0
				endAngle: Float twoPi.
		isOutside ifTrue: [ 
			aContext
				beginSubPath;
				moveToX: size y: 0;
				lineToX: 0 y: 0;
				lineToX: 0 y: size;
				lineToX: size y: size;
				closePath ].
		aContext clip.
		aContext sourceColorRGB: (isOutside
			ifTrue: [ Color orange ]
			ifFalse: [Color green darker ]).
		aContext
			rectangleX: 0
				y: size / 4.0
				width: size
				height: size / 2.0;
			fill ].

	^ aSurface
]
