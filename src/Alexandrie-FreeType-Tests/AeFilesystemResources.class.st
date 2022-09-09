"
I know where are the testing resources of this test package on the filesystem.
"
Class {
	#name : #AeFilesystemResources,
	#superclass : #Object,
	#category : #'Alexandrie-FreeType-Tests'
}

{ #category : #accessing }
AeFilesystemResources class >> canvasDirectory [ 

	^ self testsDirectory / 'canvas'
]

{ #category : #accessing }
AeFilesystemResources class >> downloadedFontsDirectory [

	^ self fontsDirectory / 'downloaded'
]

{ #category : #accessing }
AeFilesystemResources class >> fontsDirectory [

	^ self testsDirectory / 'fonts'
]

{ #category : #accessing }
AeFilesystemResources class >> inriaSerifRegularTTF [

	^ self fontsDirectory / 'inria-serif' / 'InriaSerif' / 'TTF' / 'InriaSerif-Regular.ttf'
]

{ #category : #accessing }
AeFilesystemResources class >> repositoryDirectory [

	^ (IceRepository registry detect: [ :each | 
		   each name asLowercase = 'alexandrie' ]) location
]

{ #category : #accessing }
AeFilesystemResources class >> testsDirectory [

	^ self repositoryDirectory / 'tests'
]
