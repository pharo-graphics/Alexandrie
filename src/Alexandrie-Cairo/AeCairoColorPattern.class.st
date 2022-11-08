"
I am a Cairo FFI binding for a `cairo_pattern_t` with a color source.
"
Class {
	#name : #AeCairoColorPattern,
	#superclass : #AeCairoPattern,
	#category : #'Alexandrie-Cairo-Patterns'
}

{ #category : #'instance creation' }
AeCairoColorPattern class >> newFrom: aColor [

	^ aColor isTranslucent
		  ifTrue: [ 
			  AeCairoTranslucentColorPattern
				  r: aColor red
				  g: aColor green
				  b: aColor blue
				  alpha: aColor alpha ]
		  ifFalse: [ 
		  		AeCairoOpaqueColorPattern
					r: aColor red
					g: aColor green
					b: aColor blue ]
]
