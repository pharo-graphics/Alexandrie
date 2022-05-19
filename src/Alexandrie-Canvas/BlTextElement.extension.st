Extension { #name : #BlTextElement }

{ #category : #'*Alexandrie-Canvas-Core' }
BlTextElement >> aeDrawGeometryOn: aeCanvas [
	super aeDrawGeometryOn: aeCanvas.

	paragraph containerExtent: self extent.
	paragraph selection: self selection.

	aeCanvas restoreAfter: [
		aeCanvas pathTranslate: self padding topLeft.
		paragraph aeDrawOn: aeCanvas ]
]
