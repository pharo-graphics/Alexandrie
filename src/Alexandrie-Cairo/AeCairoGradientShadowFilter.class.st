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
AeCairoGradientShadowFilter >> paintFor: rectangle blurRadius: radius color: aColor on: aContext [

	| aRect colorRamp aGradient aGradientMatrix |
	radius isZero ifTrue: [ ^ self ].

	colorRamp := self colorRampFor: aColor radius: radius.
	aGradient := 
		AeCairoRadialGradientPattern 
			innerCenter: rectangle topLeft
			innerRadius: 0.0
			outerCenter: rectangle topLeft
			outerRadius: radius
			addStopsFrom: colorRamp.
	aGradientMatrix := AeCairoMatrix newIdentity.

	"corners painting"
	aContext restoreStateAfter: [
		aContext source: aGradient.			

		" top left"
		aRect := rectangle topLeft - radius asPoint extent: radius asPoint.
		"fs's matrix has 0@0 translation, initially"
		aContext rectangle: aRect; fill.

		" top right"
		aRect := rectangle topRight rectangle: rectangle topRight + (radius @ radius negated).
		aGradientMatrix translateByX: rectangle width negated y: 0.0.
		aGradient matrix: aGradientMatrix.
		aContext rectangle: aRect; fill.

		" bottom right"
		aRect := rectangle bottomRight rectangle: rectangle bottomRight + radius.
		aGradientMatrix translateByX: 0.0 y: rectangle height negated.
		aGradient matrix: aGradientMatrix.
		aContext rectangle: aRect; fill.

		" bottom left"
		aRect := rectangle bottomLeft - (radius @ 0) extent: radius @ radius.
		aGradientMatrix translateByX: rectangle width y: 0.0.
		aGradient matrix: aGradientMatrix.
		aContext rectangle: aRect; fill.
		].	

	" borders drawing"	

	" top "
	aRect := rectangle topLeft - (0 @ radius) extent: rectangle width @ radius.
	aGradient := AeCairoLinearGradientPattern
		from: aRect bottomLeft
		to: aRect bottomLeft - (0 @ radius)
		addStopsFrom: colorRamp.
	aContext source: aGradient; rectangle: aRect; fill.

	" bottom "
	aRect := rectangle bottomLeft extent: rectangle width @ radius.
	aGradient := AeCairoLinearGradientPattern
		from: aRect topLeft
		to: aRect topLeft + (0 @ radius)
		addStopsFrom: colorRamp.
	aContext source: aGradient; rectangle: aRect; fill.

	" right "
	aRect := 0 @ 0 extent: radius @ rectangle height.
	aGradient := AeCairoLinearGradientPattern
		from: 0 @ 0
		to: radius @ 0
		addStopsFrom: colorRamp.
	aContext source: aGradient.
	aGradientMatrix := AeCairoMatrix newTranslationBy: rectangle topRight negated.
	aGradient matrix: aGradientMatrix.
	aContext restoreStateAfter: [
		aContext
			translateBy: rectangle topRight;
			rectangle: aRect;
			fill ].	

	" left "
	aRect := ((rectangle left - radius) @ rectangle top) extent: radius @ rectangle height.
	aGradientMatrix := AeCairoMatrix newIdentity.
	aGradientMatrix rotateByRadians: Float pi.
	aGradientMatrix translateBy: rectangle bottomLeft negated.
	aGradient matrix: aGradientMatrix.

	aContext
		rectangle: aRect;
		fill

]
