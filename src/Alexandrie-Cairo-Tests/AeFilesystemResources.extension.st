Extension { #name : #AeFilesystemResources }

{ #category : #'*Alexandrie-Cairo-Tests' }
AeFilesystemResources class >> cairoDirectory [ 

	^ self testsDirectory / 'cairo'
]

{ #category : #'*Alexandrie-Cairo-Tests' }
AeFilesystemResources class >> imagesDirectory [ 

	^ self testsDirectory / 'images'
]

{ #category : #'*Alexandrie-Cairo-Tests' }
AeFilesystemResources class >> removeIconPNG [

	^ self imagesDirectory / 'removeIcon.png'
]
