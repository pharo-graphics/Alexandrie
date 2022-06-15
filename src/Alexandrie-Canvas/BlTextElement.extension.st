Extension { #name : #BlTextElement }

{ #category : #'*Alexandrie-Canvas-Core' }
BlTextElement >> aeDrawOnlyMeOn: aeCanvas [

	super aeDrawOnlyMeOn: aeCanvas.

"	paragraph containerExtent: self extent.
	paragraph selection: self selection."

	aeCanvas restoreContextAfter: [
		aeCanvas pathTranslate: self padding topLeft.
		paragraph line spans do: [ :each |
			aeCanvas pathTranslate: each baselinePoint.
			each aeDrawOn: aeCanvas ] ]
]
