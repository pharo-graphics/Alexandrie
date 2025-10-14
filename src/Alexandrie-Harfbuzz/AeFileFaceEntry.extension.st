Extension { #name : #AeFileFaceEntry }

{ #category : #'*Alexandrie-Harfbuzz' }
AeFileFaceEntry >> newHbFont [
	
	| aBlob aFace |
	aBlob := AeHbBlob newLocatedAt: location.
	aFace := aBlob newHbFaceAtIndex: index.
	^ aFace newHbFont
]
