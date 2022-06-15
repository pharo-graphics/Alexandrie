Extension { #name : #BlPolygonGeometry }

{ #category : #'*Alexandrie-Canvas-Core' }
BlPolygonGeometry >> aeApplyTo: aeCanvas element: aBlElement [

	aeCanvas
		setPathKey: self
		hasJoins: true "probably"
		hasCaps: false
		block: [ :cairoContext | 
			self vertices do: [ :each | cairoContext lineTo: each ].
			cairoContext primClosePath ]
]
