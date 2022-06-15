Extension { #name : #BlPaintBackground }

{ #category : #'*Alexandrie-Canvas-Core' }
BlPaintBackground >> aeApplyTo: aeCanvas [

	aeCanvas
		setBackgroundWith: [ aeCanvas setSourceColor: self paint color ]
		alpha: self opacity
]
