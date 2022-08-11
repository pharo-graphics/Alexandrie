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
