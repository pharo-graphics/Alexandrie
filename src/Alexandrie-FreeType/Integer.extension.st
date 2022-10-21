Extension { #name : #Integer }

{ #category : #'*Alexandrie-FreeType' }
Integer >> as26Dot6FractionalPoint [

	^ self << 6
]

{ #category : #'*Alexandrie-FreeType' }
Integer >> from26Dot6FractionalPoint [
	
	^ self / 64.0
]
