"
I am a Cairo FFI binding for `cairo_font_options_t`.

A `cairo_font_options_t` specify how fonts should be rendered. Most of the time the font options implied by a surface are just right and do not need any changes, but for pixel-based targets tweaking font options may result in superior output on a particular display.

See: https://www.cairographics.org/manual/cairo-cairo-font-options-t.html

"
Class {
	#name : #AeCairoFontOptions,
	#superclass : #FFIExternalObject,
	#traits : 'AeTCairoLibrary + AeTExternalFree',
	#classTraits : 'AeTCairoLibrary classTrait + AeTExternalFree classTrait',
	#category : #'Alexandrie-Cairo-Text'
}

{ #category : #finalization }
AeCairoFontOptions class >> externallyFree: aHandle [
	
	self ffiCall: #( void cairo_font_options_destroy ( void * aHandle ) )
]

{ #category : #'instance creation' }
AeCairoFontOptions class >> new [

	^ self unownedNew
		  autoRelease;
		  yourself
]

{ #category : #'instance creation' }
AeCairoFontOptions class >> unownedNew [

	^ self ffiCall: #( AeCairoFontOptions cairo_font_options_create () )
]

{ #category : #'private - ffi' }
AeCairoFontOptions >> antialias [

	^ self ffiCall: #( AeCairoAntialias cairo_font_options_get_antialias ( self ) )
]

{ #category : #'private - ffi' }
AeCairoFontOptions >> antialias: anAntialias [

	self ffiCall: #(
		void
		cairo_font_options_set_antialias (
			self,
			AeCairoAntialias anAntialias ) )
]

{ #category : #'private - ffi' }
AeCairoFontOptions >> hintMetrics [

	^ self ffiCall: #( AeCairoHintMetrics cairo_font_options_get_hint_metrics ( self ) )
]

{ #category : #'private - ffi' }
AeCairoFontOptions >> hintMetrics: aHintMetrics [

	self ffiCall: #(
		void
		cairo_font_options_set_hint_metrics (
			self,
			AeCairoHintMetrics aHintMetrics ) )
]

{ #category : #'private - ffi' }
AeCairoFontOptions >> hintStyle [

	^ self ffiCall: #( AeCairoHintStyle cairo_font_options_get_hint_style ( self ) )
]

{ #category : #'private - ffi' }
AeCairoFontOptions >> hintStyle: aHintStyle [

	self ffiCall: #(
		void
		cairo_font_options_set_hint_style (
			self,
			AeCairoHintStyle aHintStyle ) )
]

{ #category : #'private - ffi' }
AeCairoFontOptions >> subpixelOrder [

	^ self ffiCall: #( AeCairoSubpixelOrder cairo_font_options_get_subpixel_order ( self ) )
]

{ #category : #'private - ffi' }
AeCairoFontOptions >> subpixelOrder: aSubpixelOrder [

	self ffiCall: #(
		void
		cairo_font_options_set_subpixel_order (
			self,
			AeCairoSubpixelOrder aSubpixelOrder ) )
]
