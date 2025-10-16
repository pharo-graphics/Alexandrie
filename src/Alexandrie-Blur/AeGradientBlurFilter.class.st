"
I'm an abstract filter to simulate blur via gradients.
"
Class {
	#name : #AeGradientBlurFilter,
	#superclass : #Object,
	#instVars : [
		'ramp',
		'color',
		'blurRadius'
	],
	#category : #'Alexandrie-Blur'
}

{ #category : #accessing }
AeGradientBlurFilter >> blurRadius [

	^ blurRadius
]

{ #category : #initialization }
AeGradientBlurFilter >> blurRadius: aBlurRadius color: aColor [

	color := aColor.
	blurRadius := aBlurRadius.

	"The ramp defines all stops, playing with alpha channel"
	ramp := Array streamContents: [ :stream |
		self
			rampSize: blurRadius
			stopsAndAlphasDo: [ :eachStop :eachAlpha |
				stream nextPut: (eachStop -> (color alpha: eachAlpha)) ] ]
]

{ #category : #initialization }
AeGradientBlurFilter >> blurSigma: aBlurSigma color: aColor [

	self blurRadius: (aBlurSigma * 3) ceiling color: aColor
]

{ #category : #accessing }
AeGradientBlurFilter >> color [

	^ color
]

{ #category : #drawing }
AeGradientBlurFilter >> drawFragmentsOn: aContext [

	self subclassResponsibility
]

{ #category : #drawing }
AeGradientBlurFilter >> drawOn: context [

	context saveState.

	"Disable antialias to avoid unexpected seams between fragments"
	context antialias: AeCairoAntialias none.

	self drawFragmentsOn: context.
	
	context restoreState
]

{ #category : #accessing }
AeGradientBlurFilter >> ramp [

	^ ramp
]

{ #category : #initialization }
AeGradientBlurFilter >> rampFunctionAt: x [
	"Evaluate 1.0 minus a sigmoid (logistic) function, with mu and sigma determined manually by trial and error."

	^ 1.0 - (1.0 / (1.0 + (((x - 0.475) * -10.0) exp)))
]

{ #category : #initialization }
AeGradientBlurFilter >> rampSize: rampSize stopsAndAlphasDo: aBlock [

	aBlock value: 0.0 value: 1.0.

	1 to: rampSize - 2 do: [ :i |
		| stop |
		stop := i / (rampSize - 1) asFloat.
		aBlock
			value: stop
			value: (self rampFunctionAt: stop) ].

	aBlock value: 1.0 value: 0.0
]
