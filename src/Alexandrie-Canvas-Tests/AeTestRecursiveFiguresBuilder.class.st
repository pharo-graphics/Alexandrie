"
I build instances of `AeCanvas` with nested figures on it.

Browse my accessing protocol for drawing variants.

For drawing the canvas, depth 4 works good, but depth 2 is enough to show drawing glitches.
"
Class {
	#name : #AeTestRecursiveFiguresBuilder,
	#superclass : #Object,
	#instVars : [
		'referenceExtent',
		'backgroundAlpha',
		'hasBorder',
		'borderColor',
		'outskirtsSelector',
		'borderCapSelector',
		'borderJoinSelector'
	],
	#category : #'Alexandrie-Canvas-Tests-Base'
}

{ #category : #accessing }
AeTestRecursiveFiguresBuilder >> backgroundAlpha: anObject [

	backgroundAlpha := anObject
]

{ #category : #accessing }
AeTestRecursiveFiguresBuilder >> borderCapSelector: anObject [

	borderCapSelector := anObject
]

{ #category : #accessing }
AeTestRecursiveFiguresBuilder >> borderColor: anObject [

	borderColor := anObject
]

{ #category : #accessing }
AeTestRecursiveFiguresBuilder >> borderJoinSelector: anObject [

	borderJoinSelector := anObject
]

{ #category : #private }
AeTestRecursiveFiguresBuilder >> drawRecursiveFigureOf: depth on: aeCanvas [

	aeCanvas restoreContextAfter: [

		aeCanvas
			pathTranslate: referenceExtent / -10;
			pathScale: 0.75 asPoint.

		aeCanvas pathFactory: [ :cairoContext |
			cairoContext circleRadius: referenceExtent x / 2 ].

		aeCanvas
			setBackgroundWith: [
				aeCanvas setSourceColor: 
					(depth odd
						ifTrue: [ Color green ]
						ifFalse: [ Color red ]) ]
			alpha: backgroundAlpha.

		hasBorder
			ifTrue: [ 
				aeCanvas setBorderBlock: [
					aeCanvas
						setSourceColor: Color black;
						perform: borderCapSelector;
						perform: borderJoinSelector;
						setBorderWidth: referenceExtent x / 10 ].
				aeCanvas perform: outskirtsSelector ]
			ifFalse: [ aeCanvas setBorderOff ].

		aeCanvas drawFigureAndPrepareToClip: depth odd.
		
		"Note the recursion -if it occurs- is done before restoring the
		drawing context (this is important for the clipping area)"
		depth > 0 ifTrue: [
			self drawRecursiveFigureOf: depth - 1 on: aeCanvas ] ]
]

{ #category : #accessing }
AeTestRecursiveFiguresBuilder >> hasBorder: aBoolean [

	hasBorder := aBoolean
]

{ #category : #initialization }
AeTestRecursiveFiguresBuilder >> initialize [

	super initialize.

	referenceExtent := 50 asPoint.

	hasBorder := true.
	outskirtsSelector := #setOutskirtsCentered.
	backgroundAlpha := 0.7.
	borderCapSelector := #setCapButt.
	borderJoinSelector:= #setJoinRound
]

{ #category : #building }
AeTestRecursiveFiguresBuilder >> newCanvas [
	"It works well with depth 4 but depth 2 is enough to show drawing glitches."

	^ self newCanvasOf: 2
]

{ #category : #building }
AeTestRecursiveFiguresBuilder >> newCanvasOf: depth [

	| aeCanvas |

	"Set up canvas"
	aeCanvas := AeCanvas extent: referenceExtent.
	aeCanvas clear: Color yellow.
	aeCanvas pathTranslate: referenceExtent / 4.
	
	self drawRecursiveFigureOf: depth on: aeCanvas.
	
	^ aeCanvas
]

{ #category : #accessing }
AeTestRecursiveFiguresBuilder >> outskirtsSelector: anObject [

	outskirtsSelector := anObject
]

{ #category : #accessing }
AeTestRecursiveFiguresBuilder >> referenceExtent: anObject [

	referenceExtent := anObject
]
