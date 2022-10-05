"
I represent a FreeType font file whose bytes are embedded in the Pharo code

See hook method in class-side.

Tip for subclasses: Place the corresponding font license on the class comment.
"
Class {
	#name : #AeEmbeddedFontFile,
	#superclass : #Object,
	#category : #'Alexandrie-FreeType-Embedded'
}

{ #category : #accessing }
AeEmbeddedFontFile class >> fontContentsData [
	"Answer a ByteArray with the binary contents of the original font file."

	^ self subclassResponsibility
]

{ #category : #accessing }
AeEmbeddedFontFile class >> fromFileReference: aFileReference [

	"
	AeSourceCodePro_Regular fromFileReference: 'Fonts/source-code-pro-release/TTF/SourceCodePro-Regular.ttf' asFileReference.
	AeSourceCodePro_Bold fromFileReference: 'Fonts/source-code-pro-release/TTF/SourceCodePro-Bold.ttf' asFileReference.
	AeSourceCodePro_Italic fromFileReference: 'Fonts/source-code-pro-release/TTF/SourceCodePro-It.ttf' asFileReference.
	AeSourceSansPro_Regular fromFileReference: 'Fonts/Source_Sans_Pro/SourceSansPro-Regular.ttf' asFileReference.
	AeSourceSansPro_Bold fromFileReference: 'Fonts/Source_Sans_Pro/SourceSansPro-Bold.ttf' asFileReference.
	AeSourceSansPro_Italic fromFileReference: 'Fonts/Source_Sans_Pro/SourceSansPro-Italic.ttf' asFileReference.
	"

	| stream contents sourceCode |
	stream := aFileReference binaryReadStream.
	contents := stream contents.
	sourceCode := String streamContents: [ :str | 
		              str
			              nextPutAll: 'fontContentsData';
			              nextPut: Character cr;
			              nextPut: Character tab;
			              nextPut: $^;
			              nextPut: Character space.
		              contents storeOn: str ].
	self class compile: sourceCode classified: #accessing
]
