Extension { #name : #BlTransparentPaint }

{ #category : #'*Alexandrie-Canvas-Core' }
BlTransparentPaint >> aeApplyTo: aeCanvas border: aBlBorder [

	^ aeCanvas acceptTransparentPaintBorder: aBlBorder
]
