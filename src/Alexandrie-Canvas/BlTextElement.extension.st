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

	paragraph ifNil: [^self].
	self setupParagraphBeforeDrawing.
	self aeDrawBeneathOn: aeCanvas.

	super aeDrawOnlyMeOn: aeCanvas.

	aeCanvas restoreContextAfter: [ 
		aeCanvas pathTranslate: self padding topLeft.
		"Draw text with attributes"
		paragraph aeDrawOn: aeCanvas ]
]
