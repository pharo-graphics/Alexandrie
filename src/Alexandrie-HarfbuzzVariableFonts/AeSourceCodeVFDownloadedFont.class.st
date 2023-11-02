Class {
	#name : #AeSourceCodeVFDownloadedFont,
	#superclass : #AeDownloadedFont,
	#category : #'Alexandrie-HarfbuzzVariableFonts'
}

{ #category : #accessing }
AeSourceCodeVFDownloadedFont >> baseUrl [

	^ 'https://github.com/adobe-fonts/source-code-pro/raw/2.042R-u/1.062R-i/1.026R-vf/VF/'
]

{ #category : #accessing }
AeSourceCodeVFDownloadedFont >> familyName [
	
	^ 'Source Code VF'
]

{ #category : #accessing }
AeSourceCodeVFDownloadedFont >> fileName [

	^ 'SourceCodeVF-Upright.otf'
]
