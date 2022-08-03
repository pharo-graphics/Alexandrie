Extension { #name : #BlSquareGeometry }

{ #category : #'*Alexandrie-Canvas' }
BlSquareGeometry >> aeApplyTo: aeCanvas element: aBlElement [

	aeCanvas
		setPathKey: self
		hasJoins: true
		hasCaps: false
		block: [ :cairoContext |
			cairoContext rectangle: aBlElement geometryBounds ]

]
