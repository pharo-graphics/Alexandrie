Extension { #name : #AeCairoContextTest }

{ #category : #'*Alexandrie-CairoFreetype-Tests' }
AeCairoContextTest >> testScaledFont [

	| aSurface aContext aFontFace scaledFont17 scaledFont71 scaledFont17b sameFaceInDifferentFTLibrary |
	aSurface := AeCairoImageSurface extent: 1@1.
	aContext := aSurface newContext.
	
	"Set up scaled font in the context"
	aFontFace := (AeSourceSansPro_Regular firstFaceUsing: AeFTLibrary newInitialized) newCairoFontFace.
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
	
	"Cairo cache doesn't work if Freetype face belongs to a different library"
	sameFaceInDifferentFTLibrary :=
		(AeSourceSansPro_Regular firstFaceUsing: AeFTLibrary newInitialized) newCairoFontFace.
	aContext fontFace: sameFaceInDifferentFTLibrary.
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
