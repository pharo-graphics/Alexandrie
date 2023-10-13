Extension { #name : #Color }

{ #category : #'*Alexandrie-Cairo' }
Color >> asPremultipliedARGB32Integer [
	"Convert to an Integer as a cairo image ARGB32 would use internally.
	
	Color red asPremultipliedARGB32Integer --> 16rffff0000.
	(Color red alpha: 0.9) asPremultipliedARGB32Integer --> 16re5e50000.
	"

	| a r g b |
	self isTranslucent
		ifTrue: [
			| premAlpha |
			premAlpha := 255.0 * self alpha.
			a := premAlpha rounded bitShift: 24.
			r := (premAlpha * self red)   rounded bitShift: 16.
			g := (premAlpha * self green) rounded bitShift: 8.
			b := (premAlpha * self blue)  rounded ]
		ifFalse: [
			a := 16rFF000000.
			r := (255.0 * self red)   rounded bitShift: 16.
			g := (255.0 * self green) rounded bitShift: 8.
			b := (255.0 * self blue)  rounded ].
	
	^ a + r + g + b
]
