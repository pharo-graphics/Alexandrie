Class {
	#name : #AthensAeCairoPaintMode,
	#superclass : #AthensPaintMode,
	#instVars : [
		'cairoContext'
	],
	#category : #'Alexandrie-Athens'
}

{ #category : #'instance creation' }
AthensAeCairoPaintMode class >> on: aCairoContext [

	^ self basicNew
		initializeOn: aCairoContext;
		yourself
]

{ #category : #modes }
AthensAeCairoPaintMode >> add [

	cairoContext operator: AeCairoOperator add
]

{ #category : #modes }
AthensAeCairoPaintMode >> atop [

	cairoContext operator: AeCairoOperator atop
]

{ #category : #modes }
AthensAeCairoPaintMode >> availableModes [

	^ #(
		#over #source #clear #dest #destOver #in #destIn #out #destOut #atop #destAtop #xor #add #saturate #multiply #screen #overlay
		#darken #lighten #colorDodge #colorBurn #hardLight #softLight #difference #exclusion #hslHue #hslSaturation #hslColor
		#hslLuminosity )
]

{ #category : #modes }
AthensAeCairoPaintMode >> clear [

	cairoContext operator: AeCairoOperator clear
]

{ #category : #modes }
AthensAeCairoPaintMode >> colorBurn [

	cairoContext operator: AeCairoOperator colorBurn
]

{ #category : #modes }
AthensAeCairoPaintMode >> colorDodge [

	cairoContext operator: AeCairoOperator colorDodge
]

{ #category : #modes }
AthensAeCairoPaintMode >> darken [

	cairoContext operator: AeCairoOperator darken
]

{ #category : #modes }
AthensAeCairoPaintMode >> default [

	self over
]

{ #category : #modes }
AthensAeCairoPaintMode >> dest [

	cairoContext operator: AeCairoOperator dest
]

{ #category : #modes }
AthensAeCairoPaintMode >> destAtop [

	cairoContext operator: AeCairoOperator destAtop
]

{ #category : #modes }
AthensAeCairoPaintMode >> destIn [

	cairoContext operator: AeCairoOperator destIn
]

{ #category : #modes }
AthensAeCairoPaintMode >> destOut [

	cairoContext operator: AeCairoOperator destOut
]

{ #category : #modes }
AthensAeCairoPaintMode >> destOver [

	cairoContext operator: AeCairoOperator destOver
]

{ #category : #modes }
AthensAeCairoPaintMode >> difference [

	cairoContext operator: AeCairoOperator difference
]

{ #category : #modes }
AthensAeCairoPaintMode >> exclusion [

	cairoContext operator: AeCairoOperator exclusion
]

{ #category : #modes }
AthensAeCairoPaintMode >> hardLight [

	cairoContext operator: AeCairoOperator hardLight
]

{ #category : #modes }
AthensAeCairoPaintMode >> hslColor [

	cairoContext operator: AeCairoOperator hslColor
]

{ #category : #modes }
AthensAeCairoPaintMode >> hslHue [

	cairoContext operator: AeCairoOperator hslHue
]

{ #category : #modes }
AthensAeCairoPaintMode >> hslLuminosity [

	cairoContext operator: AeCairoOperator hslLuminosity
]

{ #category : #modes }
AthensAeCairoPaintMode >> hslSaturation [

	cairoContext operator: AeCairoOperator hslSaturation
]

{ #category : #modes }
AthensAeCairoPaintMode >> in [

	cairoContext operator: AeCairoOperator in
]

{ #category : #initialization }
AthensAeCairoPaintMode >> initializeOn: aCairoContext [

	self initialize.
	
	cairoContext := aCairoContext
]

{ #category : #modes }
AthensAeCairoPaintMode >> lighten [

	cairoContext operator: AeCairoOperator lighten
]

{ #category : #modes }
AthensAeCairoPaintMode >> multiply [

	cairoContext operator: AeCairoOperator multiply
]

{ #category : #modes }
AthensAeCairoPaintMode >> out [

	cairoContext operator: AeCairoOperator out
]

{ #category : #modes }
AthensAeCairoPaintMode >> over [

	cairoContext operator: AeCairoOperator over
]

{ #category : #modes }
AthensAeCairoPaintMode >> overlay [

	cairoContext operator: AeCairoOperator overlay
]

{ #category : #convenience }
AthensAeCairoPaintMode >> restoreAfter: aBlock [

	| anOperator |
	anOperator := cairoContext operator.
	aBlock ensure: [
		cairoContext operator: anOperator ]
]

{ #category : #modes }
AthensAeCairoPaintMode >> saturate [

	cairoContext operator: AeCairoOperator saturate
]

{ #category : #modes }
AthensAeCairoPaintMode >> screen [

	cairoContext operator: AeCairoOperator screen
]

{ #category : #modes }
AthensAeCairoPaintMode >> softLight [

	cairoContext operator: AeCairoOperator softLight
]

{ #category : #modes }
AthensAeCairoPaintMode >> source [

	cairoContext operator: AeCairoOperator source
]

{ #category : #modes }
AthensAeCairoPaintMode >> xor [

	cairoContext operator: AeCairoOperator xor
]
