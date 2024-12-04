Extension { #name : #AeFontManager }

{ #category : #'*Alexandrie-NewTools' }
AeFontManager >> faceEntriesSortedByFamilySlantWeightStretch [

	^ self faceEntries sorted:
		#familyName ascending,
		#slantValue ascending,
		#weightValue ascending,
		#stretchValue ascending
]

{ #category : #'*Alexandrie-NewTools' }
AeFontManager >> inspectionFaces: aBuilder [
	<inspectorPresentationOrder: 1 title: 'Faces'>

	^ aBuilder newTable
		items: self faceEntriesSortedByFamilySlantWeightStretch;
		addColumn: (SpStringTableColumn
			title: 'Family name'
			evaluated: #familyName);
		addColumn: (SpStringTableColumn
			title: 'Slant'
			evaluated: #slantName);
		addColumn: (SpStringTableColumn
			title: 'Weight'
			evaluated: #weightName);
		addColumn: (SpStringTableColumn
			title: 'Stretch'
			evaluated: #stretchName);
		yourself
]
