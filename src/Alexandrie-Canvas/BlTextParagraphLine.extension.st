Extension { #name : #BlTextParagraphLine }

{ #category : #'*Alexandrie-Canvas' }
BlTextParagraphLine >> aeDrawOn: aeCanvas [

	self spans do: [ :aSpan | 
		aeCanvas pathTranslate: aSpan baseline.
		aSpan aeDrawOn: aeCanvas ]
]
