Extension { #name : #AeCairoExamplesRenderTest }

{ #category : #'*Alexandrie-CairoFreetype-Tests' }
AeCairoExamplesRenderTest >> surfaceWithFlippedText [

	| extent center textSurface textContext aFontFace mainSurface mainContext m |
	extent := 34 @ 16.
	center := extent / 2.0.

	"Prepare a surface to use as pattern"
	textSurface :=
		AeCairoImageSurface
			extent: extent
			format: AeCairoSurfaceFormat argb32.
	textContext := textSurface newContext.
	aFontFace := AeFTLibraryResource current
		sourceSansProRegularFTFace newCairoFontFace.
	textContext
		fontFace: aFontFace;
		fontSize: extent y;
		translateByX: 0 y: extent y;
		showText: 'Cairo'.

	"Paint the text surface 4 times"
	mainSurface :=
		AeCairoImageSurface
			extent: extent * 2
			format: AeCairoSurfaceFormat argb32.
	mainContext := mainSurface newContext.
	mainContext sourceSurface: textSurface.
	mainContext paint.

	m := AeCairoMatrix newIdentity.
	m beFlipHorizontallyAround: center x.
	m translateBy: extent x negated @ 0.
	mainContext source matrix: m.
	mainContext paint.

	m beFlipVerticallyAround: center y.
	m translateBy: 0 @ extent y negated.
	mainContext source matrix: m.
	mainContext paint.

	m beFlipBothAround: center.
	m translateBy: extent negated.
	mainContext source matrix: m.
	mainContext paint.

	^ mainSurface
]

{ #category : #'*Alexandrie-CairoFreetype-Tests' }
AeCairoExamplesRenderTest >> surfaceWithText [

	| fontSize string surfaceSize aSurface aContext aFTFace aScaledFont |
	fontSize := 12.
	"Get Lorem Ipsum without last cr character"
	string := (String loremIpsum: 28) allButLast.
	surfaceSize := 150 @ (fontSize*1.3).
	aSurface := AeCairoImageSurface
		  extent: surfaceSize
		  format: AeCairoSurfaceFormat argb32.
	aContext := aSurface newContext.

	"Paint background"
	aContext
		sourceColor: Color paleGreen;
		paint.
	
	"Set up scaled font in the context"
	aFTFace := AeFTLibraryResource current sourceSansProRegularFTFace.
	aContext
		fontFace: aFTFace newCairoFontFace;
		fontSize: fontSize.
	aScaledFont := aContext scaledFont.

	"Draw text"
	aContext
		translateByX: 5 y: fontSize;
		sourceColor: Color blue;
		scaledFont: aScaledFont;
		showGlyphs: (aScaledFont glyphArrayForString: ''); "Draws nothing"
		showGlyphs: (aScaledFont glyphArrayForString: string).

	^ aSurface
]

{ #category : #'*Alexandrie-CairoFreetype-Tests' }
AeCairoExamplesRenderTest >> surfaceWithTextAsPath [

	| fontSize string surfaceSize aSurface aContext aFTFace aFontFace glyphArray |
	fontSize := 25.
	string := 'Hola'.
	surfaceSize := 60 @ 30.
	aSurface := AeCairoImageSurface
		            extent: surfaceSize
		            format: AeCairoSurfaceFormat argb32.
	aContext := aSurface newContext.

	"Set up"
	aFTFace := AeFTLibraryResource current sourceSansProBoldFTFace.
	aFontFace := aFTFace newCairoFontFace.
	aContext
		sourceColor: Color paleGreen;
		paint;
		translateByX: 4 y: fontSize;
		fontFace: aFontFace;
		fontSize: fontSize.

	"Add glyphs to path"
	glyphArray := aContext scaledFont glyphArrayForString: string.
	aContext appendGlyphsPath: glyphArray.

	"Draw dashed stroke using the path"
	aContext
		sourceColor: Color blue;
		strokeDashPattern: #(7 1) offset: 3;
		strokeSize: 1.5;
		stroke.

	^ aSurface
]

{ #category : #'*Alexandrie-CairoFreetype-Tests' }
AeCairoExamplesRenderTest >> surfaceWithTextPixelated [
	"The trick is: 
	- Create special font options with full hinting and without anti-aliasing
	- Draw the text in a group (i.e not directly on the surface)
	- Convert the group to a pattern, to customize its filter and matrix
	- Finally, paint the pattern on the surface"

	| zoom fontSize surfaceSize string aSurface aContext aFTFace aScaledFont aGlyphArray aFontOptions aFontFace aPattern |
	fontSize := 17.
	zoom := 2.
	string := 'aeiou'.
	surfaceSize := (40 @ (fontSize*1.3)) * zoom.
	aSurface := AeCairoImageSurface
		  extent: surfaceSize
		  format: AeCairoSurfaceFormat argb32.
	aContext := aSurface newContext.

	"Set up aScaleFont"
	aFTFace := AeFTLibraryResource current sourceSansProRegularFTFace.
	aFontOptions := AeCairoFontOptions new
		antialias: AeCairoAntialias none;
		hintStyle: AeCairoHintStyle full;
		yourself.
	aFontFace := aFTFace newCairoFontFace.
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
			sourceColor: Color blue;
			scaledFont: aScaledFont;
			showGlyphs: aGlyphArray;
		popGroupAsSurfacePattern.
	aPattern
		filter: AeCairoSamplingFilter nearest;
		matrix: (AeCairoMatrix newScalingBy: (1.0/zoom) asPoint).

	aContext
		sourceColor: Color paleGreen;
		paint;
		sourcePattern: aPattern;
		paint.

	^ aSurface
]

{ #category : #'*Alexandrie-CairoFreetype-Tests' }
AeCairoExamplesRenderTest >> surfaceWithToyAPIShowText [
	"Use `AeCairoContext>>#showText:`, which cairo documentation considers 'toy API'."

	| string fontSize aSurface aFTFace aFontFace |
	string := 'Hï'.
	fontSize := 25.
	aSurface := AeCairoImageSurface
		  extent: 30 @ 30
		  format: AeCairoSurfaceFormat rgb24.

	"Set up a font"
	aFTFace := AeFTLibraryResource current sourceSansProBoldFTFace.
	aFontFace := aFTFace newCairoFontFace.

	aSurface newContextDo: [ :aContext |
		aContext
			fontFace: aFontFace;
			fontSize: fontSize;
			sourceColor: Color white;
			translateByX: 2 y: fontSize;
			showText: string ].

	^ aSurface
]
