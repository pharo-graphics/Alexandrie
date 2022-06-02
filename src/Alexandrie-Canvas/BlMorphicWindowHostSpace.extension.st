Extension { #name : #BlMorphicWindowHostSpace }

{ #category : #'*Alexandrie-Canvas' }
BlMorphicWindowHostSpace >> newBlHostRendererSurface [

	^ BlHostRendererFormSurface newForHostSpace: self
]

{ #category : #'*Alexandrie-Canvas-Core' }
BlMorphicWindowHostSpace >> renderer: aRenderer [
	
	renderer := aRenderer
]
