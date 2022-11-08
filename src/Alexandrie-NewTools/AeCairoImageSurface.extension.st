Extension { #name : #AeCairoImageSurface }

{ #category : #'*Alexandrie-NewTools' }
AeCairoImageSurface >> inspectionAsForm: aBuilder [
	<inspectorPresentationOrder: 1 title: 'Form'>
	
	^ aBuilder newMorph
		morph: self asForm asMorph;
		yourself
]
