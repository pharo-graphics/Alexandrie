"
I am a Cairo FFI binding for `cairo_font_options_t`.

A `cairo_font_options_t` specify how fonts should be rendered. Most of the time the font options implied by a surface are just right and do not need any changes, but for pixel-based targets tweaking font options may result in superior output on a particular display.

See: https://www.cairographics.org/manual/cairo-cairo-font-options-t.html

"
Class {
	#name : #AeCairoFontOptions,
	#superclass : #FFIExternalObject,
	#traits : 'AeTCairoLibrary + AeTCairoDestroy',
	#classTraits : 'AeTCairoLibrary classTrait + AeTCairoDestroy classTrait',
	#category : #'Alexandrie-Cairo-Text'
}

{ #category : #'instance creation' }
AeCairoFontOptions class >> new [

	^ self primCreate
		  autoRelease;
		  yourself
]

{ #category : #'private - ffi' }
AeCairoFontOptions class >> primCreate [

	^ self ffiCall: #( AeCairoFontOptions cairo_font_options_create () )
]

{ #category : #finalization }
AeCairoFontOptions class >> primDestroy: aHandle [
	
	 self ffiCall: #(void cairo_font_options_destroy ( void* aHandle) )
]

{ #category : #accessing }
AeCairoFontOptions >> antialias [

	^ self primGetAntialias
]

{ #category : #accessing }
AeCairoFontOptions >> antialias: aCairoAntialias [

	self primSetAntialias: aCairoAntialias
]

{ #category : #accessing }
AeCairoFontOptions >> hintMetrics [

	^ self primGetHintMetrics
]

{ #category : #accessing }
AeCairoFontOptions >> hintMetrics: aCairoHintMetrics [

	self primSetHintMetrics: aCairoHintMetrics
]

{ #category : #accessing }
AeCairoFontOptions >> hintStyle [

	^ self primGetHintStyle
]

{ #category : #accessing }
AeCairoFontOptions >> hintStyle: aCairoHintStyle [

	self primSetHintStyle: aCairoHintStyle
]

{ #category : #'private - ffi' }
AeCairoFontOptions >> primGetAntialias [

	^ self ffiCall: #(AeCairoAntialias cairo_font_options_get_antialias ( self ) )
]

{ #category : #'private - ffi' }
AeCairoFontOptions >> primGetHintMetrics [

	^ self ffiCall: #(AeCairoHintMetrics cairo_font_options_get_hint_metrics ( self ) )
]

{ #category : #'private - ffi' }
AeCairoFontOptions >> primGetHintStyle [

	^ self ffiCall: #(AeCairoHintStyle cairo_font_options_get_hint_style ( self ) )
]

{ #category : #'private - ffi' }
AeCairoFontOptions >> primGetSubpixelOrder [

	^ self ffiCall: #(AeCairoSubpixelOrder cairo_font_options_get_subpixel_order ( self ) )
]

{ #category : #'private - ffi' }
AeCairoFontOptions >> primSetAntialias: anAntialias [

	self ffiCall: #(void cairo_font_options_set_antialias ( self, AeCairoAntialias anAntialias) )
]

{ #category : #'private - ffi' }
AeCairoFontOptions >> primSetHintMetrics: aHintMetrics [

	self ffiCall: #(void cairo_font_options_set_hint_metrics ( self, AeCairoHintMetrics aHintMetrics) )
]

{ #category : #'private - ffi' }
AeCairoFontOptions >> primSetHintStyle: aHintStyle [

	self ffiCall: #(void cairo_font_options_set_hint_style ( self, AeCairoHintStyle aHintStyle ) )
]

{ #category : #'private - ffi' }
AeCairoFontOptions >> primSetSubpixelOrder: aSubpixelOrder [

	self ffiCall: #(void cairo_font_options_set_subpixel_order ( self, AeCairoSubpixelOrder aSubpixelOrder ) )
]

{ #category : #accessing }
AeCairoFontOptions >> subpixelOrder [

	^ self primGetSubpixelOrder
]

{ #category : #accessing }
AeCairoFontOptions >> subpixelOrder: aSubpixelOrder [

	self primSetSubpixelOrder: aSubpixelOrder
]
