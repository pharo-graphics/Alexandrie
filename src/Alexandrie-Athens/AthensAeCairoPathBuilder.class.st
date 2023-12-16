Class {
	#name : #AthensAeCairoPathBuilder,
	#superclass : #AthensPathBuilder,
	#instVars : [
		'cairoContext',
		'absolute',
		'endPoint',
		'lastControlPoint'
	],
	#category : #'Alexandrie-Athens'
}

{ #category : #'instance creation' }
AthensAeCairoPathBuilder class >> on: aCairoContext [

	^ self basicNew
		initializeOn: aCairoContext;
		yourself
]

{ #category : #'path commands' }
AthensAeCairoPathBuilder >> absolute [

	absolute := true
]

{ #category : #private }
AthensAeCairoPathBuilder >> arcCenterX: xc centerY: yc radius: radius startAngle: angle1 endAngle: angle2 [

	cairoContext arcCenterX: xc centerY: yc radius: radius startAngle: angle1 endAngle: angle2
]

{ #category : #'path commands' }
AthensAeCairoPathBuilder >> close [

	cairoContext closePath
]

{ #category : #'creating path' }
AthensAeCairoPathBuilder >> createPath: aBlock [

	self relative.
	endPoint := ZeroPoint.

	cairoContext
		resetPath;
		moveToX: 0.0 y: 0.0.

	aBlock value: self.

	^ cairoContext currentPath
]

{ #category : #'path commands' }
AthensAeCairoPathBuilder >> curveVia: p1 and: p2 to: aPoint [

	| pt1 |
	pt1 := self toAbsolute: p1.
	lastControlPoint := self toAbsolute: p2.
	endPoint := self toAbsolute: aPoint.

	cairoContext
		curveViaX: pt1 x
		y: pt1 y
		viaX: lastControlPoint x
		y: lastControlPoint y
		toX: endPoint x
		y: endPoint y
]

{ #category : #'path commands' }
AthensAeCairoPathBuilder >> curveVia: p1 to: aPoint [
	"Add a quadric bezier curve starting from current path endpoint, using control point cp1,
	and ending at aPoint"


	| pt0 pt1 |
	pt0 := endPoint.
	pt1 := self toAbsolute: p1.
	endPoint := self toAbsolute: aPoint.
	lastControlPoint := nil.
	
	cairoContext quadraticCurveFrom: pt0 controlPoint: pt1 to: endPoint
]

{ #category : #'builder commands' }
AthensAeCairoPathBuilder >> hLineTo: x [

	^ self lineTo:
		(absolute
			ifTrue: [ x @ endPoint y ]
			ifFalse: [ x @ 0 ])
]

{ #category : #initialization }
AthensAeCairoPathBuilder >> initializeOn: aCairoContext [

	self initialize.
	
	cairoContext := aCairoContext
]

{ #category : #'path commands' }
AthensAeCairoPathBuilder >> lineTo: aPoint [ 

	endPoint := self toAbsolute: aPoint.
	lastControlPoint := nil.

	cairoContext lineTo: endPoint
]

{ #category : #private }
AthensAeCairoPathBuilder >> lineToX: x Y: y [
	
	cairoContext lineToX: x y: y
]

{ #category : #'path commands' }
AthensAeCairoPathBuilder >> moveTo: aPoint [ 

	endPoint := self toAbsolute: aPoint.
	lastControlPoint := nil.

	cairoContext moveTo: endPoint
]

{ #category : #drawing }
AthensAeCairoPathBuilder >> moveToX: x Y: y [

	cairoContext moveToX: x y: y
]

{ #category : #'path commands' }
AthensAeCairoPathBuilder >> relative [
	
	absolute := false
]

{ #category : #private }
AthensAeCairoPathBuilder >> toAbsolute: aPoint [

	^ absolute ifTrue: [ aPoint ] ifFalse: [ endPoint + aPoint ]
]

{ #category : #'builder commands' }
AthensAeCairoPathBuilder >> vLineTo: y [

	^ self lineTo:
		(absolute
			ifTrue: [ endPoint x @ y ]
			ifFalse: [ 0 @ y ])
]
