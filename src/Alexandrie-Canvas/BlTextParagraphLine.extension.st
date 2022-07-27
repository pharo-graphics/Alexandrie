Extension { #name : #BlTextParagraphLine }

{ #category : #'*Alexandrie-Canvas' }
BlTextParagraphLine >> aeDrawOn: aeCanvas [

	self spans do: [ :aSpan | aSpan aeDrawOn: aeCanvas ]
]
