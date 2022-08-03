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

{ #category : #'*Alexandrie-Canvas-Core' }
BlPolygonGeometry >> aeContainsPoint: aPoint in: aBlElement [
	"Answer whether aPoint is contained by a this geometry."

	^ AeOffscreen instance
		  is: aPoint
		  inFillOfVertices: self vertices
]
