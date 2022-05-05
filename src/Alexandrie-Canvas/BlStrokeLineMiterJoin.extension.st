Extension { #name : #BlStrokeLineMiterJoin }

{ #category : #'*Alexandrie-Canvas-Core' }
BlStrokeLineMiterJoin >> aeApplyTo: aeCanvas style: aBorderStyle [

	aeCanvas setJoinMiter: aBorderStyle miterLimit
]
