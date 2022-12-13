Extension { #name : #Unicode }

{ #category : #'*Alexandrie-Harfbuzz' }
Unicode class >> zeroWidthJoiner [
	"The zero-width joiner is a non-printing character used in the computerized typesetting of writing systems in which the shape or positioning of a grapheme depends on its relation to other graphemes.
	
	See: https://en.wikipedia.org/wiki/Zero-width_joiner"

	^ self value: 16r200D
]
