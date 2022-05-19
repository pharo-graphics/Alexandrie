Class {
	#name : #BlSpaceFixture,
	#superclass : #Object,
	#category : #'Alexandrie-Canvas-Tests-Utilities'
}

{ #category : #accessing }
BlSpaceFixture >> allFixtureSelectors [

	^ self class allSelectors select: [ :each | 
		  (each beginsWith: #space) and: each isUnary ]
]

{ #category : #accessing }
BlSpaceFixture >> allFixtureSpaces [

	^ self allFixtureSelectors collect: [ :each | self perform: each ]
]

{ #category : #private }
BlSpaceFixture >> diagonalPositionGeneratorStartingAt: aPoint by: by [
	
	^ Generator on: [ :g | 
		| index |
		index := 0.
		[ 	g yield: aPoint + index asPoint.
			index := index + by ] repeat ]
]

{ #category : #private }
BlSpaceFixture >> gridPositionGeneratorStartingAt: offset by: by columns: numberOfColumns [
	
	^ Generator on: [ :g | 
		| column next |
		column := 0.
		next := offset.
		
		[	[	"Put next position"
				g yield: next.

				"Advance to next column in same row"
				next := next + (by @ 0).
				column := column + 1.

			] doWhileTrue: [ column < numberOfColumns ].

			"Start a new row"
			next := offset x @ (next y + by).
			column := 0 

		] repeat ]
]

{ #category : #fixtures }
BlSpaceFixture >> spaceClippingOutskirts [
	
	^ BlSpaceBuilder newSpaceWith: [ :builder |

		| outskirts width positionGenerator addElementsBlock |
		outskirts := { BlOutskirts inside. BlOutskirts centered. BlOutskirts outside }.
		width := 5.
		positionGenerator := self 
			gridPositionGeneratorStartingAt: 8 asPoint
			by: 25
			columns: 3.
		addElementsBlock := [ :anOutskirt :aColor |
			| element child |
			element := builder addCircle
				background: aColor;
				border: (BlBorder paint: builder nextColor width: width);
				outskirts: anOutskirt;
				relocate: positionGenerator next;
				size: 35 asPoint;
				yourself.
			child := (builder addTo: element)
				size: 20 asPoint;
				relocate: -2 asPoint;
				border: (BlBorder paint: Color yellow width: 1);
				yourself.
			(builder addTo: child)
				size: 20 asPoint;
				relocate: 10 asPoint;
				geometry: BlCircleGeometry new;
				border: (BlBorder paint: Color red width: 1);
				yourself ].

		"Opaques"
		outskirts do: [ :eachOutskirt |
			addElementsBlock
				value: eachOutskirt
				value: builder nextColor ].

		"Translucents"
		outskirts do: [ :eachOutskirt |
			addElementsBlock
				value: eachOutskirt
				value: builder nextColor translucent ].

		"Transparents"
		outskirts do: [ :eachOutskirt |
			addElementsBlock
				value: eachOutskirt
				value: Color transparent ].

		].
]

{ #category : #fixtures }
BlSpaceFixture >> spaceClippingWithoutBorders [

	^ BlSpaceBuilder newSpaceWith: [ :builder |
		| elementA elementB elementC |
	
		elementA := builder addToRoot
			geometry: BlRectangleGeometry new;
			relocate: 10 asPoint;
			size: 10 asPoint;
			clipChildren: false;
			yourself.

		elementB := (builder addTo: elementA)
			geometry: BlRectangleGeometry new;
			relocate: 5 asPoint;
			size: 10 asPoint;
			clipChildren: true;
			yourself.
			
		elementC := (builder addTo: elementB)
			geometry: BlRectangleGeometry new;
			relocate: 5 asPoint;
			size: 10 asPoint;
			yourself ]

]

{ #category : #fixtures }
BlSpaceFixture >> spaceWithCircles [
	
	^ BlSpaceBuilder newSpaceWith: [ :builder |
		| elementA elementB |
	
		elementA := builder addCircle
			relocate: 10 asPoint;
			size: 10 asPoint;
			yourself.

		elementB := builder addCircle
			relocate: 15 asPoint;
			size: 10 asPoint;
			yourself.
		].
]

{ #category : #fixtures }
BlSpaceFixture >> spaceWithElevation [

	^ BlSpaceBuilder newSpaceWith: [ :builder |
		| elementA elementB elementC childD childE childF |
	
		"A and children are on top"
		elementA := builder addCircle
			elevation: (BlRelativeElevation elevation: 101);
			relocate: 10@10;
			clipChildren: false;
			yourself.

		"B is below A"
		elementB := builder addCircle
			elevation: (BlGlobalElevation elevation: 90);
			relocate: 25@10;
			yourself.

		"C is below A"
		elementC := builder addCircle
			elevation: (BlGlobalElevation elevation: 100);
			relocate: 50@10;
			yourself.


		"D is below E, since 'relative' means relative to 0. 
		--> Bug? If it would be relative to its parent, it would
		be 101+5 => D would overlap E"
		childD := (builder addTo: elementA)
			elevation: (BlRelativeElevation elevation: 5);
			relocate: 10 @ 10;
			size: 30 asPoint;
			yourself.

		"Large elevation of a child doesn't mean it will overlap other
		elements than siblings"
		childE := (builder addTo: elementA)
			elevation: (BlGlobalElevation elevation: 102);
			relocate: 20 @ 20;
			size: 30 asPoint;
			yourself.

		"F goes below all siblings"
		childF := (builder addTo: elementA)
			elevation: (BlRelativeElevation elevation: -10);
			relocate: 30 @ 30;
			size: 30 asPoint;
			yourself.
			
		]

]

{ #category : #fixtures }
BlSpaceFixture >> spaceWithImagesAndTransformations [
	
	^ BlSpaceBuilder new
		spaceExtent: 120@350;
		newSpaceWith: [ :builder |

			| outskirts positionGenerator addElementBlock |
			outskirts := { BlOutskirts inside. BlOutskirts centered. BlOutskirts outside }.
			positionGenerator := self 
				gridPositionGeneratorStartingAt: 5 asPoint
				by: 26
				columns: 4.
			addElementBlock := [ | aForm |
				aForm := Smalltalk ui icons iconNamed: #warning.
				builder addCircle
					background: aForm;
					relocate: positionGenerator next;
					size: aForm extent;
					yourself ].


		"Translate"
		1 to: 4 do: [ :each |
			addElementBlock value transformDo: [ :t |
				t translateBy: (each * 2 - 4) asPoint ] ].

		"Rotate"
		1 to: 4 do: [ :each |
			addElementBlock value transformDo: [ :t |
				t centerOrigin. "default"
				t rotateBy: each * 45 ] ].

		1 to: 4 do: [ :each |
			addElementBlock value transformDo: [ :t |
				t topLeftOrigin.
				t rotateBy: each * 45 ] ].

		1 to: 4 do: [ :each |
			addElementBlock value transformDo: [ :t |
				t rightCenterOrigin.
				t rotateBy: each * 45 ] ].


		"Scale"			
		1 to: 4 do: [ :each |
			addElementBlock value transformDo: [ :t |
				t centerOrigin. "default"
				t scaleBy: each * 0.25 ] ].

		1 to: 4 do: [ :each |
			addElementBlock value transformDo: [ :t |
				t topLeftOrigin.
				t scaleBy: each * 0.25 ] ].

		1 to: 4 do: [ :each |
			addElementBlock value transformDo: [ :t |
				t rightCenterOrigin.
				t scaleBy: each * 0.25 ] ].

		"Some combinations"
		1 to: 4 do: [ :each |
			addElementBlock value transformDo: [ :t |
				t scaleBy: each * 0.2.
				t translateBy: (each * 2 - 4) asPoint.
				t rotateBy: each * 45.
				t translateBy: (each * 2 - 4) negated asPoint ] ].

		"Others"
		addElementBlock value transformDo: [ :t |
			t flipX ].
		addElementBlock value transformDo: [ :t |
			t flipY ].


		].
]

{ #category : #fixtures }
BlSpaceFixture >> spaceWithOpacities [

	^ BlSpaceBuilder newSpaceWith: [ :builder |
		| size fillColor borderColor |
		size := 50 asPoint.
		fillColor := builder nextColor.
		borderColor := builder nextColor.
		
		builder addToRoot
			background: ((BlPaintBackground paint: fillColor asBlPaint) opacity: 0.75; yourself);
			opacity: 0.5;
			relocate: 10 @ 10;
			size: size;
			yourself.

		builder addToRoot
			background: ((BlPaintBackground paint: fillColor) opacity: 0.5; yourself);
			opacity: 0.75;
			relocate: 40 @ 10;
			size: size;
			yourself.

		builder addToRoot
			background: fillColor;
			border: (BlBorder builder
				paint: (borderColor alpha: 0.75) asBlPaint;
				width: 10;
				opacity: 0.5;
				build);
			relocate: 10 @ 40;
			size: size;
			yourself.

		builder addToRoot
			background: fillColor;
			border: (BlBorder builder
				paint: (borderColor alpha: 0.5) asBlPaint;
				width: 10;
				opacity: 0.75;
				build);
			relocate: 40 @ 40;
			size: size;
			yourself.
		]
]

{ #category : #fixtures }
BlSpaceFixture >> spaceWithOutskirtsAndOpaqueBorders [
	
	^ BlSpaceBuilder new
		newSpaceWith: [ :builder |

			| outskirts positionGenerator addElementBlock |
			outskirts := { BlOutskirts inside. BlOutskirts centered. BlOutskirts outside }.
			positionGenerator := self 
				gridPositionGeneratorStartingAt: 8 asPoint
				by: 25
				columns: 3.
			addElementBlock := [ :backgroundColor :borderColor :aBlOutskirt |
				builder addCircle
					background: backgroundColor;
					border: (BlBorder paint: borderColor width: 5);
					outskirts: aBlOutskirt;
					relocate: positionGenerator next;
					size: 35 asPoint;
					yourself ].
			
		"Opaques"
		outskirts do: [ :eachOutskirt |
			addElementBlock
				value: builder nextColor
				value: builder nextColor
				value: eachOutskirt ].

		"Translucents"
		outskirts do: [ :eachOutskirt |
			addElementBlock
				value: builder nextColor translucent
				value: builder nextColor
				value: eachOutskirt ].

		"Transparents"
		outskirts do: [ :eachOutskirt |
			addElementBlock
				value: Color transparent
				value: builder nextColor
				value: eachOutskirt ].

		].
]

{ #category : #fixtures }
BlSpaceFixture >> spaceWithOutskirtsAndTranslucentBorders [
	
	^ BlSpaceBuilder new
		newSpaceWith: [ :builder |

			| outskirts positionGenerator addElementBlock |
			outskirts := { BlOutskirts inside. BlOutskirts centered. BlOutskirts outside }.
			positionGenerator := self 
				gridPositionGeneratorStartingAt: 8 asPoint
				by: 25
				columns: 3.
			addElementBlock := [ :backgroundColor :borderColor :aBlOutskirt |
				builder addCircle
					background: backgroundColor;
					border: (BlBorder paint: borderColor width: 5);
					outskirts: aBlOutskirt;
					relocate: positionGenerator next;
					size: 35 asPoint;
					yourself ].
			
		"Opaques + translucent border"
		outskirts do: [ :eachOutskirt |
			addElementBlock
				value: builder nextColor
				value: builder nextColor translucent
				value: eachOutskirt ].

		"Translucents + translucent border"
		outskirts do: [ :eachOutskirt |
			addElementBlock
				value: builder nextColor translucent
				value: builder nextColor translucent
				value: eachOutskirt ].

		"Transparents + translucent border"
		outskirts do: [ :eachOutskirt |
			addElementBlock
				value: Color transparent
				value: builder nextColor translucent
				value: eachOutskirt ].

		].
]

{ #category : #fixtures }
BlSpaceFixture >> spaceWithOutskirtsOfPolygons [
	"In Sparta, they are painted in a different way (the generic)."
	
	^ BlSpaceBuilder newSpaceWith: [ :builder |

		| outskirts width scale positionGenerator |
		outskirts := { BlOutskirts inside. BlOutskirts centered. BlOutskirts outside }.
		width := 7.
		scale := 0.5.
		positionGenerator := self 
			gridPositionGeneratorStartingAt: 0 asPoint
			by: 20
			columns: 3.

		"Opaques"
		outskirts do: [ :eachOutskirt |
				builder addHexagonalPolygon
					relocate: positionGenerator next;
					border: (BlBorder paint: builder nextColor width: width);
					outskirts: eachOutskirt;
					transformDo: [ :t | t scaleBy: scale ];
					yourself ].

		"Translucents"
		outskirts do: [ :eachOutskirt |
				builder addHexagonalPolygon
					relocate: positionGenerator next;
					background: builder nextColor translucent;
					border: (BlBorder paint: builder nextColor width: width);
					outskirts: eachOutskirt;
					transformDo: [ :t | t scaleBy: scale ];
					yourself ].

		"Transparents"
		outskirts do: [ :eachOutskirt |
				builder addHexagonalPolygon
					relocate: positionGenerator next;
					background: Color transparent;
					border: (BlBorder paint: builder nextColor width: width);
					outskirts: eachOutskirt;
					transformDo: [ :t | t scaleBy: scale ];
					yourself ].

		].
]

{ #category : #fixtures }
BlSpaceFixture >> spaceWithRectangles [

	^ BlSpaceBuilder newSpaceWith: [ :builder |
		| elementA elementB |
	
		elementA := builder addToRoot
			geometry: BlRectangleGeometry new;
			relocate: 10 asPoint;
			size: 10 asPoint;
			yourself.

		elementB := builder addToRoot
			geometry: BlRectangleGeometry new;
			relocate: 15 asPoint;
			size: 10 asPoint;
			yourself.
		]
]

{ #category : #fixtures }
BlSpaceFixture >> spaceWithStrokeStyles [
	
	^ BlSpaceBuilder newSpaceWith: [ :builder |

			| positionGenerator width |
			width := 9.
			positionGenerator := self
				diagonalPositionGeneratorStartingAt: 7
				by: 14.

			builder addPolyline
				relocate: positionGenerator next;
				border: (BlBorder builder
					width: width;
					capButt;
					joinRound;
					paint: builder nextColor;
					build);
				yourself.

			builder addPolyline
				relocate: positionGenerator next;
				border: (BlBorder builder
					width: width;
					capSquare;
					joinBevel;
					paint: builder nextColor;
					build);
				yourself.

			builder addPolyline
				relocate: positionGenerator next;
				border: (BlBorder builder
					width: width;
					capRound;
					joinMiter;
					miterLimit: 10;
					paint: builder nextColor;
					build);
				yourself.

			builder addPolyline
				relocate: positionGenerator next;
				border: (BlBorder builder
					dashArray: #(0 5);
					capRound;
					joinRound;
					paint: builder nextColor;
					width: 4;
					build);
				yourself.

			builder addPolyline
				relocate: positionGenerator next;
				border: (BlBorder builder
					dashArray: #(3 5);
					dashOffset: 5;
					paint: builder nextColor;
					capSquare;
					joinBevel;
					width: 3;
					build);
				yourself.

			builder addPolyline
				relocate: positionGenerator next;
				border: (BlBorder builder
					paint: builder nextColor;
					capSquare;
					joinMiter;
					miterLimit: 1; "This will make it render as bevel join"
					width: 12;
					build);
				transformDo: [ :t |
					t translateBy: -10 asPoint.
					t scaleBy: 0.8. ];
				yourself.

		].
]

{ #category : #fixtures }
BlSpaceFixture >> spaceWithText0 [
	"Draw one span with font-size attribute and padding."

	^ BlSpaceBuilder new
		spaceExtent: 200 @ 100;
		newSpaceWith: [ :builder |

			| aText |
			aText :=
				('Les' asRopedText      fontSize: 22; black; fontName: 'Arial'; foreground: Color blue; yourself),
				('élèves' asRopedText   fontSize: 18; underline; yourself),
				('français' asRopedText fontSize: 26; italic; background: Color yellow; yourself).
	
			(builder addTextToRoot: aText)
				padding: (BlInsets all: 5);
				relocate: 5 asPoint;
				constraintsDo: [ :c | 
					c vertical fitContent.
					c horizontal fitContent ];
				border: (BlBorder paint: builder nextColor width: 1);
				yourself.

			(builder addTextToRoot: 'aßc' asRopedText)
"				background: builder nextColor;
				padding: (BlInsets all: 0);"
				opacity: 0.5;
				transformDo: [ :t |
					t scaleBy: 2.
					t rotateBy: 90.
					t translateBy: 0 @ 50 ];
				yourself.

			(builder addTextToRoot: (String loremIpsum: 10) asRopedText)
				background: builder nextColor;
				padding: (BlInsets all: 3);
				relocate: 50 asPoint;
				size: 50@20; 
				yourself.

	 		]
]

{ #category : #fixtures }
BlSpaceFixture >> spaceWithTransformRotate [

	^ BlSpaceBuilder newSpaceWith: [ :builder |
		| elementA elementB elementC |
	
		elementA := builder addToRoot
			geometry: BlTriangleGeometry new;
			relocate: 0 asPoint;
			size: 25 asPoint;
			transformDo: [ :t | t rotateBy: -135 ];
			yourself.

		elementB := builder addToRoot
			geometry: BlRectangleGeometry new;
			relocate: 20 asPoint;
			size: 20 asPoint;
			transformDo: [ :t | t rotateBy: 45 ];
			yourself.
			
		elementC := (builder addTo: elementB)
			geometry: BlRectangleGeometry new;
			transformDo: [ :t | t rotateBy: 180 ];
			relocate: 5 asPoint;
			size: 10 asPoint;
			yourself ]
]

{ #category : #fixtures }
BlSpaceFixture >> spaceWithTransformScale [

	^ BlSpaceBuilder newSpaceWith: [ :builder |
		| elementA elementB elementC |

		"Center is at 10@10"
		elementA := builder addToRoot
			geometry: BlCircleGeometry new;
			relocate: 0 asPoint;
			size: 20 asPoint;
			transformDo: [ :t | t scaleBy: 1/2 ];
			yourself.

		"Center is 25@25 (10/2 + 20)"
		elementB := builder addToRoot
			geometry: BlCircleGeometry new;
			relocate: 20 asPoint;
			size: 10 asPoint;
			transformDo: [ :t | t scaleBy: 2 ];
			yourself.

		"C is in the center of it's parent, as they have the same size."
		elementC := (builder addTo: elementB)
			geometry: BlCircleGeometry new;
			relocate: 0 asPoint;
			size: 10 asPoint;
			transformDo: [ :t | t scaleBy: 0.5 ];
			yourself ]
]

{ #category : #fixtures }
BlSpaceFixture >> spaceWithTransformTranslate [

	^ BlSpaceBuilder newSpaceWith: [ :builder |
		| elementA elementB elementC |
	
		elementA := builder addToRoot
			geometry: BlRectangleGeometry new;
			transformDo: [ :t | t translateBy: 10 ];
			size: 10 asPoint;
			yourself.

		elementB := builder addToRoot
			geometry: BlRectangleGeometry new;
			transformDo: [ :t | t translateBy: 15 ];
			size: 10 asPoint;
			yourself.
			
		elementC := (builder addTo: elementB)
			geometry: BlRectangleGeometry new;
			transformDo: [ :t | t translateBy: 5 ];
			size: 5 asPoint;
			yourself ]
]

{ #category : #fixtures }
BlSpaceFixture >> spaceWithTriangles [

	^ BlSpaceBuilder newSpaceWith: [ :builder |
		| elementA elementB |
	
		elementA := builder addTriangle
			relocate: 10 asPoint;
			size: 10 asPoint;
			yourself.

		elementB := builder addTriangle
			relocate: 15 asPoint;
			size: 10 asPoint;
			yourself ]
]
