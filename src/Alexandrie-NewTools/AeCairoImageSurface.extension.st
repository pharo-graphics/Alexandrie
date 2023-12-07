Extension { #name : #AeCairoImageSurface }

{ #category : #'*Alexandrie-NewTools' }
AeCairoImageSurface >> inspectionAsForm: aBuilder [
	<inspectorPresentationOrder: 1 title: 'Form'>
	
	^ aBuilder newMorph
		morph: (AePollingImageMorph new model: self; yourself);
		yourself
]
