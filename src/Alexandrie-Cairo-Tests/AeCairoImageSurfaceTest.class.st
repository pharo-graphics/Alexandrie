Class {
	#name : #AeCairoImageSurfaceTest,
	#superclass : #TestCase,
	#instVars : [
		'surface'
	],
	#category : #'Alexandrie-Cairo-Tests'
}

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
	aForm := Smalltalk ui icons iconNamed: #classIcon.
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

	| extent format stride byteArray |
	extent := 200 @ 150.
	format := AeCairoSurfaceFormat argb32.
	stride := AeCairoImageSurface strideForWidth: extent x format: format.

	byteArray := ByteArray new: stride * extent y.

	surface := AeCairoImageSurface 
		newForData: byteArray asExternalPointer
		extent: extent
		stride: stride
		format: format.

	self
		shouldnt: [[
			surface newContext
				sourceColorRGB: Color blue;
				circleRadius: extent min / 2;
				fill.
			surface flush ] ensure: [
				"The buffer must be destroyed after the surface."
				surface externallyFree ]]
		raise: Error

]

{ #category : #tests }
AeCairoImageSurfaceTest >> testNewForFFIExternalArray [

	| extent format stride buffer |
	extent := 200 @ 150.
	format := AeCairoSurfaceFormat argb32.
	stride := AeCairoImageSurface strideForWidth: extent x format: format.

	buffer := FFIExternalArray externalNewType: FFIUInt8 size: stride * extent y.

	surface := AeCairoImageSurface 
		newForData: buffer
		extent: extent
		stride: stride
		format: format.

	self
		shouldnt: [[
			surface newContext
				sourceColorRGB: Color blue;
				circleRadius: extent min / 2;
				fill.
			surface flush ] ensure: [
				"The buffer must be destroyed after the surface."
				surface externallyFree.
				buffer free ]]
		raise: Error

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

	surface writeToPngAtFileReference: aPNGFileReference.

	self assert: aPNGFileReference exists.
	self assert: aPNGFileReference size > 0.
	aPNGFileReference ensureDelete.

]
