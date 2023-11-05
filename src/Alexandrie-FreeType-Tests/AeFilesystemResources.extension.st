Extension { #name : #AeFilesystemResources }

{ #category : #'*Alexandrie-FreeType-Tests' }
AeFilesystemResources classSide >> downloadedFontsDirectory [

	^ self fontsDirectory / 'downloaded'
]

{ #category : #'*Alexandrie-FreeType-Tests' }
AeFilesystemResources classSide >> fontsDirectory [

	^ self testsDirectory / 'fonts'
]

{ #category : #'*Alexandrie-FreeType-Tests' }
AeFilesystemResources classSide >> inriaSerifRegularTTF [

	^ self fontsDirectory / 'inria-serif' / 'InriaSerif' / 'TTF' / 'InriaSerif-Regular.ttf'
]
