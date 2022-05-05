Class {
	#name : #AeMouseEventTargetTest,
	#superclass : #TestCase,
	#instVars : [
		'space'
	],
	#category : #'Alexandrie-Canvas-Tests'
}

{ #category : #tests }
AeMouseEventTargetTest >> assertMouseEventTargetAt: aPoint hasId: expectedId [

	self
		assert: (space root findMouseEventTargetAt: aPoint) id asSymbol
		equals: expectedId asSymbol
]

{ #category : #tests }
AeMouseEventTargetTest >> assertNoMouseEventTargetAt: aPoint [
	"Assert that the target at aPoint is the root, which means there are no elements there."

	self assertMouseEventTargetAt: aPoint hasId: space root id asSymbol
]

{ #category : #running }
AeMouseEventTargetTest >> setUp [
	super setUp.
	
	Bloc hasSparta: false.

]

{ #category : #running }
AeMouseEventTargetTest >> tearDown [
	
	Bloc hasSparta: true.
	super tearDown.

]

{ #category : #tests }
AeMouseEventTargetTest >> testCircles [

	space := AeSpaceFixture new spaceWithCircles.	

	self
		assertNoMouseEventTargetAt: 10 asPoint.

	self
		assertMouseEventTargetAt: 15 asPoint
		hasId: #A.

	self
		assertMouseEventTargetAt: 20 asPoint
		hasId: #B.

]

{ #category : #tests }
AeMouseEventTargetTest >> testClippingWithoutBorders [

	space := AeSpaceFixture new spaceClippingWithoutBorders.
	
	self
		assertMouseEventTargetAt: 10 asPoint
		hasId: #A.

	self
		assertMouseEventTargetAt: 15 asPoint
		hasId: #B.

	self
		assertMouseEventTargetAt: 20 asPoint
		hasId: #C. "elementA doesn't clip"

	"elementB DOES clip, then elementC is not found"
	self
		assertNoMouseEventTargetAt: 25 asPoint. 

]

{ #category : #tests }
AeMouseEventTargetTest >> testRectangles [

	space := AeSpaceFixture new spaceWithRectangles.
	
	"No element theer, only background."
	self
		assertNoMouseEventTargetAt: 9 asPoint. 

	self
		assertMouseEventTargetAt: 10 asPoint
		hasId: #A.

	self
		assertMouseEventTargetAt: 15 asPoint
		hasId: #B.

]

{ #category : #tests }
AeMouseEventTargetTest >> testTransformRotate [

	space := AeSpaceFixture new spaceWithTransformRotate.
	 
	{	 0 -> space root id.
		 5 -> #A.
		10 -> #A.
		15 -> #A.
		20 -> #A.
		25 -> #B.
		30 -> #C.
		35 -> #B.
		40 -> space root id } do: [ :each |
			self
				assertMouseEventTargetAt: each key asPoint
				hasId: each value ]

]

{ #category : #tests }
AeMouseEventTargetTest >> testTransformScale [

	space := AeSpaceFixture new spaceWithTransformScale.

	{ 	 5 -> space root id.
		10 -> #A.
		15 -> space root id.
		20 -> #B.
		25 -> #C.
		30 -> #B.
		35 -> space root id } do: [ :each |
			self
				assertMouseEventTargetAt: each key asPoint
				hasId: each value ]

]

{ #category : #tests }
AeMouseEventTargetTest >> testTransformTranslate [

	space := AeSpaceFixture new spaceWithTransformTranslate.
	
	self
		assertMouseEventTargetAt: 10 asPoint
		hasId: #A.

	self
		assertMouseEventTargetAt: 15 asPoint
		hasId: #B.

	self
		assertMouseEventTargetAt: 20 asPoint
		hasId: #C.

	self
		assertNoMouseEventTargetAt: 25 asPoint. 

]

{ #category : #tests }
AeMouseEventTargetTest >> testTriangles [

	space := AeSpaceFixture new spaceWithTriangles.

	self
		assertMouseEventTargetAt: 10 asPoint
		hasId: #A.

	self
		assertNoMouseEventTargetAt: 11@10.

	self
		assertMouseEventTargetAt: 15 asPoint
		hasId: #B.

]
