Extension { #name : #AeHbCairoExample }

{ #category : #'*Alexandrie-HarfbuzzVariableFonts' }
AeHbCairoExample class >> exampleDrawVariableFont [

	| fileReference hbBlob hbFace hbFont variations |
	fileReference := AeSourceCodeVFDownloadedFont new
		downloadDirectory: AeFilesystemResources downloadedFontsDirectory;
		ensureDownloaded;
		fileReference.
	hbBlob := AeHbBlob newLocatedAt: fileReference.
	hbFace := hbBlob newHbFaceAtIndex: 0.

	#("defaultValue" minValue maxValue) do: [ :eachSelector |
		hbFont := hbFace newHbFont.
		variations := FFIExternalArray
			newType: AeHbVariableFontVariation
			size: hbFace variableFontAxisCount.
		hbFace axisInfos withIndexDo: [ :eachAxisInfo :oneBasedIndex |
			(variations
				at: oneBasedIndex)
					tag: eachAxisInfo tag;
					value: (eachAxisInfo perform: eachSelector) ].
		hbFont variations: variations.
		
		self exampleDraw: 'Variable Font' font: hbFont fontSize: 70 ].

]

{ #category : #'*Alexandrie-HarfbuzzVariableFonts' }
AeHbCairoExample class >> exampleDrawVariableFontAnimated [

	| fileReference hbBlob hbFace cairoSurface example |
	fileReference := AeSourceCodeVFDownloadedFont new
		downloadDirectory: AeFilesystemResources downloadedFontsDirectory;
		ensureDownloaded;
		fileReference.
	hbBlob := AeHbBlob newLocatedAt: fileReference.
	hbFace := hbBlob newHbFaceAtIndex: 0.

	cairoSurface := AeCairoImageSurface
		extent: 450 @ 100
		format: AeCairoSurfaceFormat rgb24.
	
	example := self
			newWith: 'Width Axis'
			font: hbFace newHbFont
			fontSize: 70
			cairoContext: cairoSurface newContext.

	cairoSurface inspect.
	
	[
	3 timesRepeat: [| axis interval |
		axis := hbFace axisInfos first.
		interval := axis minValue to: axis maxValue by: 10.
		interval, interval reversed do: [ :each |
			example font:
				(hbFace newHbFont
					variationAtTagString: 'wght' put: each;
					yourself).
			example
				clearSurface;
				drawText.
			10 milliSeconds wait ]] ] fork
]
