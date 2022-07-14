Extension { #name : #BlTextElement }

{ #category : #'*Alexandrie-Canvas-Core' }
BlTextElement >> aeDrawOnlyMeOn: aeCanvas [

	super aeDrawOnlyMeOn: aeCanvas.

	paragraph containerExtent: self extent.
	paragraph selection: self selection.

	"Draw selection, if any"
	paragraph
		aeDrawSelectionOn: aeCanvas
		padding: self padding.
	
	aeCanvas restoreContextAfter: [
		aeCanvas pathTranslate: self padding topLeft.

		"Draw text with attributes"
		paragraph line spans do: [ :each |
			aeCanvas pathTranslate: each baselinePoint.
			each aeDrawOn: aeCanvas ].
		].
	

]
