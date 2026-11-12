Class {
	#name : #AthensAeCairoMeshGradientPaint,
	#superclass : #AthensAeCairoPaint,
	#category : #'Alexandrie-Athens'
}

{ #category : #'instance creation' }
AthensAeCairoMeshGradientPaint class >> withPatches: aListOfMeshPatches [

	| pattern |
	pattern := AeCairoMeshPattern new.
	^ (self on: pattern)
		populatePatches: aListOfMeshPatches;
		yourself
]

{ #category : #modifying }
AthensAeCairoMeshGradientPaint >> addPatch: aPatch [

	aPatch addToCairoMeshGradientPaint: self
]

{ #category : #'mesh pattern commands' }
AthensAeCairoMeshGradientPaint >> beginPatch [

	cairoPattern beginPatch
]

{ #category : #accessing }
AthensAeCairoMeshGradientPaint >> colors: aSequenceOfColors [

	aSequenceOfColors doWithIndex: [ :color :index | self setCorner: index - 1 color: color ]
]

{ #category : #'mesh pattern commands' }
AthensAeCairoMeshGradientPaint >> curveVia: aPoint1 and: aPoint2 to: aPoint3 [

	cairoPattern curveVia: aPoint1 and: aPoint2 to: aPoint3
]

{ #category : #'mesh pattern commands' }
AthensAeCairoMeshGradientPaint >> endPatch [

	cairoPattern endPatch
]

{ #category : #'mesh pattern commands' }
AthensAeCairoMeshGradientPaint >> lineTo: aPoint [

	cairoPattern lineTo: aPoint
]

{ #category : #'mesh pattern commands' }
AthensAeCairoMeshGradientPaint >> moveTo: aPoint [

	cairoPattern moveTo: aPoint
]

{ #category : #modifying }
AthensAeCairoMeshGradientPaint >> populatePatches: aListOfMeshPatches [

	aListOfMeshPatches do: [ :each | self addPatch: each ]
]

{ #category : #'mesh pattern commands' }
AthensAeCairoMeshGradientPaint >> setCorner: aCornerIndex color: aColor [

	cairoPattern cornerAt: aCornerIndex putColor: aColor
]
