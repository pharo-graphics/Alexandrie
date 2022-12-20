Extension { #name : #ArrayedCollection }

{ #category : #'*Alexandrie-Cairo-Filters' }
ArrayedCollection >> zeroIndexAt: aZeroBasedIndex [ 
	
	^ self at: aZeroBasedIndex + 1
]

{ #category : #'*Alexandrie-Cairo' }
ArrayedCollection >> zeroIndexAt: aZeroBasedIndex putUint8: aValue [

	^ self at: aZeroBasedIndex + 1 put: aValue floor
]
