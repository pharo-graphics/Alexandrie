Extension { #name : #BlTextParagraph }

{ #category : #'*Alexandrie-Canvas' }
BlTextParagraph >> aeDrawSelectionOn: aeCanvas padding: aBlInsets [ 

	| rectangles |
	(self selection isNil or: [ self selection isEmpty ])
		ifTrue: [ ^ self ].


	rectangles := OrderedCollection new.
	
	selection do: [ :aSelection |
		| aStart anEnd aSelectionStartSpan aSelectionEndSpan aSelectionStartPosition aSelectionEndPosition |

		aStart := aSelection from min: self text size.
		anEnd := aSelection to min: self text size.

		aSelectionStartSpan := self spanAtIndex: aStart.
		aSelectionEndSpan := self spanAtIndex: anEnd.

		aSelectionStartPosition := aStart isZero
			ifTrue: [ 0@0 ]
			ifFalse: [ (aSelectionStartSpan positionAt: aStart) + (aBlInsets left @ 0) ].

		aSelectionEndPosition := anEnd = self text size
			ifTrue: [ (aSelectionEndSpan positionAt: anEnd) + (aBlInsets width @ 0) ]
			ifFalse: [ (aSelectionEndSpan positionAt: anEnd) + (aBlInsets left @ 0) ].

		rectangles add: ((aSelection to > self text size)
			"containerExtent includes padding"
			ifTrue: [ (aSelectionStartPosition x @ 0) corner: self containerExtent ]
			ifFalse: [ (aSelectionStartPosition x @ 0) corner: (aSelectionEndPosition x @ self containerExtent y) ]).
		].
	

		"TODO: refactor the following is the only Alexandrie-specific code"
		aeCanvas restoreContextAfter: [ 

			aeCanvas
				setBackgroundWith: [ aeCanvas setSourceColor: (self class selectionColor) ]
				alpha: 1.0.

			aeCanvas setBorderOff.

			aeCanvas
				setPathKey: self
				hasJoins: true
				hasCaps: false
				block: [ :cairoContext |
					rectangles do: [ :each | cairoContext rectangle: each ] ].

			aeCanvas drawFigure.
			
			]
]
