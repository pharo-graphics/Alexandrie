"
I can solve some parameters used to approximate Gaussian blur.

See: https://blog.ivank.net/fastest-gaussian-blur.html
"
Class {
	#name : #AeIntegralImageSolver,
	#superclass : #Object,
	#instVars : [
		'wIdeal',
		'wl',
		'wu',
		'radl',
		'radu',
		'mIdeal',
		'm',
		'sigmaActual',
		'n',
		'sigma'
	],
	#category : #'Alexandrie-Cairo-Extra'
}

{ #category : #convenience }
AeIntegralImageSolver >> boxRadiiStream [

	^ Generator on: [ :generator |
			m timesRepeat: [
				generator yield: radl ].
			(n - m) timesRepeat: [ 
				generator yield: radu ] ]
]

{ #category : #'api - processing' }
AeIntegralImageSolver >> calculateForSigma: aSigma n: aN [

	sigma := aSigma.
	n := aN.
	
	wIdeal := (((12 * sigma squared) / n) + 1) sqrt.
	wl := wIdeal floor.
	wl even ifTrue: [ wl := wl-1 ].
	wu := wl+2.
	radl := (wl-1) / 2.
	radu := (wu-1) / 2.
	
	mIdeal :=
		((12 * sigma squared)
		- (n * wl squared)
		- (4 * n*wl)
		- (3 * n)) / ((-4*wl)-4).
	m := mIdeal rounded.
	
	(m > n or: [ m negative ]) ifTrue: [
		self error: 'calculation of m has failed' ].
	
	sigmaActual := ((m * wl squared + ((n-m) * wu squared) - n) / 12) sqrt.

]

{ #category : #accessing }
AeIntegralImageSolver >> m [

	^ m
]

{ #category : #accessing }
AeIntegralImageSolver >> mIdeal [

	^ mIdeal
]

{ #category : #printing }
AeIntegralImageSolver >> printOn: aStream [

	"Generate a string representation of the receiver based on its instance variables."

	super printOn: aStream.
	aStream
		nextPutAll: ' m: ';
		print: m.
	aStream
		nextPutAll: ' mIdeal: ';
		print: mIdeal.
	aStream
		nextPutAll: ' n: ';
		print: n.
	aStream
		nextPutAll: ' radl: ';
		print: radl.
	aStream
		nextPutAll: ' radu: ';
		print: radu.
	aStream
		nextPutAll: ' sigma: ';
		print: sigma.
	aStream
		nextPutAll: ' sigmaActual: ';
		print: sigmaActual.
	aStream
		nextPutAll: ' wIdeal: ';
		print: wIdeal.
	aStream
		nextPutAll: ' wl: ';
		print: wl.
	aStream
		nextPutAll: ' wu: ';
		print: wu
]

{ #category : #accessing }
AeIntegralImageSolver >> radl [

	^ radl
]

{ #category : #accessing }
AeIntegralImageSolver >> radu [

	^ radu
]

{ #category : #accessing }
AeIntegralImageSolver >> sigmaActual [

	^ sigmaActual
]

{ #category : #accessing }
AeIntegralImageSolver >> wIdeal [

	^ wIdeal
]

{ #category : #accessing }
AeIntegralImageSolver >> wl [

	^ wl
]

{ #category : #accessing }
AeIntegralImageSolver >> wu [

	^ wu
]
