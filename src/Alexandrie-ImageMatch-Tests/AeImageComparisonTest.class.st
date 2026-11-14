Class {
	#name : #AeImageComparisonTest,
	#superclass : #TestCase,
	#category : #'Alexandrie-ImageMatch-Tests'
}

{ #category : #tests }
AeImageComparisonTest >> testCanUseFastPath [

	| surface1 surface2 surface3 comparison1 comparison2 |
	surface1 := AeCairoImageSurface extent: 10 @ 10 format: AeCairoSurfaceFormat argb32.
	surface2 := AeCairoImageSurface extent: 10 @ 10 format: AeCairoSurfaceFormat argb32.
	surface3 := AeCairoImageSurface extent: 10 @ 10 format: AeCairoSurfaceFormat a8.
	comparison1 := AeImageComparison expected: surface1 actual: surface2 label: 'test'.
	self assert: comparison1 canUseFastPath.

	comparison2 := AeImageComparison expected: surface1 actual: surface3 label: 'test'.
	self deny: comparison2 canUseFastPath
]

{ #category : #tests }
AeImageComparisonTest >> testColorTolerance [

	| surface1 surface2 comparison settings |
	surface1 := AeCairoImageSurface extent: 10 @ 10 format: AeCairoSurfaceFormat argb32.
	surface1 newContext
		sourceColor: (Color r: 0.5 g: 0.5 b: 0.5);
		paint.
	surface1 flush.
	surface2 := AeCairoImageSurface extent: 10 @ 10 format: AeCairoSurfaceFormat argb32.
	surface2 newContext
		sourceColor: (Color r: 0.52 g: 0.5 b: 0.5);
		paint.
	surface2 flush.
	comparison := AeImageComparison expected: surface1 actual: surface2 label: 'test'.
	self deny: comparison isMatch.
	self assert: comparison mismatchCount equals: 100.

	settings := AeImageMatchSettings colorTolerance: 0.05 maxMismatchCount: 0 maxMismatchRatio: 0.0.
	comparison := AeImageComparison
		              expected: surface1
		              actual: surface2
		              label: 'test'
		              settings: settings.
	self assert: comparison isMatch.
	self assert: comparison mismatchCount equals: 0
]

{ #category : #tests }
AeImageComparisonTest >> testDiagnosisString [

	| surface1 surface2 comparison |
	surface1 := AeCairoImageSurface extent: 10 @ 10 format: AeCairoSurfaceFormat argb32.
	surface2 := AeCairoImageSurface extent: 10 @ 10 format: AeCairoSurfaceFormat argb32.
	surface1 newContext
		sourceColor: Color red;
		paint.
	surface1 flush.
	surface2 newContext
		sourceColor: Color red;
		paint.
	surface2 flush.
	comparison := AeImageComparison expected: surface1 actual: surface2 label: 'test'.
	self assert: (comparison diagnosisString beginsWith: 'Match!').

	surface2 := AeCairoImageSurface extent: 10 @ 10 format: AeCairoSurfaceFormat argb32.
	surface2 newContext
		sourceColor: Color red;
		paint;
		sourceColor: Color blue;
		rectangle: (2 @ 2 extent: 2 @ 1);
		fill.
	surface2 flush.
	comparison := AeImageComparison expected: surface1 actual: surface2 label: 'test'.
	self assert: (comparison diagnosisString includesSubstring: 'Image mismatch: #test').
	self assert: (comparison diagnosisString includesSubstring: 'Actual vs. Expected:').
	self assert: (comparison diagnosisString includesSubstring: '- Mismatched Pixels: 2').
	self assert: (comparison diagnosisString includesSubstring: 'Suggested Setting:').
	self assert: (comparison diagnosisString includesSubstring: 'maxMismatchCount: 2')
]

{ #category : #tests }
AeImageComparisonTest >> testDiagnosisStringWithDifferentExtents [

	| surface1 surface2 comparison |
	surface1 := AeCairoImageSurface extent: 10 @ 10 format: AeCairoSurfaceFormat argb32.
	surface2 := AeCairoImageSurface extent: 10 @ 20 format: AeCairoSurfaceFormat argb32.
	comparison := AeImageComparison expected: surface1 actual: surface2 label: 'diffExtents'.
	self assert: (comparison diagnosisString includesSubstring: 'Image mismatch: #diffExtents').
	self assert: (comparison diagnosisString includesSubstring: 'Extent: actual is (10@20), but expected is (10@10)')
]

{ #category : #tests }
AeImageComparisonTest >> testDifferentExtents [

	| surface1 surface2 comparison |
	surface1 := AeCairoImageSurface extent: 10 @ 10 format: AeCairoSurfaceFormat argb32.
	surface2 := AeCairoImageSurface extent: 10 @ 20 format: AeCairoSurfaceFormat argb32.
	comparison := AeImageComparison expected: surface1 actual: surface2 label: 'test'.
	self deny: comparison isMatch.
	self assert: comparison mismatchRatio equals: 1.0.
	self assert: comparison mismatchCount equals: 200
]

{ #category : #tests }
AeImageComparisonTest >> testExactMatch [

	| surface1 surface2 comparison |
	surface1 := AeCairoImageSurface extent: 10 @ 10 format: AeCairoSurfaceFormat argb32.
	surface1 newContext
		sourceColor: Color red;
		paint.
	surface1 flush.
	surface2 := AeCairoImageSurface extent: 10 @ 10 format: AeCairoSurfaceFormat argb32.
	surface2 newContext
		sourceColor: Color red;
		paint.
	surface2 flush.
	comparison := AeImageComparison expected: surface1 actual: surface2 label: 'test'.
	self assert: comparison canUseFastPath.
	self assert: comparison isMatch.
	self assert: comparison mismatchCount equals: 0.
	self assert: comparison mismatchRatio equals: 0.0.
	self assert: comparison mismatches isEmpty
]

{ #category : #tests }
AeImageComparisonTest >> testInspectorPresentations [

	| surface1 surface2 comparison mergedSurface diffSurface scaledDiffSurface |
	surface1 := AeCairoImageSurface extent: 10 @ 10 format: AeCairoSurfaceFormat argb32.
	surface2 := AeCairoImageSurface extent: 10 @ 10 format: AeCairoSurfaceFormat argb32.
	surface2 newContext
		sourceColor: Color red;
		rectangle: (2 @ 2 extent: 1 @ 1);
		fill.
	surface2 flush.
	comparison := AeImageComparison expected: surface1 actual: surface2 label: 'test'.
	mergedSurface := comparison newMergedSurfaceScaledBy: 1 withDiffOverlay: false.
	self assert: mergedSurface width equals: 21.
	self assert: mergedSurface height equals: 10.

	diffSurface := comparison newMergedSurfaceScaledBy: 1 withDiffOverlay: true.
	self assert: diffSurface width equals: 21.
	self assert: diffSurface height equals: 10.

	scaledDiffSurface := comparison newMergedSurfaceScaledBy: 2 withDiffOverlay: true.
	self assert: scaledDiffSurface width equals: 42.
	self assert: scaledDiffSurface height equals: 20
]

{ #category : #tests }
AeImageComparisonTest >> testMaxMismatchCount [

	| surface1 surface2 comparison settings |
	surface1 := AeCairoImageSurface extent: 10 @ 10 format: AeCairoSurfaceFormat argb32.
	surface1 newContext
		sourceColor: Color red;
		paint.
	surface1 flush.
	surface2 := AeCairoImageSurface extent: 10 @ 10 format: AeCairoSurfaceFormat argb32.
	surface2 newContext
		sourceColor: Color red;
		paint;
		sourceColor: Color blue;
		rectangle: (2 @ 2 extent: 2 @ 1);
		fill.
	surface2 flush.
	settings := AeImageMatchSettings colorTolerance: 0.0 maxMismatchCount: 1 maxMismatchRatio: 0.0.
	comparison := AeImageComparison
		              expected: surface1
		              actual: surface2
		              label: 'test'
		              settings: settings.
	self deny: comparison isMatch.

	comparison := AeImageComparison
		              expected: surface1
		              actual: surface2
		              label: 'test'
		              settings: (AeImageMatchSettings colorTolerance: 0.0 maxMismatchCount: 2 maxMismatchRatio: 0.0).
	self assert: comparison isMatch
]

{ #category : #tests }
AeImageComparisonTest >> testMaxMismatchRatio [

	| surface1 surface2 comparison settings |
	surface1 := AeCairoImageSurface extent: 10 @ 10 format: AeCairoSurfaceFormat argb32.
	surface1 newContext
		sourceColor: Color red;
		paint.
	surface1 flush.
	surface2 := AeCairoImageSurface extent: 10 @ 10 format: AeCairoSurfaceFormat argb32.
	surface2 newContext
		sourceColor: Color red;
		paint;
		sourceColor: Color blue;
		rectangle: (2 @ 2 extent: 2 @ 1);
		fill.
	surface2 flush.
	settings := AeImageMatchSettings colorTolerance: 0.0 maxMismatchCount: 0 maxMismatchRatio: 0.01.
	comparison := AeImageComparison
		              expected: surface1
		              actual: surface2
		              label: 'test'
		              settings: settings.
	self deny: comparison isMatch.

	comparison := AeImageComparison
		              expected: surface1
		              actual: surface2
		              label: 'test'
		              settings: (AeImageMatchSettings colorTolerance: 0.0 maxMismatchCount: 0 maxMismatchRatio: 0.03).
	self assert: comparison isMatch
]

{ #category : #tests }
AeImageComparisonTest >> testMismatch [

	| surface1 surface2 comparison |
	surface1 := AeCairoImageSurface extent: 10 @ 10 format: AeCairoSurfaceFormat argb32.
	surface1 newContext
		sourceColor: Color red;
		paint.
	surface1 flush.
	surface2 := AeCairoImageSurface extent: 10 @ 10 format: AeCairoSurfaceFormat argb32.
	surface2 newContext
		sourceColor: Color red;
		paint;
		sourceColor: Color blue;
		rectangle: (2 @ 2 extent: 2 @ 1);
		fill.
	surface2 flush.
	comparison := AeImageComparison expected: surface1 actual: surface2 label: 'test'.
	self assert: comparison canUseFastPath.
	self deny: comparison isMatch.
	self assert: comparison mismatchCount equals: 2.
	self assert: comparison mismatchRatio equals: 2 / 100.0.
	self assert: comparison mismatches size equals: 2.
	self assert: comparison mismatches first first equals: 2 @ 2.
	self assert: comparison mismatches second first equals: 3 @ 2
]

{ #category : #tests }
AeImageComparisonTest >> testSuggestedSettings [

	| surface1 surface2 comparison suggestedSettings |
	surface1 := AeCairoImageSurface extent: 10 @ 10 format: AeCairoSurfaceFormat argb32.
	surface2 := AeCairoImageSurface extent: 10 @ 10 format: AeCairoSurfaceFormat argb32.
	surface2 newContext
		sourceColor: Color red;
		rectangle: (2 @ 2 extent: 2 @ 1);
		fill.
	surface2 flush.
	comparison := AeImageComparison expected: surface1 actual: surface2 label: 'myFixture'.
	suggestedSettings := comparison suggestedSettings.
	self assert: suggestedSettings maxMismatchCount equals: 2.
	self assert: suggestedSettings maxMismatchRatio equals: 0.02.
	self assert: (suggestedSettings storeString includesSubstring: 'AeImageMatchSettings').
	self assert: (suggestedSettings storeString includesSubstring: 'maxMismatchCount: 2')
]
