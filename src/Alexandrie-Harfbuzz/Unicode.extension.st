Extension { #name : #Unicode }

{ #category : #'*Alexandrie-Harfbuzz' }
Unicode class >> zeroWidthSeparator [
	"See: https://en.wikipedia.org/wiki/Zero-width_joiner"

	"TODO: make a class var?"
	^ self value: 16r200D
]
