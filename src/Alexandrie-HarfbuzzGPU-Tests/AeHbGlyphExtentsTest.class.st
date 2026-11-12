"
I test AeHbGlyphExtents.
"
Class {
	#name : #AeHbGlyphExtentsTest,
	#superclass : #TestCase,
	#category : #'Alexandrie-HarfbuzzGPU-Tests'
}

{ #category : #tests }
AeHbGlyphExtentsTest >> testAccessors [

	| extents |
	extents := AeHbGlyphExtents new.
	extents
		xBearing: 10;
		yBearing: 20;
		width: 30;
		height: -40.
	self assert: extents xBearing equals: 10.
	self assert: extents yBearing equals: 20.
	self assert: extents width equals: 30.
	self assert: extents height equals: -40
]

{ #category : #tests }
AeHbGlyphExtentsTest >> testByteSize [

	self assert: AeHbGlyphExtents byteSize equals: 16
]
