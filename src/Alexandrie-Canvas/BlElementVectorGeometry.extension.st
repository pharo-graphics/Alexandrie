Extension { #name : #BlElementVectorGeometry }

{ #category : #'*Alexandrie-Canvas-Core' }
BlElementVectorGeometry >> aeContainsPoint: aPoint in: aBlElement [
	"Answer whether aPoint is contained by a this geometry."

	^ self subclassResponsibility
]
