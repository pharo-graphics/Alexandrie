Extension { #name : #BlTextParagraph }

{ #category : #'*Alexandrie-Canvas-Core' }
BlTextParagraph >> aeDrawOn: aeCanvas [

	line spans do: [ :aSpan | aSpan aeDrawOn: aeCanvas ]
]
