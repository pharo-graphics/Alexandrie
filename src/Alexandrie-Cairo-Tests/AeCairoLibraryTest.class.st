Class {
	#name : #AeCairoLibraryTest,
	#superclass : #TestCase,
	#category : #'Alexandrie-Cairo-Tests'
}

{ #category : #tests }
AeCairoLibraryTest >> testVersionString [

	self assert:
		(AeCairoLibrary uniqueInstance versionString beginsWith: '1.')
]
