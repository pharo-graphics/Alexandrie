Extension { #name : #AeCairoContext }

{ #category : #'*Alexandrie-NewTools' }
AeCairoContext >> inspectionOfClippingArea: aBuilder [
	<inspectorPresentationOrder: 1 title: 'Clipping Area'>

	^ aBuilder newMorph
		morph: self clippingAreaAsForm asMorph;
		yourself
]

{ #category : #'*Alexandrie-NewTools' }
AeCairoContext >> inspectionOfSurfaceAsForm: aBuilder [
	<inspectorPresentationOrder: 0 title: 'Surface'>

	^ surface inspectionAsForm: aBuilder
]
