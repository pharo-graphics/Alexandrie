Extension { #name : #BlBorder }

{ #category : #'*Alexandrie-Canvas-Core' }
BlBorder >> aeApplyTo: aeCanvas [

	^ paint aeApplyTo: aeCanvas border: self
]
