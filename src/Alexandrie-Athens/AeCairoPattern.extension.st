Extension { #name : #AeCairoPattern }

{ #category : #'*Alexandrie-Athens' }
AeCairoPattern >> asAthensPaintOn: aCanvas [

	^ self
]

{ #category : #'*Alexandrie-Athens' }
AeCairoPattern >> athensFillRectangle: aRectangle on: aCanvas [

	aCanvas rectangle: aRectangle.
	aCanvas paintTransform loadInvertedOnPattern: self.
	self loadOnCairoCanvas: aCanvas.
	aCanvas fill
]

{ #category : #'*Alexandrie-Athens' }
AeCairoPattern >> loadOnCairoCanvas: aCanvas [

	self flag: #athens. "arbitrary"
	self status isSuccess
		ifTrue:[ aCanvas cairoContext source: self ]
		ifFalse:[ aCanvas setSourceR: 1.0 g: 0.0 b: 0.0 a: 1.0 ]
]

{ #category : #'*Alexandrie-Athens' }
AeCairoPattern >> repeat [
	
	self extend: AeCairoExtendMode repeat
]
