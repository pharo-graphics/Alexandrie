Class {
	#name : #AeTestFontDownloader,
	#superclass : #Object,
	#category : #'Alexandrie-FreeType-Tests'
}

{ #category : #'as yet unclassified' }
AeTestFontDownloader >> download [

	self downloadDirectory ensureCreateDirectory.

	'Downloading Emoji Color Font...' traceCr.
	[	ZnClient new
			url: 'https://github.com/googlefonts/noto-emoji/raw/v2018-08-10-unicode11/fonts/NotoColorEmoji.ttf';
			signalProgress: true;
			numberOfRetries: 5;
			timeout: 100;
			logToTranscript;
			downloadTo: self downloadDirectory / 'NotoColorEmoji.ttf'] timeToRun traceCr.

]

{ #category : #'as yet unclassified' }
AeTestFontDownloader >> downloadDirectory [

	^ AeFilesytemResources fontsDirectory / 'downloaded'
]
