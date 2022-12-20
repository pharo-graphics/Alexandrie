Class {
	#name : #AeCascadiaCodeDownloadedFont,
	#superclass : #AeDownloadedFont,
	#category : #'Alexandrie-FreeType-Tests-Downloaded'
}

{ #category : #accessing }
AeCascadiaCodeDownloadedFont >> baseUrl [

	^ 'https://github.com/microsoft/cascadia-code/raw/v2111.01/sources/vtt_data/'
]

{ #category : #accessing }
AeCascadiaCodeDownloadedFont >> familyName [
	
	^ 'Cascadia Code'
]

{ #category : #accessing }
AeCascadiaCodeDownloadedFont >> fileName [

	^ 'CascadiaCode_VTT.ttf'
]
