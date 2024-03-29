Class {
	#name : #AeCairoRenderTest,
	#superclass : #AePixelMatchTest,
	#category : #'Alexandrie-Cairo-Tests'
}

{ #category : #hooks }
AeCairoRenderTest class >> allFormSelectors [

	^ self selectors select: [ :each | each beginsWith: 'surfaceWith' ]
]

{ #category : #testing }
AeCairoRenderTest class >> isAbstract [
		
	^ self == AeCairoRenderTest
]

{ #category : #hooks }
AeCairoRenderTest >> expectedFormsDirectory [

	^ AeFilesystemResources cairoDirectory
]
