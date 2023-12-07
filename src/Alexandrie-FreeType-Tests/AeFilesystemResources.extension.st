Extension { #name : #AeFilesystemResources }

{ #category : #'*Alexandrie-FreeType-Tests' }
AeFilesystemResources class >> downloadedFontsDirectory [

	^ self fontsDirectory / 'downloaded'
]

{ #category : #'*Alexandrie-FreeType-Tests' }
AeFilesystemResources class >> fontsDirectory [

	^ self testsDirectory / 'fonts'
]

{ #category : #'*Alexandrie-FreeType-Tests' }
AeFilesystemResources class >> inriaSerifRegularTTF [

	^ self fontsDirectory / 'inria-serif' / 'InriaSerif' / 'TTF' / 'InriaSerif-Regular.ttf'
]
