Class {
	#name : #BATextElementHostMeasurer,
	#superclass : #BlTextElementMeasurer,
	#category : #'Alexandrie-Canvas-Text'
}

{ #category : #'host space - rendering' }
BATextElementHostMeasurer >> measureTextParagraph: aBlTextParagraph of: aTextElement [

	aTextElement isAttachedToSceneGraph
		ifTrue: [
			aTextElement space
				measureTextParagraph: aBlTextParagraph
				ifNotAvailable: [ self notYetImplemented ] ]
		ifFalse: [ self notYetImplemented ]
]
