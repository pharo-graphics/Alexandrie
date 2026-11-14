Class {
	#name : #AeCairoRenderTest,
	#superclass : #AeImageMatchTest,
	#category : #'Alexandrie-Cairo-Tests'
}

{ #category : #accessing }
AeCairoRenderTest class >> allImageSelectors [

	^ self selectors select: [ :each | each beginsWith: 'surfaceWith' ]
]

{ #category : #testing }
AeCairoRenderTest class >> isAbstract [

	^ self == AeCairoRenderTest
]

{ #category : #hooks }
AeCairoRenderTest >> expectedImagesDirectory [

	^ AeFilesystemResources cairoDirectory
]
