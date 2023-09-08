Extension { #name : #AeCairoContext }

{ #category : #'*Alexandrie-NewTools' }
AeCairoContext >> clippingAreaAsForm [ 
	
	| clippingForm |
	"Temporarily reset CTM matrix"
	self
		saveState;
		setIdentityMatrix.

	clippingForm := Form extent: surface extent depth: 1.
	0 to: clippingForm width - 1 do: [ :x |
		0 to: clippingForm height - 1 do: [ :y |
			| isInClip |
			isInClip := self isInClipX: x y: y.
			clippingForm
				colorAt: x@y
				put: (isInClip
					ifTrue: [ Color black ]
					ifFalse: [ Color white ]).
			] ].

	self restoreState.
		
	^ clippingForm
]

{ #category : #'*Alexandrie-NewTools' }
AeCairoContext >> inspectionOfClippingArea: aBuilder [
	<inspectorPresentationOrder: 1 title: 'Clipping Area'>

	^ aBuilder newMorph
		morph: self clippingAreaAsForm asMorph;
		yourself
]

{ #category : #'*Alexandrie-NewTools' }
AeCairoContext >> inspectionOfSurfaceAsForm: aBuilder [
	<inspectorPresentationOrder: 0 title: 'Surface'>

	^ surface inspectionAsForm: aBuilder
]
