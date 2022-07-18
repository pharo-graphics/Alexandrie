Extension { #name : #BlTextElement }

{ #category : #'*Alexandrie-Canvas-Core' }
BlTextElement >> aeDrawBeneathOn: aeCanvas [

	"Draw highlight attributes"
	paragraph aeDrawHighlightsOn: aeCanvas.
	"Draw selection, if any"
	paragraph aeDrawSelectionOn: aeCanvas.
]

{ #category : #'*Alexandrie-Canvas-Core' }
BlTextElement >> aeDrawOnlyMeOn: aeCanvas [

	super aeDrawOnlyMeOn: aeCanvas.
	self setupParagraphBeforeDrawing.

	self aeDrawBeneathOn: aeCanvas.
	
	aeCanvas restoreContextAfter: [ 
		aeCanvas pathTranslate: self padding topLeft.
		"Draw text with attributes"
		paragraph line spans do: [ :each | 
			aeCanvas pathTranslate: each baselinePoint.
			each aeDrawOn: aeCanvas ] ]
]
