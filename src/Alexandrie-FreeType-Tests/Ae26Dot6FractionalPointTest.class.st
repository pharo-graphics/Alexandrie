Class {
	#name : #Ae26Dot6FractionalPointTest,
	#superclass : #TestCase,
	#category : #'Alexandrie-FreeType-Tests-FFI'
}

{ #category : #tests }
Ae26Dot6FractionalPointTest >> testOnFloat [

	self
		assert: 1234.56 as26Dot6FractionalPoint
		equals: 79011. 
	self
		assert: 79011 from26Dot6FractionalPoint
		equals: 1234.546875
]

{ #category : #tests }
Ae26Dot6FractionalPointTest >> testOnInteger [

	self assert: 1234 as26Dot6FractionalPoint equals: 1234 << 6.
	self assert: (1234 << 6) from26Dot6FractionalPoint equals: 1234.0.

]
