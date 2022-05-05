Class {
	#name : #AeSpaceBuilder,
	#superclass : #Object,
	#instVars : [
		'space',
		'random',
		'spaceExtent',
		'host',
		'alphabetGenerator'
	],
	#category : #'Alexandrie-Canvas-Tests'
}

{ #category : #convenience }
AeSpaceBuilder class >> newSpaceWith: aUnaryBlockClosure [

	^ self new newSpaceWith: aUnaryBlockClosure
]

{ #category : #'adding elements' }
AeSpaceBuilder >> addCircle [

	^ self addToRoot
		geometry: BlCircleGeometry new;
		yourself
]

{ #category : #'adding elements' }
AeSpaceBuilder >> addHexagonalPolygon [
	"Answer an hexagon polygon."

	| hexagonVertices |
	hexagonVertices := { 
		 60 @  0.
		 20 @  0.
		  0 @ 36.
		 20 @ 70.
		 60 @ 70.
		 80 @ 36 }.
		
	^ self addToRoot
		geometry: (BlPolygon vertices: hexagonVertices);
		yourself
]

{ #category : #'adding elements' }
AeSpaceBuilder >> addPolyline [
	"Answer a simple polyline of 3 vertices. Polylines are open, then don't look good with other outskirts than centered."

	^ self addToRoot
		background: Color transparent;
		geometry: (BlPolyline vertices: { 20@4. 0@0. 4@20 });
		outskirts: BlOutskirts centered;	
		yourself
]

{ #category : #'adding elements' }
AeSpaceBuilder >> addRectangle [

	^ self addToRoot
		geometry: BlRectangleGeometry new;
		yourself
]

{ #category : #'adding elements' }
AeSpaceBuilder >> addText: aBlRopedText to: parentElement [

	| anElement |
	anElement := BlTextElement new
		text: aBlRopedText;
		id: alphabetGenerator next;
		background: self nextColor;
		yourself.
	parentElement addChild: anElement.
	^ anElement

]

{ #category : #'adding elements' }
AeSpaceBuilder >> addTextToRoot: aBlRopedText [

	^ self addText: aBlRopedText to: space root
]

{ #category : #'adding elements' }
AeSpaceBuilder >> addTo: parentElement [

	| anElement |
	anElement := BlElement new
		id: alphabetGenerator next;
		background: self nextColor;
		yourself.
	parentElement addChild: anElement.
	^ anElement

]

{ #category : #'adding elements' }
AeSpaceBuilder >> addToRoot [

	^ self addTo: space root
]

{ #category : #'adding elements' }
AeSpaceBuilder >> addTriangle [

	^ self addToRoot
		geometry: BlTriangleGeometry new;
		yourself
]

{ #category : #building }
AeSpaceBuilder >> buildSpace [
	"Make last set up before user can use the space."

	space
		host: host;
		extent: spaceExtent.

	"Hacky way to prepare stuff without showing the space:"
	space root
		size: spaceExtent;
		forceLayout.
]

{ #category : #initialization }
AeSpaceBuilder >> initialize [

	super initialize.
	
	space := BlSpace new.
	spaceExtent := 100 asPoint.
	host := BlMorphicWindowHost new.

	random := Random seed: 7.
	alphabetGenerator := Generator on: [ :generator |
		| index |
		index := 1.
		[ 	Character alphabet do: [ :each |
				| next suffix |
				next := each asUppercase asString.
				suffix := index = 1
					ifTrue: [ '' ]
					ifFalse: [ index asString ].
				generator yield: next, suffix ].
			index := index + 1 ] repeat ].

]

{ #category : #'instance creation' }
AeSpaceBuilder >> newSpaceWith: aUnaryBlockClosure [

	aUnaryBlockClosure value: self.
	^ self
		  buildSpace;
		  space
]

{ #category : #accessing }
AeSpaceBuilder >> nextColor [

	^ Color random: random
]

{ #category : #accessing }
AeSpaceBuilder >> space [

	^ space
]

{ #category : #accessing }
AeSpaceBuilder >> spaceExtent [

	^ spaceExtent
]

{ #category : #accessing }
AeSpaceBuilder >> spaceExtent: aPoint [

	spaceExtent := aPoint
]