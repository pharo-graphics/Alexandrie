Extension { #name : #ArrayedCollection }

{ #category : #'*Alexandrie-Cairo-Filters' }
ArrayedCollection >> zeroBasedAt: aZeroBasedIndex [ 
	
	^ self at: aZeroBasedIndex + 1
]

{ #category : #'*Alexandrie-Cairo' }
ArrayedCollection >> zeroBasedAt: aZeroBasedIndex putUint8: aValue [

	^ self at: aZeroBasedIndex + 1 put: aValue floor
]
