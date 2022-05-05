Extension { #name : #BlRectangleGeometry }

{ #category : #'*Alexandrie-Canvas-Core' }
BlRectangleGeometry >> aeApplyTo: aeCanvas element: aBlElement [

	aeCanvas setPathFor: self isClosed: true with: [ :cairoContext |
		| aRectangle |
		aRectangle := aBlElement boundsInLocal.
		
		cairoContext
			primRectangleX: aRectangle left
			y: aRectangle top
			width: aRectangle width
			height: aRectangle height ]

]
