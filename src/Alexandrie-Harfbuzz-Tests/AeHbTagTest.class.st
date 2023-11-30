Class {
	#name : 'AeHbTagTest',
	#superclass : 'TestCase',
	#category : 'Alexandrie-Harfbuzz-Tests',
	#package : 'Alexandrie-Harfbuzz-Tests'
}

{ #category : 'tests' }
AeHbTagTest >> testConversion [

	self assert: 'Latn' asHbTagInteger equals: 1281455214.
	self assert: 1281455214 asHbTagString equals: 'Latn'.
	
	self assert: 'Arab' asHbTagInteger asHbTagString equals: 'Arab'
]
