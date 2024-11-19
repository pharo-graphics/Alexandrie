Class {
	#name : #AeCairoImageSurfaceTest,
	#superclass : #TestCase,
	#instVars : [
		'surface'
	],
	#category : #'Alexandrie-Cairo-Tests'
}

{ #category : #tests }
AeCairoImageSurfaceTest >> testColorAtInA8Format [

	| context |
	surface :=
		AeCairoImageSurface
			extent: 5 @ 3
			format: AeCairoSurfaceFormat a8.

	context := surface newContext.
	context
		rectangleX: 0 y: 0 width: 1 height: 3;
		sourceColor: Color red; fill.
	context
		rectangleX: 1 y: 0 width: 1 height: 3;
		sourceColor: (Color green alpha: 0.75); fill.
	context
		rectangleX: 2 y: 0 width: 1 height: 3;
		sourceColor: (Color blue alpha: 0.5); fill.
	context
		rectangleX: 4 y: 0 width: 1 height: 3;
		sourceColor: (Color yellow alpha: 0.25); fill.
	surface flush.

	"A8 is interpreted as black with variable levels of alpha"
	0 to: 2 do: [ :y |
		self assert: (surface colorAtX: 0 y: y) equals: Color black.
		self assert: (surface colorAtX: 1 y: y) equals: (Color black alpha: 0.75).
		self assert: (surface colorAtX: 2 y: y) equals: (Color black alpha: 0.5).
		self assert: (surface colorAtX: 3 y: y) equals: Color transparent.
		self assert: (surface colorAtX: 4 y: y) equals: (Color black alpha: 0.25) ]

]

{ #category : #tests }
AeCairoImageSurfaceTest >> testColorAtInARGB32Format [

	| context |
	surface :=
		AeCairoImageSurface
			extent: 5 @ 3
			format: AeCairoSurfaceFormat argb32.

	context := surface newContext.
	context
		rectangleX: 0 y: 0 width: 1 height: 3;
		sourceColor: Color red; fill.
	context
		rectangleX: 1 y: 0 width: 1 height: 3;
		sourceColor: (Color green alpha: 0.75); fill.
	context
		rectangleX: 2 y: 0 width: 1 height: 3;
		sourceColor: (Color blue alpha: 0.5); fill.
	context
		rectangleX: 4 y: 0 width: 1 height: 3;
		sourceColor: (Color yellow alpha: 0.25); fill.
	surface flush.

	0 to: 2 do: [ :y |
		self assert: (surface colorAtX: 0 y: y) equals: Color red.
		self assert: (surface colorAtX: 1 y: y) equals: (Color green alpha: 0.75).
		self assert: (surface colorAtX: 2 y: y) equals: (Color blue alpha: 0.5).
		self assert: (surface colorAtX: 3 y: y) equals: Color transparent.
		self assert: (surface colorAtX: 4 y: y) equals: (Color yellow alpha: 0.25) ]

]

{ #category : #tests }
AeCairoImageSurfaceTest >> testColorAtInRGB24Format [

	| context |
	surface :=
		AeCairoImageSurface
			extent: 5 @ 3
			format: AeCairoSurfaceFormat rgb24.

	context := surface newContext.
	context
		rectangleX: 0 y: 0 width: 1 height: 3;
		sourceColor: Color red; fill.
	context
		rectangleX: 1 y: 0 width: 1 height: 3;
		sourceColor: Color green; fill.
	context
		rectangleX: 2 y: 0 width: 1 height: 3;
		sourceColor: Color blue; fill.
	context
		rectangleX: 4 y: 0 width: 1 height: 3;
		sourceColor: Color yellow; fill.
	surface flush.

	0 to: 2 do: [ :y |
		self assert: (surface colorAtX: 0 y: y) equals: Color red.
		self assert: (surface colorAtX: 1 y: y) equals: Color green.
		self assert: (surface colorAtX: 2 y: y) equals: Color blue.
		self assert: (surface colorAtX: 3 y: y) equals: Color black.
		self assert: (surface colorAtX: 4 y: y) equals: Color yellow ]

]

{ #category : #tests }
AeCairoImageSurfaceTest >> testConvertZeroWidthAsFormARGB32 [

	| aSurface aForm |
	aSurface := AeCairoImageSurface
		extent: 0@50
		format: AeCairoSurfaceFormat argb32.

	aForm := aSurface asFormARGB32.
	self assert: aForm extent equals: aSurface extent.
]

{ #category : #tests }
AeCairoImageSurfaceTest >> testErrorReadingPNG [

	self
		should: [ AeCairoImageSurface newFromPngFileAt: 'unexisting_png' asFileReference ]
		raise: AeCairoStatusError
]

{ #category : #tests }
AeCairoImageSurfaceTest >> testExtent [

	surface := AeCairoImageSurface extent: 100 @ 50.

	self assert: surface extent equals: 100 @ 50
]

{ #category : #tests }
AeCairoImageSurfaceTest >> testExtentFormat [

	surface := AeCairoImageSurface
		           extent: 100 @ 50
		           format: AeCairoSurfaceFormat argb32.

	self assert: surface extent equals: 100 @ 50
]

{ #category : #tests }
AeCairoImageSurfaceTest >> testFromForm [

	| aForm |
	aForm := Form fromFileNamed: AeFilesystemResources removeIconPNG.
	surface := AeCairoImageSurface fromForm: aForm.

	self assert: surface extent equals: aForm extent
]

{ #category : #tests }
AeCairoImageSurfaceTest >> testHasDevice [

	surface := AeCairoImageSurface extent: 1 @ 1.

	self deny: surface hasDevice
]

{ #category : #tests }
AeCairoImageSurfaceTest >> testHeight [

	surface := AeCairoImageSurface extent: 100 @ 50.

	self assert: surface height equals: 50
]

{ #category : #tests }
AeCairoImageSurfaceTest >> testNewForByteArray [

	| width height format stride byteArray |
	width := 200.
	height := 150.
	format := AeCairoSurfaceFormat argb32.
	stride := AeCairoImageSurface strideForWidth: width format: format.
	byteArray := ByteArray new: stride * width.

	surface :=
		AeCairoImageSurface 
			newForData: byteArray asExternalPointer
			format: format
			width: width
			height: height
			stride: stride.

	[	surface newContext sourceColor: Color blue; paint.
		surface flush ] ensure: [
			"The buffer must be destroyed after the surface."
			surface externallyFree ]
]

{ #category : #tests }
AeCairoImageSurfaceTest >> testNewForFFIExternalArray [

	| width height format stride buffer |
	width := 200.
	height := 150.
	format := AeCairoSurfaceFormat argb32.
	stride := AeCairoImageSurface strideForWidth: width format: format.
	buffer := AeFFIUInt8Array unownedNewOf: stride * height.

	surface :=
		AeCairoImageSurface 
			newForData: buffer
			format: format
			width: width
			height: height
			stride: stride.

	[	surface newContext sourceColor: Color blue; paint.
		surface flush ] ensure: [
			"The buffer must be destroyed after the surface."
			surface externallyFree.
			buffer free ]
]

{ #category : #tests }
AeCairoImageSurfaceTest >> testNewSimilarImageFormatWidthHeight [

	| aSimilarSurface |
	surface := AeCairoImageSurface
		           extent: 100 @ 50
		           format: AeCairoSurfaceFormat argb32.

	aSimilarSurface := surface
		                   newSimilarImageFormat:
		                   AeCairoSurfaceFormat a8
		                   width: 16
		                   height: 20.

	self
		assert: aSimilarSurface format
		equals: AeCairoSurfaceFormat a8.
	self assert: aSimilarSurface extent equals: 16 @ 20.
	self assert: aSimilarSurface status isSuccess.
]

{ #category : #tests }
AeCairoImageSurfaceTest >> testPremultipliedAlphaCanLooseInformation [
	"The purpose of this test is showing that pixels with little alpha loose information due to Cairo's premultiplied-alpha."

	| aColor aSurface pixelValue |
	aSurface := AeCairoImageSurface
		extent: 1@1
		format: AeCairoSurfaceFormat argb32.
	aColor := Color r: 1.0 g: 0.75 b: 0.5 alpha: 0.004.
	aSurface newContext
		sourceColor: aColor;
		paint.
	aSurface flush.

	"Conversion to Form shows that some color components are lost"
	self
		assert: (aSurface asFormARGB32 colorAt: 0@0)
		equals: (Color r: 1.0 g: 0.0 b: 0.0 alpha: 0.00392156862745098).

	"Note: Such information is already lost in the Cairo's internal buffer"
	pixelValue := aSurface data uint32AtOffset: 0.
	self assert: (pixelValue byteAt: 1) equals: 0. "blue"
	self assert: (pixelValue byteAt: 2) equals: 0. "green"
	self assert: (pixelValue byteAt: 3) equals: 1. "red"
	self assert: (pixelValue byteAt: 4) equals: 1. "alpha"
]

{ #category : #tests }
AeCairoImageSurfaceTest >> testPremultipliedAlphaConversionAsForm [
	"Cairo uses premultiplied-alpha while Form uses straight-alpha"

	| aColor aSurface aForm aSurfaceBytes anotherSurface anotherSurfaceBytes |
	aColor := Color red alpha: 0.4.

	aSurface := AeCairoImageSurface
		extent: 1@1
		format: AeCairoSurfaceFormat argb32.
	aSurface newContext
		sourceColor: aColor;
		paint.

	aForm := aSurface asFormARGB32.
	self
		assert: (aForm colorAt: 0@0)
		equals: aColor.

	"Take the byte array as a reference"
	aSurface flush.
	aSurfaceBytes := FFIExternalArray
		fromHandle: aSurface data
		type: FFIUInt8
		size: aSurface byteSize.

	anotherSurface := AeCairoImageSurface fromForm: aForm.
	anotherSurface flush.
	anotherSurfaceBytes := FFIExternalArray
		fromHandle: anotherSurface data
		type: FFIUInt8
		size: anotherSurface byteSize.

	"The bytes of the reconverted surface match"
	self
		assert: anotherSurfaceBytes
		equals: aSurfaceBytes
]

{ #category : #tests }
AeCairoImageSurfaceTest >> testPremultipliedAlphaConversionFromForm [
	"Cairo uses premultiplied-alpha while Form uses straight-alpha"

	| aColor aSurface aForm anotherForm |
	aColor := Color red alpha: 0.4.
	aForm := Form extent: 100@100  depth: 32.
	aForm fillColor: aColor.
	self
		assert: (aForm colorAt: 0@0)
		equals: aColor.

	aSurface := AeCairoImageSurface fromForm: aForm.
	anotherForm := aSurface asForm.
	self
		assert: (anotherForm colorAt: 0@0)
		equals: aColor
]

{ #category : #tests }
AeCairoImageSurfaceTest >> testReadNonASCIIFilenamePNG [

	surface := AeCairoImageSurface newFromPngFileAt: AeFilesystemResources testsDirectory / 'import' / 'utf8-logō.png'.

	self assert: surface extent equals: 100 @ 34
]

{ #category : #tests }
AeCairoImageSurfaceTest >> testStrideForWidthFormat [

	self
		assert: (AeCairoImageSurface
				 strideForWidth: 150
				 format: AeCairoSurfaceFormat a8)
		equals: 152.

	self
		assert: (AeCairoImageSurface
				 strideForWidth: 150
				 format: AeCairoSurfaceFormat argb32)
		equals: 150 * 4.

]

{ #category : #tests }
AeCairoImageSurfaceTest >> testWidth [

	surface := AeCairoImageSurface extent: 100 @ 50.

	self assert: surface width equals: 100
]

{ #category : #tests }
AeCairoImageSurfaceTest >> testWriteNonASCIIFilenamePNG [

	| aPNGFileReference |
	surface := AeCairoImageSurface extent: 2 @ 3.

	aPNGFileReference := 'test_write_ū.png' asFileReference.
	aPNGFileReference ensureDelete.
	self deny: aPNGFileReference exists.

	surface writePngTo: aPNGFileReference.

	self assert: aPNGFileReference exists.
	self assert: aPNGFileReference size > 50.
	aPNGFileReference ensureDelete.

]
