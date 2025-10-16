Extension { #name : #AeCairoTextToGlyphShaping }

{ #category : #'*Alexandrie-CairoFreetype-Tests' }
AeCairoTextToGlyphShaping class >> exampleShapeAndDraw [

	| fontSize string surfaceSize aSurface aContext aFTFace aScaledFont aShaping aStatus |
	fontSize := 12.
	"Get Lorem Ipsum without last cr character"
	string := (String loremIpsum: 28) allButLast.
	surfaceSize := 150 @ (fontSize*1.3).
	aSurface := AeCairoImageSurface
		  extent: surfaceSize
		  format: AeCairoSurfaceFormat argb32.
	aContext := aSurface newContext.

	"Set up scaled font in the context"
	aFTFace := AeSourceSansPro_Regular firstFaceUsing: AeFTLibrary newInitialized.
	aContext
		fontFace: aFTFace newCairoFontFace;
		fontSize: fontSize.
	aScaledFont := aContext scaledFont.

	aShaping := AeCairoTextToGlyphShaping new.
	aShaping string: string.
	aShaping scaledFont: aScaledFont.
	aStatus := aShaping convertTextToGlyphs.
	aStatus ensureIsSuccess.
"	aShaping newGlyphArray.
	aShaping newClusterArray."
	
	aContext
		translateByX: 5 y: fontSize;
		sourceColor: Color blue;
		scaledFont: aScaledFont.
	
	aShaping showTextGlyphsOn: aContext.

	^ aSurface inspect
]
