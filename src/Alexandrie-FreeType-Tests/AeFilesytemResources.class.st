Class {
	#name : #AeFilesytemResources,
	#superclass : #Object,
	#category : #'Alexandrie-FreeType-Tests'
}

{ #category : #accessing }
AeFilesytemResources class >> fontsDirectory [

	^ self testsDirectory / 'fonts'
]

{ #category : #accessing }
AeFilesytemResources class >> repositoryDirectory [

	^ (IceRepository registry detect: [ :each | 
		   each name asLowercase = 'alexandrie' ]) location
]

{ #category : #accessing }
AeFilesytemResources class >> testsDirectory [

	^ self repositoryDirectory / 'tests'
]
