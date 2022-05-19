Extension { #name : #BlElement }

{ #category : #'*Alexandrie-Canvas-Core' }
BlElement >> aeAsForm [

	| aCanvas |
	self isLayoutRequested
		ifTrue: [ self forceLayout ].

	aCanvas := AeCanvas extent: self extent.
	aCanvas fullDraw: self.
	^ aCanvas asForm

]

{ #category : #'*Alexandrie-Canvas-Core' }
BlElement >> aeDrawChildrenOn: aeCanvas [
	"Draw my children.
	
	Notes:
	- Receiver assumes that position and transformations are already applied on the canvas."
	
	self children isEmpty ifTrue: [ ^self ].

	aeCanvas setClipChildren: self clipChildren.
	self children sortedByElevation do: [ :each |
		each aeDrawOn: aeCanvas ].
]

{ #category : #'*Alexandrie-Canvas-Core' }
BlElement >> aeDrawGeometryOn: aeCanvas [
	"Draw my geometry with the corresponding background and border.

	Notes:
	- AeCanvas requires this 'set up order': background, outskirts, border.
	- Pre-condition: position and transformations are already applied on the canvas.
	- Post-condition: position and transformations are maintanined intact."

	self background aeApplyTo: aeCanvas.
	self outskirts aeApplyTo: aeCanvas.
	self border aeApplyTo: aeCanvas.
	self geometry aeApplyTo: aeCanvas element: self.
	aeCanvas drawFillAndStroke.

]

{ #category : #'*Alexandrie-Canvas-Core' }
BlElement >> aeDrawOn: aeCanvas [

	aeCanvas drawElementAlpha: self opacity with: [

		"Apply transformations"
		aeCanvas pathTranslate: self position.
		self transformation aeApplyTo: aeCanvas element: self.

		self aeDrawGeometryOn: aeCanvas.
		self aeDrawChildrenOn: aeCanvas.

		]
]
