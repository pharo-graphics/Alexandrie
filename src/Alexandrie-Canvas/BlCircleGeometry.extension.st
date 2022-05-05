Extension { #name : #BlCircleGeometry }

{ #category : #'*Alexandrie-Canvas-Core' }
BlCircleGeometry >> aeApplyTo: aeCanvas element: aBlElement [

	aeCanvas setPathFor: self isClosed: true with: [ :cairoContext | 
		cairoContext
			primArcCenterX: self origin x + self radius
			centerY: self origin y + self radius
			radius: self radius
			startAngle: 0.0
			endAngle: Float twoPi ]
]
