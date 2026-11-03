"
I test AeHbGpuDraw.
"
Class {
	#name : #AeHbGpuDrawTest,
	#superclass : #TestCase,
	#category : #'Alexandrie-HarfbuzzGPU-Tests'
}

{ #category : #tests }
AeHbGpuDrawTest >> testDrawAndEncodeGlyph [

	| blob face font draw extents encodedBlob |
	blob := AeHbBlob newLocatedAt: AeFilesystemResources inriaSerifRegularTTF.
	face := blob newHbFaceAtIndex: 0.
	font := face newHbFont.
	draw := AeHbGpuDraw new.
	extents := AeHbGlyphExtents new.
	draw drawGlyphFont: font glyph: 65.
	encodedBlob := draw encodeExtents: extents.
	self assert: encodedBlob isNotNil.
	self assert: encodedBlob length > 0.
	self assert: extents width > 0.
	draw recycleBlob: encodedBlob
]

{ #category : #tests }
AeHbGpuDrawTest >> testLifecycle [

	| draw |
	draw := AeHbGpuDraw new.
	self deny: draw isNull.
	draw scale: 1000 @ 1000.
	self assert: draw scale equals: 1000 @ 1000
]
