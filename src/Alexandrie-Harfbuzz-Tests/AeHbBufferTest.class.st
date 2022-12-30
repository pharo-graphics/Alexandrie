"
An AeHarfbuffLibraryTest is a test class for testing the behavior of AeHarfbuffLibrary
"
Class {
	#name : #AeHbBufferTest,
	#superclass : #TestCase,
	#category : #'Alexandrie-Harfbuzz-Tests'
}

{ #category : #tests }
AeHbBufferTest >> testClearContents [

	| buffer |
	buffer := AeHbBuffer new
		direction: AeHbDirection leftToRight;
		script: AeHbScript latin;
		language: AeHbLanguage en;
		yourself.

	buffer addUtf8String: 'ab'.
	buffer clearContents.
	self assert: buffer length equals: 0.

]

{ #category : #tests }
AeHbBufferTest >> testMultipleAdd [

	| buffer |
	buffer := AeHbBuffer new
		direction: AeHbDirection leftToRight;
		script: AeHbScript latin;
		language: AeHbLanguage en;
		yourself.

	self assert: buffer length equals: 0.

	buffer addUtf8String: 'ab'.
	self assert: buffer length equals: 2.

	buffer addUtf8String: 'cd'.
	self assert: buffer length equals: 4.

]

{ #category : #tests }
AeHbBufferTest >> testReset [

	| buffer |
	buffer := AeHbBuffer new
		direction: AeHbDirection leftToRight;
		script: AeHbScript latin;
		language: AeHbLanguage en;
		yourself.

	buffer addUtf8String: 'ab'.
	buffer reset.
	self assert: buffer length equals: 0.

]
