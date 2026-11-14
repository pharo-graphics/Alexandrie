Extension { #name : #LibC }

{ #category : #'*Alexandrie-ImageMatch' }
LibC >> memCompare: aFirstPointer with: aSecondPointer size: aNumberOfBytes [

	^ self ffiCall: #(int memcmp(const void * aFirstPointer, const void * aSecondPointer, size_t aNumberOfBytes))
]
