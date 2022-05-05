Extension { #name : #BlTextParagraphLine }

{ #category : #'*Alexandrie-Canvas-Core' }
BlTextParagraphLine >> aeDrawOn: aeCanvas [

	self spans do: [ :aSpan | aSpan aeDrawOn: aeCanvas ]
]
