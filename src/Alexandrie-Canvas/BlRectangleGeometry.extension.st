Extension { #name : #BlRectangleGeometry }

{ #category : #'*Alexandrie-Canvas-Core' }
BlRectangleGeometry >> aeApplyTo: aeCanvas element: aBlElement [

	aeCanvas
		setPathKey: self
		hasJoins: true
		hasCaps: false
		block: [ :cairoContext |
			| aRectangle |
			aRectangle := aBlElement boundsInLocal.
			cairoContext rectangle: aRectangle ]

]
