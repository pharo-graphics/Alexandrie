Class {
	#name : #AthensAeCairoPatternPaint,
	#superclass : #AthensAeCairoPaint,
	#category : #'Alexandrie-Athens'
}

{ #category : #setting }
AthensAeCairoPatternPaint >> noRepeat [

	cairoPattern extendNone
]

{ #category : #setting }
AthensAeCairoPatternPaint >> reflect [

	cairoPattern extendReflect
]

{ #category : #setting }
AthensAeCairoPatternPaint >> repeat [

	cairoPattern extendRepeat
]
