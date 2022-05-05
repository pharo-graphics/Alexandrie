Extension { #name : #BlElementVectorGeometry }

{ #category : #'*Alexandrie-Canvas-Core' }
BlElementVectorGeometry >> aeContainsPoint: aPoint in: aBlElement [
	"Answer whether aPoint is contained by a this geometry."

	^ self subclassResponsibility
]

{ #category : #'*Alexandrie-Canvas-Core' }
BlElementVectorGeometry >> containsPoint: aPoint in: aBlElement [
	"Note: we have to pass BlElement in order to give geometry a chance to use element properties
	as as border during the testing process"

	^ Bloc hasSparta
		ifTrue: [
			self
				containsPoint: aPoint
				in: aBlElement
				on: Bloc preferableSpartaCanvas offscreen ]
		ifFalse: [ 
			self aeContainsPoint: aPoint in: aBlElement ]
]
