"
I am a Cairo FFI binding for a `cairo_pattern_t` with a gradient source.
"
Class {
	#name : #AeCairoGradientPattern,
	#superclass : #AeCairoPattern,
	#category : #'Alexandrie-Cairo-Patterns'
}

{ #category : #accessing }
AeCairoGradientPattern >> addStopAt: offset color: aColor [

	aColor isTranslucent
		ifTrue: [ self addStopAt: offset translucentColor: aColor ]
		ifFalse: [ self addStopAt: offset solidColor: aColor ]
]

{ #category : #accessing }
AeCairoGradientPattern >> addStopAt: offset solidColor: aColor [

	self
		primAddStop: offset
		r: aColor red
		g: aColor green
		b: aColor blue

]

{ #category : #accessing }
AeCairoGradientPattern >> addStopAt: offset translucentColor: aColor [

	self
		primAddStop: offset
		r: aColor red
		g: aColor green
		b: aColor blue
		a: aColor alpha
]

{ #category : #'private - ffi' }
AeCairoGradientPattern >> primAddStop: anOffset r: aRed g: aGreen b: aBlue [

	self ffiCall: #( void cairo_pattern_add_color_stop_rgb (
			self,
			double anOffset,
			double aRed,
			double aGreen,
			double aBlue ) )
]

{ #category : #'private - ffi' }
AeCairoGradientPattern >> primAddStop: anOffset r: aRed g: aGreen b: aBlue a: anAlpha [

	self ffiCall: #( void cairo_pattern_add_color_stop_rgba (
			self,
			double anOffset,
			double aRed,
			double aGreen,
			double aBlue,
			double anAlpha ) )
]
