Class {
	#name : #AeFilesytemResources,
	#superclass : #Object,
	#category : #'Alexandrie-FreeType-Tests'
}

{ #category : #'as yet unclassified' }
AeFilesytemResources class >> fontsDirectory [

	^ self testsDirectory / 'fonts'
]

{ #category : #'as yet unclassified' }
AeFilesytemResources class >> repositoryDirectory [

	^ (IceRepository registry detect: [ :each | 
		   each name asLowercase = 'alexandrie' ]) location
]

{ #category : #'as yet unclassified' }
AeFilesytemResources class >> testsDirectory [

	^ self repositoryDirectory / 'tests'
]
