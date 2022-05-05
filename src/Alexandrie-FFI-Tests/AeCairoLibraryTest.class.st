Class {
	#name : #AeCairoLibraryTest,
	#superclass : #TestCase,
	#category : #'Alexandrie-FFI-Tests'
}

{ #category : #tests }
AeCairoLibraryTest >> testVersionString [

	self assert:
		(AeCairoLibrary uniqueInstance versionString beginsWith: '1.')
]
