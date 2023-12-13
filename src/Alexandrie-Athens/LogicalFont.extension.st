Extension { #name : #LogicalFont }

{ #category : #'*Alexandrie-Athens' }
LogicalFont >> athensAeCairoFontRendererFor: anAthensAeCairoCanvas [

	^ anAthensAeCairoCanvas fontRendererForLogicalFont: self
]
