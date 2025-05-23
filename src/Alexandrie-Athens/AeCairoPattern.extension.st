Extension { #name : #AeCairoPattern }

{ #category : #'*Alexandrie-Athens' }
AeCairoPattern >> asAthensPaintOn: aCanvas [

	^ self
]

{ #category : #'*Alexandrie-Athens' }
AeCairoPattern >> asStrokePaintOn: aCanvas [

	^ aCanvas surface createStrokePaintFor: self
]

{ #category : #'*Alexandrie-Athens' }
AeCairoPattern >> athensFillPath: aCairoPath on: aCanvas [ 

	aCanvas
		newPath;
		loadPath: aCairoPath.
	aCanvas paintTransform loadInvertedOnPattern: self.
	self loadOnCairoCanvas: aCanvas.
	aCanvas fill
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
		ifTrue:[ aCanvas cairoContext sourcePattern: self ]
		ifFalse:[ aCanvas setSourceR: 1.0 g: 0.0 b: 0.0 a: 1.0 ]
]

{ #category : #'*Alexandrie-Athens' }
AeCairoPattern >> repeat [
	
	self extend: AeCairoExtendMode repeat
]
