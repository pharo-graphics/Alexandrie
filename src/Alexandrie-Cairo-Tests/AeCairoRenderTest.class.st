Class {
	#name : #AeCairoRenderTest,
	#superclass : #AePixelMatchTest,
	#category : #'Alexandrie-Cairo-Tests'
}

{ #category : #hooks }
AeCairoRenderTest class >> allFormSelectors [

	^ self selectors select: [ :each | each beginsWith: 'surfaceWith' ]
]

{ #category : #hooks }
AeCairoRenderTest >> expectedFormsDirectory [

	^ AeFilesystemResources cairoDirectory
]

{ #category : #hooks }
AeCairoRenderTest >> formBehavior [

	^ self
]
