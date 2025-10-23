"
I represent a FreeType font file whose bytes are embedded in the Pharo code

Note that a each font file may contain multiple faces.

See hook method in class-side.

Tip for subclasses: Place the corresponding font license on the class comment.
"
Class {
	#name : #AeEmbeddedFontFile,
	#superclass : #Object,
	#category : #'Alexandrie-Fonts'
}

{ #category : #accessing }
AeEmbeddedFontFile class >> fontContentsData [
	"Answer a ByteArray with the binary contents of the original font file."

	^ self subclassResponsibility
]

{ #category : #importing }
AeEmbeddedFontFile class >> fromFileReference: aFileReference [
	"Compile a #fontContentsData that answers the contents of the from a fonts file.

	Examples:

		AeSourceCodePro_Regular fromFileReference:
			'fonts/SourceCodePro-Regular.ttf' asFileReference.
		AeSourceCodePro_Bold fromFileReference:
			'fonts/SourceCodePro-Bold.ttf' asFileReference.
		AeSourceCodePro_Italic fromFileReference:
			'fonts/SourceCodePro-It.ttf' asFileReference.
		AeSourceSansPro_Regular fromFileReference:
			'fonts/SourceSansPro-Regular.ttf' asFileReference.
		AeSourceSansPro_Bold fromFileReference:
			'fonts/SourceSansPro-Bold.ttf' asFileReference.
		AeSourceSansPro_Italic fromFileReference:
			'fonts/SourceSansPro-Italic.ttf' asFileReference.
	"

	| stream contents sourceCode |
	stream := aFileReference binaryReadStream.
	contents := stream contents.
	sourceCode := String streamContents: [ :str | 
		              str
			              nextPutAll: #fontContentsData;
			              nextPut: Character cr;
			              nextPut: Character tab;
			              nextPut: $^;
			              nextPut: Character space.
		              contents storeOn: str ].
	self class compile: sourceCode classified: #accessing
]

{ #category : #accessing }
AeEmbeddedFontFile class >> numberOfFaces [
	"Answer the number of faces in the fontContentsData.
	This is redundant as the user can retrieve this information from the `#fontContentsData`.
	The way to do it is: create a face with index zero, and query such instance `AeFTFace>>#numberOfFaces`."

	^ 1
]
