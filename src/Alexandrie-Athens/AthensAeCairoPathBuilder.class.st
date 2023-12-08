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

{ #category : #'path commands' }
AthensAeCairoPathBuilder >> moveTo: aPoint [ 

	endPoint := self toAbsolute: aPoint.
	lastControlPoint := nil.

	cairoContext moveTo: endPoint
]

{ #category : #'path commands' }
AthensAeCairoPathBuilder >> relative [
	
	absolute := false
]

{ #category : #private }
AthensAeCairoPathBuilder >> toAbsolute: aPoint [

	^ absolute ifTrue: [ aPoint ] ifFalse: [ endPoint + aPoint ]
]
