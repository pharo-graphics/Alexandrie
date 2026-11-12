"
I test text rendering and font integration for AthensAeCairoSurface.
"
Class {
	#name : #AthensAeCairoTextTest,
	#superclass : #TestCase,
	#category : #'Alexandrie-Athens-Tests'
}

{ #category : #tests }
AthensAeCairoTextTest >> testDrawStringSubstring [

	| surface font fullAdvance partAdvance |
	surface := AthensAeCairoSurface extent: 200 @ 50.
	font := LogicalFont familyName: 'Source Sans Pro' pointSize: 12.
	surface drawDuring: [ :canvas |
		canvas setPaint: Color black.
		canvas setFont: font.
		fullAdvance := canvas drawString: 'Hello World'.
		partAdvance := canvas drawString: 'Hello World' from: 1 to: 5 ].
	self assert: fullAdvance x > partAdvance x
]

{ #category : #tests }
AthensAeCairoTextTest >> testDrawStringWithFreeTypeFont [

	| surface font advance |
	surface := AthensAeCairoSurface extent: 200 @ 50.
	font := (LogicalFont familyName: 'Source Sans Pro' pointSize: 12) realFont.
	surface drawDuring: [ :canvas |
		canvas setPaint: Color black.
		canvas setFont: font.
		advance := canvas drawString: 'Hello FreeTypeFont' ].
	self assert: advance x > 0
]

{ #category : #tests }
AthensAeCairoTextTest >> testDrawStringWithLogicalFont [

	| surface font advance |
	surface := AthensAeCairoSurface extent: 200 @ 50.
	font := LogicalFont familyName: 'Source Sans Pro' pointSize: 12.
	surface drawDuring: [ :canvas |
		canvas setPaint: Color black.
		canvas setFont: font.
		advance := canvas drawString: 'Hello LogicalFont' ].
	self assert: advance x > 0
]

{ #category : #tests }
AthensAeCairoTextTest >> testDrawStringWithStrikeFont [

	| surface font advance |
	surface := AthensAeCairoSurface extent: 200 @ 50.
	font := StrikeFont familyName: 'Bitmap DejaVu Sans' size: 10.
	surface drawDuring: [ :canvas |
		canvas setPaint: Color black.
		canvas setFont: font.
		advance := canvas drawString: 'Hello StrikeFont' ].
	self assert: advance x > 0
]

{ #category : #tests }
AthensAeCairoTextTest >> testTextRenderer [

	| surface composer form |
	surface := AthensAeCairoSurface extent: 200 @ 50.
	composer := AthensTextComposer scan: 'Hello Athens' asText for: AthensTextScanner new.
	surface drawDuring: [ :canvas | composer renderOn: canvas ].
	form := surface asForm.
	self assert: form extent equals: 200 @ 50
]
