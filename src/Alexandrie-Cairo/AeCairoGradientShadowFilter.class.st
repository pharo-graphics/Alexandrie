Class {
	#name : #AeCairoGradientShadowFilter,
	#superclass : #Object,
	#category : #'Alexandrie-Cairo-Extra'
}

{ #category : #private }
AeCairoGradientShadowFilter >> bellFunctionAt: x a: a b: b c: c [
	"The parameter a is the height of the curve's peak, b is the position of the center of the peak, and c (the standard deviation, sometimes called the Gaussian RMS width) controls the width of the 'bell'.
	See: https://en.wikipedia.org/wiki/Gaussian_function"

	^ a * (((x - b) squared / (2.0 * c squared) ) negated) exp
]

{ #category : #private }
AeCairoGradientShadowFilter >> colorRampFor: aColor radius: aRadius [

	| guide |
	self flag: #todo. "Review this 3.0 coefficient"
	guide := (1 to: aRadius) collect: [ :each |
		self bellFunctionAt: each a: 1.0 b: 1 c: aRadius / 3.0 ].

	^ guide withIndexCollect: [ :each :index |
		(index / guide size) -> (aColor alpha: aColor alpha * each) ]

]

{ #category : #'API - painting' }
AeCairoGradientShadowFilter >> paintFor: shape blurRadius: radius color: aColor on: aContext [

	| aRect colorRamp aGradient aGradientMatrix |
	radius isZero ifTrue: [ ^ self ].

	colorRamp := self colorRampFor: aColor radius: radius.
	aGradient := 
		AeCairoRadialGradientPattern 
			innerCenter: shape topLeft
			innerRadius: 0.0
			outerCenter: shape topLeft
			outerRadius: radius
			addStopsFrom: colorRamp.
	aGradientMatrix := AeCairoMatrix newIdentity.

	"corners painting"
	aContext restoreStateAfter: [
		aContext source: aGradient.			

		" top left"
		aRect := shape topLeft - radius asPoint extent: radius asPoint.
		"fs's matrix has 0@0 translation, initially"
		aContext rectangle: aRect; fill.

		" top right"
		aRect := shape topRight rectangle: shape topRight + (radius @ radius negated).
		aGradientMatrix translateByX: shape width negated y: 0.0.
		aGradient matrix: aGradientMatrix.
		aContext rectangle: aRect; fill.

		" bottom right"
		aRect := shape bottomRight rectangle: shape bottomRight + radius.
		aGradientMatrix translateByX: 0.0 y: shape height negated.
		aGradient matrix: aGradientMatrix.
		aContext rectangle: aRect; fill.

		" bottom left"
		aRect := shape bottomLeft - (radius @ 0) extent: radius @ radius.
		aGradientMatrix translateByX: shape width y: 0.0.
		aGradient matrix: aGradientMatrix.
		aContext rectangle: aRect; fill.
		].	

	" borders drawing"	

	" top "
	aRect := shape topLeft - (0 @ radius) extent: shape width @ radius.
	aGradient := AeCairoLinearGradientPattern
		from: aRect bottomLeft
		to: aRect bottomLeft - (0 @ radius)
		addStopsFrom: colorRamp.
	aContext source: aGradient; rectangle: aRect; fill.

	" bottom "
	aRect := shape bottomLeft extent: shape width @ radius.
	aGradient := AeCairoLinearGradientPattern
		from: aRect topLeft
		to: aRect topLeft + (0 @ radius)
		addStopsFrom: colorRamp.
	aContext source: aGradient; rectangle: aRect; fill.

	" right "
	aRect := 0 @ 0 extent: radius @ shape height.
	aGradient := AeCairoLinearGradientPattern
		from: 0 @ 0
		to: radius @ 0
		addStopsFrom: colorRamp.
	aContext source: aGradient.
	aGradientMatrix := AeCairoMatrix newTranslationBy: shape topRight negated.
	aGradient matrix: aGradientMatrix.
	aContext restoreStateAfter: [
		aContext
			translateBy: shape topRight;
			rectangle: aRect;
			fill ].	

	" left "
	aRect := ((shape left - radius) @ shape top) extent: radius @ shape height.
	aGradientMatrix := AeCairoMatrix newIdentity.
	aGradientMatrix rotateByRadians: Float pi.
	aGradientMatrix translateBy: shape bottomLeft negated.
	aGradient matrix: aGradientMatrix.

	aContext
		rectangle: aRect;
		fill

]
