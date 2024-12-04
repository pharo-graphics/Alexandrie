Class {
	#name : #AeFontManagerInspectionTest,
	#superclass : #TestCase,
	#category : #'Alexandrie-NewTools-Tests'
}

{ #category : #tests }
AeFontManagerInspectionTest >> testInspectFaces [

	| aManager aPresenter |
	aManager := AeFontManager new.
	aManager
		scanDirectory: AeFilesystemResources fontsDirectory;
		scanEmbeddedFonts.

	aPresenter := aManager inspectionFaces: SpPresenter new.

	self assert: aPresenter class equals: SpTablePresenter.

	self
		assert: (aPresenter items
			collect: [ :each |
				{ each familyName.
				each slantName.
				each weightName.
				each stretchName } ])
		equals: #(
			#('Cascadia Code' #normal #normal #normal)
			#('Inria Serif' #normal #light #normal)
			#('Inria Serif' #normal #normal #normal)
			#('Inria Serif' #normal #bold #normal)
			#('Inria Serif' #italic #light #normal)
			#('Inria Serif' #italic #normal #normal)
			#('Inria Serif' #italic #bold #normal)
			#('Noto Color Emoji' #normal #normal #normal)
			#('Source Code Pro' #normal #normal #normal)
			#('Source Code Pro' #normal #bold #normal)
			#('Source Code Pro' #italic #normal #normal)
			#('Source Sans Pro' #normal #normal #normal)
			#('Source Sans Pro' #normal #bold #normal)
			#('Source Sans Pro' #italic #normal #normal))
]
