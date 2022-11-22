"
I know where are the testing resources of this test package on the filesystem.
"
Class {
	#name : #AeFilesystemResources,
	#superclass : #Object,
	#category : #'Alexandrie-Base-Tests'
}

{ #category : #accessing }
AeFilesystemResources class >> repositoryDirectory [

	| expectedName myRepository |
	expectedName := 'alexandrie'.

	myRepository := IceRepository registry
		detect: [ :each | each name asLowercase = expectedName ]
		ifNone: [ self error: ('Did not find any repository named ''{1}'' in Iceberg (case insensitive). Alexandrie tests require it to access resources.' format: { expectedName }) ].
	
	^ myRepository location
]

{ #category : #accessing }
AeFilesystemResources class >> testsDirectory [

	^ self repositoryDirectory / 'tests'
]
