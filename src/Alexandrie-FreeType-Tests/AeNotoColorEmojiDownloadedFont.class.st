Class {
	#name : #AeNotoColorEmojiDownloadedFont,
	#superclass : #AeDownloadedFont,
	#category : #'Alexandrie-FreeType-Tests'
}

{ #category : #accessing }
AeNotoColorEmojiDownloadedFont >> baseUrl [

	^ 'https://github.com/googlefonts/noto-emoji/raw/v2018-08-10-unicode11/fonts/'
]

{ #category : #accessing }
AeNotoColorEmojiDownloadedFont >> familyName [
	
	^ 'Noto Color Emoji'
]

{ #category : #accessing }
AeNotoColorEmojiDownloadedFont >> fileName [
	
	^ 'NotoColorEmoji.ttf'
]
