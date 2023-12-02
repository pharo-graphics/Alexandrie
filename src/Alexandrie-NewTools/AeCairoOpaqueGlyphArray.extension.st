Extension { #name : 'AeCairoOpaqueGlyphArray' }

{ #category : '*Alexandrie-NewTools' }
AeCairoOpaqueGlyphArray >> inspectionOfGlyphs: aBuilder [
	<inspectorPresentationOrder: 0 title: 'Glyphs'>

	^ self asExternalStructure inspectionItems: aBuilder
]
