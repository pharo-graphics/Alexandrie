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
