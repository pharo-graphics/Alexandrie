"
I compare two Cairo image surfaces (AeCairoImageSurface) for visual regression testing.

I support:
- Native row-by-row memory comparison fast path via LibC memcmp when surfaces have matching dimensions and formats.
- Per-pixel color fuzz matching via my settings.
- Cached mismatch counting and ratio delta calculations.
- Side-by-side and difference visual inspector presentations (converting surfaces to Form on demand for inspection tools).
"
Class {
	#name : #AeImageComparison,
	#superclass : #Object,
	#instVars : [
		'actual',
		'expected',
		'label',
		'settings',
		'mismatchCount'
	],
	#category : #'Alexandrie-ImageMatch'
}

{ #category : #'instance creation' }
AeImageComparison class >> expected: anExpected actual: anActual label: aString [

	^ self
		expected: anExpected
		actual: anActual
		label: aString
		settings: AeImageMatchSettings exact
]

{ #category : #'instance creation' }
AeImageComparison class >> expected: anExpected actual: anActual label: aString settings: aSettings [

	^ self basicNew
		initializeWithExpected: anExpected
		actual: anActual
		label: aString
		settings: aSettings;
		yourself
]

{ #category : #'instance creation' }
AeImageComparison class >> readFrom: aFileReference [

	^ aFileReference exists
		  ifFalse: [ AeCairoImageSurface extent: 0 @ 0 ]
		  ifTrue: [ AeCairoImageSurface newFromPngFileAt: aFileReference ]
]

{ #category : #accessing }
AeImageComparison >> actual [

	^ actual
]

{ #category : #testing }
AeImageComparison >> canUseFastPath [

	actual extent = expected extent ifFalse: [ ^ false ].
	actual stride = expected stride ifFalse: [ ^ false ].
	actual format = expected format ifFalse: [ ^ false ].
	^ true
]

{ #category : #reporting }
AeImageComparison >> diagnosisString [

	| stream ratioPercent expectedRatioPercent |
	self isMatch ifTrue: [
		^ 'Match! All ' , (actual width * actual height) asString , ' pixels match expected image within settings.' ].

	stream := String new writeStream.
	stream
		nextPutAll: 'Image mismatch: #' , label;
		cr;
		cr;
		nextPutAll: 'Extent: ';
		print: actual extent;
		nextPutAll: ' (';
		print: actual width * actual height;
		nextPutAll: ' pixels)';
		cr;
		cr.

	actual extent = expected extent ifFalse: [
			stream
				nextPutAll: 'Actual vs. Expected:';
				cr;
				tab;
				nextPutAll: '- Extent: actual is ';
				print: actual extent;
				nextPutAll: ', but expected is ';
				print: expected extent;
				cr.
			^ stream contents ].

	ratioPercent := self mismatchRatio * 100 printShowingDecimalPlaces: 2.
	expectedRatioPercent := settings maxMismatchRatio * 100 printShowingDecimalPlaces: 2.
	stream
		nextPutAll: 'Actual vs. Expected:';
		cr;
		tab;
		nextPutAll: '- Mismatched Pixels: ';
		print: self mismatchCount;
		nextPutAll: ' (expected <= ';
		print: settings maxMismatchCount;
		nextPutAll: ')';
		cr;
		tab;
		nextPutAll: '- Mismatch Ratio: ';
		nextPutAll: ratioPercent;
		nextPutAll: '% (expected <= ';
		nextPutAll: expectedRatioPercent;
		nextPutAll: '%)';
		cr;
		cr;
		nextPutAll: 'Suggested Setting:';
		cr;
		tab;
		nextPutAll: self suggestedSettings storeString.

	^ stream contents
]

{ #category : #accessing }
AeImageComparison >> expected [

	^ expected
]

{ #category : #exporting }
AeImageComparison >> exportActualTo: aFileReference [

	actual writePngTo: aFileReference
]

{ #category : #initialization }
AeImageComparison >> initializeWithExpected: anExpected actual: anActual label: aString settings: anAeImageMatchSettings [

	self initialize.
	expected := anExpected.
	actual := anActual.
	label := aString.
	settings := anAeImageMatchSettings
]

{ #category : #testing }
AeImageComparison >> isColor: actualColor matching: expectedColor withinTolerance: fuzz [

	fuzz isZero ifTrue: [ ^ actualColor = expectedColor ].
	^ (actualColor red - expectedColor red) abs <= fuzz and: [
		(actualColor green - expectedColor green) abs <= fuzz and: [
			(actualColor blue - expectedColor blue) abs <= fuzz and: [
				(actualColor alpha - expectedColor alpha) abs <= fuzz ] ] ]
]

{ #category : #testing }
AeImageComparison >> isMatch [

	actual extent = expected extent ifFalse: [ ^ false ].
	^ settings isMatchFor: self
]

{ #category : #accessing }
AeImageComparison >> label [

	^ label
]

{ #category : #enumerating }
AeImageComparison >> mismatchCount [

	mismatchCount ifNil: [
		actual extent = expected extent
			ifFalse: [
				mismatchCount := actual width * actual height max: 1 ]
			ifTrue: [
				| count |
				count := 0.
				self mismatchesDo: [ count := count + 1 ].
				mismatchCount := count ] ].

	^ mismatchCount
]

{ #category : #enumerating }
AeImageComparison >> mismatchRatio [

	| total |
	actual extent = expected extent ifFalse: [ ^ 1.0 ].
	total := actual width * actual height.
	^ total isZero
		  ifTrue: [ 0.0 ]
		  ifFalse: [ self mismatchCount / total asFloat ]
]

{ #category : #enumerating }
AeImageComparison >> mismatches [

	^ Array streamContents: [ :stream |
		self mismatchesDo: [ :zeroIndexedPoint :actualColor :expectedColor |
			stream nextPut: {
				zeroIndexedPoint.
				actualColor.
				expectedColor } ] ]
]

{ #category : #enumerating }
AeImageComparison >> mismatchesDo: aBlock [

	self canUseFastPath
		ifTrue: [ self mismatchesDoFast: aBlock ]
		ifFalse: [ self mismatchesDoSlow: aBlock ]
]

{ #category : #enumerating }
AeImageComparison >> mismatchesDoFast: aBlock [

	| bufferSize actualData expectedData stride height width fuzz |
	actual flush.
	expected flush.

	actualData := actual data.
	expectedData := expected data.
	stride := actual stride.
	height := actual height.
	width := actual width.
	bufferSize := stride * height.

	(LibC uniqueInstance memCompare: actualData with: expectedData size: bufferSize) isZero ifTrue: [ ^ self ].

	fuzz := settings colorTolerance.
	0 to: height - 1 do: [ :y |
		| rowOffset |
		rowOffset := y * stride.
		(LibC uniqueInstance memCompare: actualData + rowOffset with: expectedData + rowOffset size: stride) isZero ifFalse: [
			0 to: width - 1 do: [ :x |
				| currentPoint actualColor expectedColor |
				currentPoint := x @ y.
				actualColor := actual colorAtX: x y: y.
				expectedColor := expected colorAtX: x y: y.
				(fuzz isZero
					ifTrue: [ actualColor = expectedColor ]
					ifFalse: [ self isColor: actualColor matching: expectedColor withinTolerance: fuzz ]) ifFalse: [
						aBlock cull: currentPoint cull: actualColor cull: expectedColor ] ] ] ]
]

{ #category : #enumerating }
AeImageComparison >> mismatchesDoSlow: aBlock [

	| fuzz width height |
	actual extent = expected extent ifFalse: [ ^ self ].

	fuzz := settings colorTolerance.
	width := actual width.
	height := actual height.

	0 to: width - 1 do: [ :x |
		0 to: height - 1 do: [ :y |
			| currentPoint actualColor expectedColor |
			currentPoint := x @ y.
			actualColor := actual colorAt: currentPoint.
			expectedColor := expected colorAt: currentPoint.
			(self isColor: actualColor matching: expectedColor withinTolerance: fuzz) ifFalse: [
				aBlock cull: currentPoint cull: actualColor cull: expectedColor ] ] ]
]

{ #category : #inspecting }
AeImageComparison >> newMergedSurfaceScaledBy: aScale withDiffOverlay: aBoolean [

	| width height targetW targetH targetSurface context |
	width := (actual width max: expected width) max: 1.
	height := (actual height max: expected height) max: 1.
	targetW := ((width * 2) + 1) * aScale.
	targetH := height * aScale.

	targetSurface := AeCairoImageSurface extent: targetW @ targetH format: AeCairoSurfaceFormat argb32.
	context := targetSurface newContext.

	aScale > 1 ifTrue: [ context scaleByX: aScale y: aScale ].

	context sourceSurface: actual x: 0 y: 0.
	context source filter: AeCairoSamplingFilter nearest.
	context paint.

	context sourceColor: (Color gray: 0.75).
	context rectangle: (width @ 0 extent: 1 @ height).
	context fill.

	context sourceSurface: expected x: width + 1 y: 0.
	context source filter: AeCairoSamplingFilter nearest.
	context paint.

	(aBoolean and: [ actual extent = expected extent ]) ifTrue: [
			context sourceColor: (Color red alpha: 0.65).
			self mismatchesDo: [ :point :actualCol :expectedCol |
					context rectangle: (point extent: 1 @ 1).
					context rectangle: (point x + width + 1 @ point y extent: 1 @ 1) ].
			context fill ].

	targetSurface flush.
	^ targetSurface
]

{ #category : #printing }
AeImageComparison >> printOn: aStream [

	super printOn: aStream.
	aStream
		nextPut: $(;
		nextPutAll: label;
		space;
		nextPutAll: (self isMatch
			ifTrue: [ 'match' ]
			ifFalse: [ 'mismatch: ', (self mismatchRatio * 100) asInteger asString, '%' ]);
		nextPut: $)
]

{ #category : #accessing }
AeImageComparison >> settings [

	^ settings
]

{ #category : #reporting }
AeImageComparison >> suggestedSettings [

	| suggestedRatio |
	suggestedRatio := (self mismatchRatio roundUpTo: 0.001) max: 0.001.
	^ AeImageMatchSettings
		  colorTolerance: settings colorTolerance
		  maxMismatchCount: self mismatchCount
		  maxMismatchRatio: suggestedRatio
]
