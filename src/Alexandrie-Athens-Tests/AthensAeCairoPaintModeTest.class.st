Class {
	#name : #AthensAeCairoPaintModeTest,
	#superclass : #TestCase,
	#category : #'Alexandrie-Athens-Tests'
}

{ #category : #tests }
AthensAeCairoPaintModeTest >> testAllModesExecution [

	| surface |
	surface := AthensAeCairoSurface extent: 20 @ 20.
	surface drawDuring: [ :canvas |
		canvas paintMode availableModes do: [ :mode |
			canvas paintMode perform: mode.
			canvas setPaint: Color red.
			canvas drawShape: (0 @ 0 corner: 10 @ 10) ] ].
	self assert: surface asForm isNotNil
]

{ #category : #tests }
AthensAeCairoPaintModeTest >> testAvailableModes [

	| surface |
	surface := AthensAeCairoSurface extent: 10 @ 10.
	surface drawDuring: [ :canvas |
		self assert: canvas paintMode availableModes size equals: 29.
		self assert: (canvas paintMode availableModes includes: #over).
		self assert: (canvas paintMode availableModes includes: #source).
		self assert: (canvas paintMode availableModes includes: #clear).
		self assert: (canvas paintMode availableModes includes: #multiply) ]
]
