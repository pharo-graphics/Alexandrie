Extension { #name : #AeDownloadedFont }

{ #category : #'*Alexandrie-FreeType' }
AeDownloadedFont >> firstFaceUsing: aFTLibrary [ 

	^ aFTLibrary newFaceFromFile: self fileReference index: 0
]
