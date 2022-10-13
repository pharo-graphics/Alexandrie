Class {
	#name : #Ae26Dot6FractionalPointTest,
	#superclass : #TestCase,
	#category : #'Alexandrie-FreeType-Tests'
}

{ #category : #tests }
Ae26Dot6FractionalPointTest >> testFrom [

	self assert: 78976 from26Dot6FractionalPoint equals: 1234.
	self assert: 78976 from26Dot6FractionalPoint isInteger.
	



]

{ #category : #tests }
Ae26Dot6FractionalPointTest >> testTo [

	self assert: 1234 as26Dot6FractionalPoint equals: 1234 << 6.
	self assert: 1234 as26Dot6FractionalPoint isInteger.	



]
