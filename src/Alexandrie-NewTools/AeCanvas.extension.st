Extension { #name : #AeCanvas }

{ #category : #'*Alexandrie-NewTools' }
AeCanvas >> inspectionOfSurface: aBuilder [
	<inspectorPresentationOrder: 0 title: 'Surface'>

	^ cairoSurface inspectionAsForm: aBuilder
]
