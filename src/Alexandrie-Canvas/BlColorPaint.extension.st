Extension { #name : #BlColorPaint }

{ #category : #'*Alexandrie-Canvas-Core' }
BlColorPaint >> aeApplyTo: aeCanvas [
	
	aeCanvas setSourceColor: self color

]

{ #category : #'*Alexandrie-Canvas' }
BlColorPaint >> aeApplyTo: aeCanvas opacity: backgroundOpacity [

	self flag: #todo. "AeCanvas takes decisions based on alpha. Keep?"
	aeCanvas
		setBackgroundWith: [ aeCanvas setSourceSolidColor: color ]
		alpha: backgroundOpacity * color alpha
]
