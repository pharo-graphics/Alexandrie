Extension { #name : #BlPolylineGeometry }

{ #category : #'*Alexandrie-Canvas-Core' }
BlPolylineGeometry >> aeApplyTo: aeCanvas element: aBlElement [

	aeCanvas
		setPathKey: self
		hasJoins: true "probably"
		hasCaps: true
		block: [ :cairoContext |
			self vertices do: [ :each | cairoContext lineTo: each ] ]

]

{ #category : #'*Alexandrie-Canvas-Core' }
BlPolylineGeometry >> aeContainsPoint: aPoint in: aBlElement [
	"Answer whether aPoint is contained by a this geometry."

	^ AeOffscreen instance
		  is: aPoint
		  inFillOfVertices: self vertices
]
