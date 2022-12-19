Class {
	#name : #AeCairoExamplesRenderTest,
	#superclass : #AeCairoRenderTest,
	#category : #'Alexandrie-Cairo-Tests'
}

{ #category : #convenience }
AeCairoExamplesRenderTest class >> exportAll [
	<script: 'self exportAll' >

	super exportAll
]

{ #category : #convenience }
AeCairoExamplesRenderTest class >> inspectAll [
	<script: 'self inspectAll' >

	super inspectAll
]

{ #category : #convenience }
AeCairoExamplesRenderTest class >> inspectMismatches [
	<script: 'self inspectMismatches' >

	super inspectMismatches
]

{ #category : #tests }
AeCairoExamplesRenderTest >> surfaceWithText [

	| fontSize string surfaceSize aSurface aContext aFTFace aFontFace aScaledFont aGlyphArray |
	fontSize := 12.
	"Get Lorem Ipsum without last cr character"
	string := (String loremIpsum: 28) allButLast.
	surfaceSize := 150 @ (fontSize*1.3).
	aSurface := AeCairoImageSurface
		  extent: surfaceSize
		  format: AeCairoSurfaceFormat CAIRO_FORMAT_ARGB32.
	aContext := aSurface newContext.

	"Set up aScaleFont"
	aFTFace := AeFontManager globalInstance
		detectFamilyName: AeSourceSansPro_Regular familyName
		slant: AeFontSlant normal
		weight: AeFontWeight normal
		stretch: AeFontStretch normal
		ifNone: [ self error ].
	aFontFace := AeCairoFreetypeFontFace newForFace: aFTFace.
	aScaledFont := aFontFace 
		newScaledFontWithFontMatrix: (AeCairoMatrix newScalingBy: fontSize asPoint)
		userToDeviceMatrix: AeCairoMatrix newIdentity
		options: AeCairoFontOptions new.

	"Create text glyphs to draw"	
	aGlyphArray := aScaledFont glyphArrayForString: string.

	"Draw glyphs"
	aContext
		sourceColorRGB: Color paleGreen;
		paint;
		translateByX: 5 y: fontSize;
		sourceColorRGB: Color blue;
		scaledFont: aScaledFont;
		showGlyphs: aGlyphArray.

	^ aSurface
]

{ #category : #tests }
AeCairoExamplesRenderTest >> surfaceWithTextPixelated [
	"The trick is: 
	- Create special font options with full hinting and without anti-aliasing
	- Draw the text in a group (i.e not directly on the surface)
	- Convert the group to a pattern, to customize its filter and matrix
	- Finally, paint the pattern on the surface"

	| zoom fontSize surfaceSize string aSurface aContext  aFTFace aScaledFont aGlyphArray aFontOptions aFontFace aPattern |
	fontSize := 17.
	zoom := 2.
	string := 'aeiou'.
	surfaceSize := (40 @ (fontSize*1.3)) * zoom.
	aSurface := AeCairoImageSurface
		  extent: surfaceSize
		  format: AeCairoSurfaceFormat CAIRO_FORMAT_ARGB32.
	aContext := aSurface newContext.

	"Set up aScaleFont"
	aFTFace := AeFontManager globalInstance
		detectFamilyName: AeSourceSansPro_Regular familyName
		slant: AeFontSlant normal
		weight: AeFontWeight normal
		stretch: AeFontStretch normal
		ifNone: [ self error ].
	aFontOptions := AeCairoFontOptions new
		antialias: AeCairoAntialias CAIRO_ANTIALIAS_NONE;
		hintStyle: AeCairoHintStyle CAIRO_HINT_STYLE_FULL;
		yourself.
	aFontFace := AeCairoFreetypeFontFace newForFace: aFTFace.
	aScaledFont := aFontFace 
		newScaledFontWithFontMatrix: (AeCairoMatrix newScalingBy: fontSize asPoint)
		userToDeviceMatrix: AeCairoMatrix newIdentity
		options: aFontOptions.

	"Create text glyphs to draw"	
	aGlyphArray := aScaledFont glyphArrayForString: string.

	"Draw glyphs"
	aPattern := aContext
		pushGroup;
			translateByX: 2 y: fontSize;
			sourceColorRGB: Color blue;
			scaledFont: aScaledFont;
			showGlyphs: aGlyphArray;
		popGroupAsSurfacePattern.
	aPattern
		filter: AeCairoSamplingFilter CAIRO_FILTER_NEAREST;
		matrix: (AeCairoMatrix newScalingBy: (1.0/zoom) asPoint).

	aContext
		sourceColorRGB: Color paleGreen;
		paint;
		source: aPattern;
		paint.

	^ aSurface
]
