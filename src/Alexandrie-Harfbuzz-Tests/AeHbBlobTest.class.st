"
An AeHbBlobTest is a test class for testing the behavior of AeHbBlob
"
Class {
	#name : #AeHbBlobTest,
	#superclass : #TestCase,
	#category : #'Alexandrie-Harfbuzz-Tests'
}

{ #category : #tests }
AeHbBlobTest >> testLength [

	| aBlob |
	aBlob := AeHbBlob newLocatedAt: AeFilesystemResources inriaSerifRegularTTF.

	self
		assert: aBlob length
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

	self
		shouldnt: [
			AeHbBlob newLocatedAt: AeFilesystemResources inriaSerifRegularTTF ]
		raise: Error
]
