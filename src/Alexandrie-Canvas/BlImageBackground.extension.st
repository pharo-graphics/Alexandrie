Extension { #name : #BlImageBackground }

{ #category : #'*Alexandrie-Canvas-Core' }
BlImageBackground >> aeApplyTo: aeCanvas [

	aeCanvas setBackgroundWithForm: self image alpha: self opacity
]
