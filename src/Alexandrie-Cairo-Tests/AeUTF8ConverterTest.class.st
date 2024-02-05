Class {
	#name : 'AeUTF8ConverterTest',
	#superclass : 'TestCase',
	#instVars : [
		'converter'
	],
	#category : 'Alexandrie-Cairo-Tests',
	#package : 'Alexandrie-Cairo-Tests'
}

{ #category : 'running' }
AeUTF8ConverterTest >> setUp [

	super setUp.
	converter := AeUTF8Converter new
]

{ #category : 'tests' }
AeUTF8ConverterTest >> testConvertByteString [

	converter convert: 'aßc'.

	self assert: converter bufferLength equals: 4.
	self assert: (converter buffer first: 4) equals: #[97 195 159 99].

	converter convert: 'aßc' from: 2 to: 2.
	self assert: converter bufferLength equals: 2.
	self assert: (converter buffer first: 2) equals: #[195 159].

	converter convert: 'aßc' from: 1 to: 2.
	self assert: converter bufferLength equals: 3.
	self assert: (converter buffer first: 3) equals: #[97 195 159].

	converter convert: 'aßc' from: 2 to: 3.
	self assert: converter bufferLength equals: 3.
	self assert: (converter buffer first: 3) equals: #[195 159 99]
]

{ #category : 'tests' }
AeUTF8ConverterTest >> testConvertWideString [
	"Test encoding with a Greek delta letter.
	This one: https://en.wikipedia.org/wiki/Delta_(letter)"

	| aWideString |
	aWideString := WideString with: $a with: (Unicode value: 916) with: $c.
	
	converter convert: aWideString.
	self assert: converter bufferLength equals: 4.
	self assert: (converter buffer first: 4) equals: #[97 206 148 99].

	converter convert: aWideString from: 2 to: 2.
	self assert: converter bufferLength equals: 2.
	self assert: (converter buffer first: 2) equals: #[206 148].

	converter convert: aWideString from: 1 to: 2.
	self assert: converter bufferLength equals: 3.
	self assert: (converter buffer first: 3) equals: #[97 206 148].

	converter convert: aWideString from: 2 to: 3.
	self assert: converter bufferLength equals: 3.
	self assert: (converter buffer first: 3) equals: #[206 148 99]
]

{ #category : 'tests' }
AeUTF8ConverterTest >> testReuse [

	converter convert: 'ßa'.
	self
		assert: (converter buffer first: converter bufferLength)
		equals: #[195 159 97].

	converter convert: 'b'.
	self
		assert: (converter buffer first: converter bufferLength)
		equals: #[98]
]
