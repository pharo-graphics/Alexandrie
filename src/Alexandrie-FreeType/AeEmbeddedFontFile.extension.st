Extension { #name : #AeEmbeddedFontFile }

{ #category : #'*Alexandrie-FreeType' }
AeEmbeddedFontFile class >> allFacesUsing: aFTLibrary [

	^ Array streamContents: [ :stream |
		aFTLibrary
			unownedNewFacesFromBytes: self fontContentsData
			withIndexDo: [ :eachFace :index |
				eachFace autoRelease.
				stream nextPut: eachFace ] ]
]

{ #category : #'*Alexandrie-FreeType' }
AeEmbeddedFontFile class >> firstFaceUsing: aFTLibrary [

	^ aFTLibrary newFaceFromBytes: self fontContentsData index: 0
]
