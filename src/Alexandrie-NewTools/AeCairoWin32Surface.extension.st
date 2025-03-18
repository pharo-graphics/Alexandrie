Extension { #name : #AeCairoWin32Surface }

{ #category : #'*Alexandrie-NewTools' }
AeCairoWin32Surface >> inspectionAsForm: aBuilder [
	<inspectorPresentationOrder: 1 title: 'Form'>
	
	^ aBuilder newMorph
		morph: (AePollingImageMorph new model: self image; yourself);
		yourself
]
