Extension { #name : #AeImageComparison }

{ #category : #'*Alexandrie-NewTools' }
AeImageComparison >> inspectionActualVsExpected: aBuilder [

	<inspectorPresentationOrder: 1 title: 'Actual/Expected'>
	^ aBuilder newMorph
		morph: (self newMergedSurfaceScaledBy: self inspectionMagnification withDiffOverlay: false) asForm asMorph;
		yourself
]

{ #category : #'*Alexandrie-NewTools' }
AeImageComparison >> inspectionActualVsExpectedDiff: aBuilder [

	<inspectorPresentationOrder: 2 title: 'Actual/Expected Diff'>
	^ aBuilder newMorph
		morph: (self newMergedSurfaceScaledBy: self inspectionMagnification withDiffOverlay: true) asForm asMorph;
		yourself
]

{ #category : #'*Alexandrie-NewTools' }
AeImageComparison >> inspectionDiagnosis: aBuilder [

	<inspectorPresentationOrder: 3 title: 'Diagnosis'>
	^ aBuilder newText
		text: self diagnosisString;
		yourself
]

{ #category : #'*Alexandrie-NewTools' }
AeImageComparison >> inspectionMagnification [

	^ 2
]
