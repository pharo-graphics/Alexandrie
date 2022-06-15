Extension { #name : #BlTriangleGeometry }

{ #category : #'*Alexandrie-Canvas-Core' }
BlTriangleGeometry >> aeApplyTo: aeCanvas element: aBlElement [

	aeCanvas
		setPathKey: self
		hasJoins: true
		hasCaps: false
		block: [ :cairoContext |
			| thePoints |
			thePoints := self computeVertices.

			cairoContext
				moveTo: thePoints first;
				lineTo: thePoints second;
				lineTo: thePoints third;
				primClosePath ]

]

{ #category : #'*Alexandrie-Canvas-Core' }
BlTriangleGeometry >> aeContainsPoint: aPoint in: aBlElement [

	^ AeOffscreen instance
		  is: aPoint
		  inFillOfVertices: self computeVertices
]
