Extension { #name : #BlPolygonGeometry }

{ #category : #'*Alexandrie-Canvas-Core' }
BlPolygonGeometry >> aeApplyTo: aeCanvas element: aBlElement [

	aeCanvas setPathFor: self isClosed: true with: [ :cairoContext |
		self vertices do: [ :each | cairoContext lineTo: each ].
		cairoContext primClosePath ]
]
