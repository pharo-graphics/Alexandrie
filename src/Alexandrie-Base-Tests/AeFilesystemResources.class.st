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

	"DEBUG CI:"
	IceRepository registry do: [ :each | Stdio stdout << each name ] separatedBy: [ Stdio stdout lf; flush ].

	^ (IceRepository registry detect: [ :each | 
		   each name asLowercase = 'alexandrie' ]) location
]

{ #category : #accessing }
AeFilesystemResources class >> testsDirectory [

	^ self repositoryDirectory / 'tests'
]
