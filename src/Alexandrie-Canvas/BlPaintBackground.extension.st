Extension { #name : #BlPaintBackground }

{ #category : #'*Alexandrie-Canvas-Core' }
BlPaintBackground >> aeApplyTo: aeCanvas [

	self paint aeApplyTo: aeCanvas opacity: self opacity
]
