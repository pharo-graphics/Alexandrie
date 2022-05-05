Extension { #name : #BlTextElement }

{ #category : #'*Alexandrie-Canvas-Core' }
BlTextElement >> aeDrawOn: aeCanvas [
	super aeDrawOn: aeCanvas.

	paragraph containerExtent: self extent.
	paragraph selection: self selection.

	aeCanvas pathTranslate: self padding topLeft.
	paragraph aeDrawOn: aeCanvas.
	aeCanvas pathTranslate: self padding topLeft negated.

]
