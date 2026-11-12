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
AthensAeCairoPathBuilder >> angleOfVector: v [

	| n acos |
	n := v normalized.
	acos := self arcCos: n x.
	^ v y < 0
		ifTrue: [ Float pi * 2 - acos ]
		ifFalse: [ acos ]
]

{ #category : #private }
AthensAeCairoPathBuilder >> arcCenterX: xc centerY: yc radius: radius startAngle: angle1 endAngle: angle2 [

	cairoContext arcCenterX: xc centerY: yc radius: radius startAngle: angle1 endAngle: angle2
]

{ #category : #private }
AthensAeCairoPathBuilder >> arcCos: aNumber [

	| clampedNumber |
	clampedNumber := aNumber.
	aNumber < -1.0 ifTrue: [ clampedNumber := -1.0 ].
	aNumber > 1.0 ifTrue: [ clampedNumber := 1.0 ].
	^ clampedNumber arcCos
]

{ #category : #private }
AthensAeCairoPathBuilder >> arcDegreeStart: aStartAngle sweep: aSweepAngle centerX: anX y: aY radius: aRadius [

	^ self
		arcRadianStart: aStartAngle degreesToRadians
		sweep: aSweepAngle degreesToRadians
		centerX: anX
		y: aY
		radius: aRadius
]

{ #category : #private }
AthensAeCairoPathBuilder >> arcNegativeCenterX: xc centerY: yc radius: radius startAngle: angle1 endAngle: angle2 [

	cairoContext
		arcNegativeCenterX: xc
		centerY: yc
		radius: radius
		startAngle: angle1
		endAngle: angle2
]

{ #category : #private }
AthensAeCairoPathBuilder >> arcRadianStart: aStartAngle sweep: aSweepAngle centerX: anX y: aY radius: aRadius [

	| endAngle |
	endAngle := aStartAngle + aSweepAngle.
	aSweepAngle positive
		ifTrue: [
			self
				arcCenterX: anX
				centerY: aY
				radius: aRadius
				startAngle: aStartAngle
				endAngle: endAngle ]
		ifFalse: [
			self
				arcNegativeCenterX: anX
				centerY: aY
				radius: aRadius
				startAngle: aStartAngle
				endAngle: endAngle ]
]

{ #category : #'path commands' }
AthensAeCairoPathBuilder >> arcTo: newEndPoint angle: anAngle cw: aBoolean [
	"Add an arc segment starting from current path endpoint and ending at newEndPoint."

	| start end center v radius startAngle endAngle cwAngle |
	lastControlPoint := nil.
	anAngle isZero ifTrue: [ ^ self lineTo: newEndPoint ].
	start := endPoint.
	endPoint := end := self toAbsolute: newEndPoint.
	start = end ifTrue: [ ^ self ].

	cwAngle := aBoolean
		ifTrue: [ anAngle ]
		ifFalse: [ anAngle negated ].
	center := self calcCenter: start end: end angle: cwAngle.
	v := start - center.
	radius := v r.
	startAngle := self angleOfVector: v.
	endAngle := self angleOfVector: end - center.

	aBoolean
		ifTrue: [
			self
				arcCenterX: center x
				centerY: center y
				radius: radius
				startAngle: startAngle
				endAngle: endAngle ]
		ifFalse: [
			self
				arcNegativeCenterX: center x
				centerY: center y
				radius: radius
				startAngle: startAngle
				endAngle: endAngle ]
]

{ #category : #private }
AthensAeCairoPathBuilder >> calcCenter: startPoint end: targetEndPoint angle: anAngle [

	| v center radius length transform |
	v := targetEndPoint - startPoint.
	transform := AthensAffineTransform new rotateByRadians: Float pi - anAngle / 2.
	v := transform transform: v.
	length := v r.
	radius := length / 2 / (anAngle / 2) sin.
	center := v * (radius / length) + startPoint.
	^ center
]

{ #category : #'path commands' }
AthensAeCairoPathBuilder >> ccwArcTo: newEndPoint angle: angle [
	"Add a counter-clockwise arc segment, starting from current path endpoint and ending at newEndPoint."

	^ self arcTo: newEndPoint angle: angle cw: false
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

	^ AthensAeCairoPath on: cairoContext currentPath
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
	
	cairoContext quadraticCurveFromCurrentPoint: pt0 via: pt1 to: endPoint
]

{ #category : #'path commands' }
AthensAeCairoPathBuilder >> cwArcTo: newEndPoint angle: angle [
	"Add a clockwise arc segment, starting from current path endpoint and ending at newEndPoint."

	^ self arcTo: newEndPoint angle: angle cw: true
]

{ #category : #'path commands' }
AthensAeCairoPathBuilder >> ellipticalArc: radii xrot: xAxisRotation large: largeArcFlag sweep: sweepFlag to: theEndPoint [

	^ self
		ellipticalArc: radii
		xrot: xAxisRotation
		large: largeArcFlag
		sweep: sweepFlag
		to: theEndPoint
		relative: false
]

{ #category : #'path commands' }
AthensAeCairoPathBuilder >> ellipticalArc: radii xrot: xAxisRotation large: largeArcFlag sweep: sweepFlag to: theEndPoint relative: isRelative [

	| rx ry x1 y1 x2 y2 dx2 dy2 arx ary coeff cx1 cy1 ux uy vx vy sign xPrime1 yPrime1 radical startAngle sweepAngle cx cy aPoint lFlag swFlag aCenter uySign |
	aPoint := isRelative
		ifTrue: [ 0.0 @ 0.0 ]
		ifFalse: [ endPoint ].
	lFlag := false.
	swFlag := sweepFlag = 1.0.
	rx := radii x.
	ry := radii y.
	x1 := aPoint x.
	y1 := aPoint y.
	x2 := theEndPoint x.
	y2 := theEndPoint y.
	dx2 := x1 - x2 / 2.
	dy2 := y1 - y2 / 2.
	xPrime1 := dx2.
	yPrime1 := dy2.
	arx := rx abs.
	ary := ry abs.

	radical := arx squared * ary squared - (arx squared * yPrime1 squared) - (ary squared * xPrime1 squared)
		/ (arx squared * yPrime1 squared + (ary squared * xPrime1 squared)).
	radical abs <= 1.0e-4 ifTrue: [ radical := 0.0 ].
	coeff := radical abs sqrt.
	sweepFlag == largeArcFlag ifTrue: [ coeff := coeff negated ].
	cx1 := coeff * yPrime1.
	cy1 := coeff negated * xPrime1.

	cx := cx1 + (x1 + x2 / 2).
	cy := cy1 + (y1 + y2 / 2).

	ux := xPrime1 - cx1 / arx.
	uy := yPrime1 - cy1 / ary.
	vx := xPrime1 negated - cx1 / arx.
	vy := yPrime1 negated - cy1 / ary.
	sign := ux * vy - (uy * vx) <= 0
		ifTrue: [ -1 ]
		ifFalse: [ 1 ].
	uySign := uy = 0
		ifTrue: [ 1 ]
		ifFalse: [ uy sign ].
	startAngle := ((ux / (ux squared + uy squared) sqrt) arcCos * uySign) radiansToDegrees \\ 360.
	sweepAngle := ((ux * vx + (uy * vy) / (ux squared + uy squared * (vx squared + vy squared)) abs sqrt) asFloat arcCos * sign)
		radiansToDegrees \\ 360.
	(sweepAngle abs < 180 and: [ lFlag ]) ifTrue: [
		sweepAngle := sweepAngle < 0
			ifTrue: [ 360 + sweepAngle ]
			ifFalse: [ sweepAngle - 360 ] ].
	sweepAngle := swFlag
		ifTrue: [
			sweepAngle < 0
				ifTrue: [ sweepAngle + 360 ]
				ifFalse: [ sweepAngle ] ]
		ifFalse: [
			sweepAngle > 0
				ifTrue: [ sweepAngle - 360 ]
				ifFalse: [ sweepAngle ] ].
	aCenter := isRelative
		ifTrue: [ endPoint + (cx @ cy) ]
		ifFalse: [ cx @ cy ].
	self
		arcDegreeStart: startAngle
		sweep: sweepAngle
		centerX: aCenter x
		y: aCenter y
		radius: rx abs.
	endPoint := self toAbsolute: theEndPoint
]

{ #category : #accessing }
AthensAeCairoPathBuilder >> getCurrentPoint [

	^ cairoContext currentPointInUserSpace
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
AthensAeCairoPathBuilder >> reflectedCurveVia: p2 to: aPoint [
	"Add a reflected cubic bezier curve, starting from current path endpoint and ending at aPoint."

	| pt1 |
	pt1 := lastControlPoint ifNil: [ endPoint ] ifNotNil: [ endPoint * 2 - lastControlPoint ].
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
