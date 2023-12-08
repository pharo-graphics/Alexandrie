Extension { #name : #AeCairoPath }

{ #category : #'*Alexandrie-Athens' }
AeCairoPath >> asAthensShapeOn: anAthensAeCairoCanvas [ 
	
	^ self
]

{ #category : #'*Alexandrie-Athens' }
AeCairoPath >> paintFillsUsing: aPaint on: anAthensAeCairoCanvas [ 

	^ aPaint athensFillPath: self on: anAthensAeCairoCanvas
]
