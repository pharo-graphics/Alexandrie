"
An AeHbBlobTest is a test class for testing the behavior of AeHbBlob
"
Class {
	#name : 'AeHbBlobTest',
	#superclass : 'TestCase',
	#category : 'Alexandrie-Harfbuzz-Tests',
	#package : 'Alexandrie-Harfbuzz-Tests'
}

{ #category : 'running' }
AeHbBlobTest >> inriaSerifRegularBlob [

	^ AeHbBlob newLocatedAt: AeFilesystemResources inriaSerifRegularTTF
]

{ #category : 'running' }
AeHbBlobTest >> sourceSansProBlob [

	^ AeHbBlob newFrom: AeSourceSansPro_Regular fontContentsData
]

{ #category : 'tests' }
AeHbBlobTest >> testAsString [

	self
		assert: self inriaSerifRegularBlob asString
		equals: 'an AeHbBlob(1 faces)'
]

{ #category : 'tests' }
AeHbBlobTest >> testFaceCount [

	self
		assert: self inriaSerifRegularBlob faceCount
		equals: 1
]

{ #category : 'tests' }
AeHbBlobTest >> testLength [

	self
		assert: self inriaSerifRegularBlob length
		equals: AeFilesystemResources inriaSerifRegularTTF size
]

{ #category : 'tests' }
AeHbBlobTest >> testNewEmpty [

	| aBlob |
	aBlob := AeHbBlob newEmpty.

	self assert: aBlob length equals: 0.
	self assert: AeHbBlob newEmpty getHandle equals: aBlob getHandle
]

{ #category : 'tests' }
AeHbBlobTest >> testNewHbFaces [

	| faces |
	faces := self inriaSerifRegularBlob newHbFaces.
	
	self assert: faces size equals: 1.
	self assert: faces first class equals: AeHbFace
]

{ #category : 'tests' }
AeHbBlobTest >> testOpenFailure [

	self
		should: [
			AeHbBlob newLocatedAt: AeFilesystemResources inriaSerifRegularTTF / '.doesNotExist' ]
		raise: Error
		whoseDescriptionIncludes: 'Harfbuzz failed to read'
		description: 'Should have problems to open this file.'.

]

{ #category : 'tests' }
AeHbBlobTest >> testOpenFromMemoryFailure [

	self
		should: [
			AeHbBlob newFrom: #[0 1 2 3] ]
		raise: Error
		whoseDescriptionIncludes: 'Harfbuzz failed to read data'
		description: 'Should have problems to open this ByteArray'.

]

{ #category : 'tests' }
AeHbBlobTest >> testOpenFromMemorySuccess [

	self assert: self sourceSansProBlob faceCount equals: 1
]

{ #category : 'tests' }
AeHbBlobTest >> testOpenSuccess [

	self deny: self inriaSerifRegularBlob isNull
]
