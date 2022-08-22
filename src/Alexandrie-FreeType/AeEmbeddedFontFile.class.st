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
