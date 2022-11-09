Extension { #name : #AePixelComparison }

{ #category : #'*Alexandrie-NewTools' }
AePixelComparison >> inspectionActualVsExpected: aBuilder [
	<inspectorPresentationOrder: 1 title: 'Actual/Expected'>

	^ aBuilder newMorph
		morph: (self actualVsExpectedMergedForm  magnifyBy:
			self inspectionMagnification) asMorph;
		yourself
]

{ #category : #'*Alexandrie-NewTools' }
AePixelComparison >> inspectionActualVsExpectedDiff: aBuilder [
	<inspectorPresentationOrder: 2 title: 'Actual/Expected Diff'>

	^ aBuilder newMorph
		  morph: (self actualVsExpectedMergedDiffForm magnifyBy:
				self inspectionMagnification) asMorph;
		  yourself
]

{ #category : #'*Alexandrie-NewTools' }
AePixelComparison >> inspectionMagnification [

	^ 2
]
