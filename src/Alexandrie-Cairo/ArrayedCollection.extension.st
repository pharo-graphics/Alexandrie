Extension { #name : #ArrayedCollection }

{ #category : #'*Alexandrie-Cairo-Filters' }
ArrayedCollection >> zeroBasedAt: aZeroBasedIndex [ 
	
	^ self at: aZeroBasedIndex + 1
]

{ #category : #'*Alexandrie-Cairo' }
ArrayedCollection >> zeroBasedAt: aZeroBasedIndex putUint8: aValue [

"	Halt if: [ (aZeroBasedIndex%25) > 10 and: [aValue floor between: 1 and: 254] ].
"
	^ self at: aZeroBasedIndex + 1 put: aValue floor
]
