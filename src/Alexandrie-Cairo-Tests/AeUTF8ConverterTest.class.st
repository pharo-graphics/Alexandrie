Class {
	#name : #AeUTF8ConverterTest,
	#superclass : #TestCase,
	#instVars : [
		'converter'
	],
	#category : #'Alexandrie-Cairo-Tests'
}

{ #category : #running }
AeUTF8ConverterTest >> setUp [

	super setUp.
	converter := AeUTF8Converter new
]

{ #category : #tests }
AeUTF8ConverterTest >> testConvertByteString [

	converter convert: 'aßc'.

	self assert: converter bufferLength equals: 4.
	self assert: (converter buffer first: 4) equals: #[97 195 159 99]
]

{ #category : #tests }
AeUTF8ConverterTest >> testConvertWideString [
	"Test encoding with a Greek delta letter.
	This one: https://en.wikipedia.org/wiki/Delta_(letter)"
	
	converter convert: (WideString with: (Unicode value: 916)).

	self assert: converter bufferLength equals: 2.
	self assert: (converter buffer first: 2) equals: #[206 148]
]

{ #category : #tests }
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
