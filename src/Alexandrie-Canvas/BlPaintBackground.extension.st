Extension { #name : #BlPaintBackground }

{ #category : #'*Alexandrie-Canvas-Core' }
BlPaintBackground >> aeApplyTo: aeCanvas [

	^ aeCanvas acceptBlPaintBackground: self
]
