Extension { #name : #BlColorPaint }

{ #category : #'*Alexandrie-Canvas-Core' }
BlColorPaint >> aeApplyTo: aeCanvas border: aBlBorder [ 
	
	^ aeCanvas acceptColorPaintBorder: self border: aBlBorder
]
