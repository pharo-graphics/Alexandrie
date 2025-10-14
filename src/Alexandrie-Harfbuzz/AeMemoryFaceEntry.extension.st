Extension { #name : #AeMemoryFaceEntry }

{ #category : #'*Alexandrie-Harfbuzz' }
AeMemoryFaceEntry >> newHbFont [
	
	| aBlob aFace |
	aBlob := AeHbBlob newFrom: bytes.
	aFace := aBlob newHbFaceAtIndex: index.
	^ aFace newHbFont
]
