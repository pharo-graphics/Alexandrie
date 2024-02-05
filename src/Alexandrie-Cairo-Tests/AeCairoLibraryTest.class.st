Class {
	#name : 'AeCairoLibraryTest',
	#superclass : 'TestCase',
	#category : 'Alexandrie-Cairo-Tests',
	#package : 'Alexandrie-Cairo-Tests'
}

{ #category : 'tests' }
AeCairoLibraryTest >> testVersionString [

	self
		assert: AeCairoLibrary uniqueInstance versionString
		equals: '1.17.4'
]
