Class {
	#name : #AthensAeCairoStrokePaintTest,
	#superclass : #TestCase,
	#category : #'Alexandrie-Athens-Tests'
}

{ #category : #tests }
AthensAeCairoStrokePaintTest >> testCaps [

	| surface stroke |
	surface := AthensAeCairoSurface extent: 100 @ 100.
	surface drawDuring: [ :canvas |
		stroke := canvas setStrokePaint: Color black.
		stroke capButt.
		canvas drawShape: (10 @ 10 corner: 50 @ 50).
		stroke capRound.
		canvas drawShape: (10 @ 10 corner: 50 @ 50).
		stroke capSquare.
		canvas drawShape: (10 @ 10 corner: 50 @ 50) ].
	self assert: surface asForm isNotNil
]

{ #category : #tests }
AthensAeCairoStrokePaintTest >> testDashes [

	| surface stroke |
	surface := AthensAeCairoSurface extent: 100 @ 100.
	surface drawDuring: [ :canvas |
		stroke := canvas setStrokePaint: Color black.
		stroke dashes: #( 5 5 ) offset: 0.
		canvas drawShape: (10 @ 10 corner: 50 @ 50) ].
	self assert: surface asForm isNotNil
]

{ #category : #tests }
AthensAeCairoStrokePaintTest >> testJoins [

	| surface stroke |
	surface := AthensAeCairoSurface extent: 100 @ 100.
	surface drawDuring: [ :canvas |
		stroke := canvas setStrokePaint: Color black.
		stroke joinMiter.
		canvas drawShape: (10 @ 10 corner: 50 @ 50).
		stroke joinBevel.
		canvas drawShape: (10 @ 10 corner: 50 @ 50).
		stroke joinRound.
		canvas drawShape: (10 @ 10 corner: 50 @ 50) ].
	self assert: surface asForm isNotNil
]
