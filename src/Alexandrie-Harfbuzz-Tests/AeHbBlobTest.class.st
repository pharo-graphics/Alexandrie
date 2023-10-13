"
An AeHbBlobTest is a test class for testing the behavior of AeHbBlob
"
Class {
	#name : #AeHbBlobTest,
	#superclass : #TestCase,
	#category : #'Alexandrie-Harfbuzz-Tests'
}

{ #category : #running }
AeHbBlobTest >> inriaSerifRegularBlob [

	^ AeHbBlob newLocatedAt: AeFilesystemResources inriaSerifRegularTTF
]

{ #category : #tests }
AeHbBlobTest >> testFaceCount [

	self
		assert: self inriaSerifRegularBlob faceCount
		equals: 1
]

{ #category : #tests }
AeHbBlobTest >> testLength [

	self
		assert: self inriaSerifRegularBlob length
		equals: AeFilesystemResources inriaSerifRegularTTF size
]

{ #category : #tests }
AeHbBlobTest >> testNewEmpty [

	| aBlob |
	aBlob := AeHbBlob newEmpty.

	self assert: aBlob length equals: 0.
	self assert: AeHbBlob newEmpty getHandle equals: aBlob getHandle
]

{ #category : #tests }
AeHbBlobTest >> testNewHbFaces [

	| faces |
	faces := self inriaSerifRegularBlob newHbFaces.
	
	self assert: faces size equals: 1.
	self assert: faces first class equals: AeHbFace
]

{ #category : #tests }
AeHbBlobTest >> testOpenFailure [

	self
		should: [
			AeHbBlob newLocatedAt: AeFilesystemResources inriaSerifRegularTTF / '.doesNotExist' ]
		raise: Error
		whoseDescriptionIncludes: 'Failed to open'
		description: 'Should have problems to open this file.'.

]

{ #category : #tests }
AeHbBlobTest >> testOpenSuccess [

	self deny: self inriaSerifRegularBlob isNull
]
