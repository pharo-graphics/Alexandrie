"
I test AeHbGpuPaint.
"
Class {
	#name : #AeHbGpuPaintTest,
	#superclass : #TestCase,
	#category : #'Alexandrie-HarfbuzzGPU-Tests'
}

{ #category : #tests }
AeHbGpuPaintTest >> testLifecycle [

	| paint |
	paint := AeHbGpuPaint new.
	self deny: paint isNull.
	paint palette: 1.
	self assert: paint palette equals: 1.
	paint scale: 500 @ 500.
	self assert: paint scale equals: 500 @ 500
]

{ #category : #tests }
AeHbGpuPaintTest >> testPaintAndEncodeGlyph [

	| blob face font paint extents encodedBlob |
	blob := AeHbBlob newLocatedAt: AeFilesystemResources inriaSerifRegularTTF.
	face := blob newHbFaceAtIndex: 0.
	font := face newHbFont.
	paint := AeHbGpuPaint new.
	extents := AeHbGlyphExtents new.
	paint paintGlyphFont: font glyph: 65.
	encodedBlob := paint encodeExtents: extents.
	self assert: encodedBlob isNotNil.
	self assert: encodedBlob length > 0.
	self assert: extents width > 0.
	paint recycleBlob: encodedBlob
]
