Extension { #name : #BlPolylineGeometry }

{ #category : #'*Alexandrie-Canvas-Core' }
BlPolylineGeometry >> aeApplyTo: aeCanvas element: aBlElement [

	aeCanvas setPathFor: self isClosed: false with: [ :cairoContext |
		self vertices do: [ :each | cairoContext lineTo: each ] ]
]
