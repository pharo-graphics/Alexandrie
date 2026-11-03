"
I represent FFI bindings to `hb_gpu_paint_t`.

An opaque GPU color-glyph encoder. I accumulate color-glyph paint state via paint callbacks, then encode it into a compact blob for GPU rendering.

See: https://harfbuzz.github.io/harfbuzz-hb-gpu.html#hb-gpu-paint-t
"
Class {
	#name : #AeHbGpuPaint,
	#superclass : #FFIExternalObject,
	#traits : 'AeTHarfbuzzGPULibrary + AeTExternalFree',
	#classTraits : 'AeTHarfbuzzGPULibrary classTrait + AeTExternalFree classTrait',
	#pools : [
		'AeHbGpuTypes',
		'AeHbTypes'
	],
	#category : #'Alexandrie-HarfbuzzGPU-Core'
}

{ #category : #finalization }
AeHbGpuPaint class >> externallyFree: aHandle [

	self ffiCall: #(void hb_gpu_paint_destroy (void * aHandle))
]

{ #category : #'instance creation' }
AeHbGpuPaint class >> new [

	| instance |
	instance := self unownedNew.

	instance getHandle isNull ifTrue: [
		self error: 'Failed to create hb_gpu_paint_t' ].

	instance autoRelease.

	^ instance
]

{ #category : #shaders }
AeHbGpuPaint class >> paintShaderSourceStage: aStage lang: aLang [

	^ self ffiCall: #(
		String
		hb_gpu_paint_shader_source (
			hb_gpu_shader_stage_t aStage,
			hb_gpu_shader_lang_t  aLang) )
]

{ #category : #'instance creation' }
AeHbGpuPaint class >> unownedNew [

	^ self ffiCall: #(
		hb_gpu_paint_t *
		hb_gpu_paint_create_or_fail (void) )
]

{ #category : #clearing }
AeHbGpuPaint >> clear [

	self ffiCall: #(void hb_gpu_paint_clear (self))
]

{ #category : #palette }
AeHbGpuPaint >> clearCustomPaletteColors [

	self ffiCall: #(void hb_gpu_paint_clear_custom_palette_colors (self))
]

{ #category : #encoding }
AeHbGpuPaint >> encodeExtents: anAeHbGlyphExtentsOrNil [

	| blob |
	blob := self primEncodeExtents: anAeHbGlyphExtentsOrNil.
	blob getHandle isNull ifTrue: [ ^ nil ].
	^ blob
]

{ #category : #private }
AeHbGpuPaint >> getScaleIntoX: xHolder y: yHolder [

	self ffiCall: #(
		void
		hb_gpu_paint_get_scale (
			self,
			int * xHolder,
			int * yHolder) )
]

{ #category : #painting }
AeHbGpuPaint >> paintGlyphFont: anAeHbFont glyph: aGlyphIndex [

	self ffiCall: #(
		void
		hb_gpu_paint_glyph (
			self,
			hb_font_t anAeHbFont,
			hb_codepoint_t aGlyphIndex) )
]

{ #category : #painting }
AeHbGpuPaint >> paintGlyphOrFailFont: anAeHbFont glyph: aGlyphIndex [

	^ self ffiCall: #(
		hb_bool_t
		hb_gpu_paint_glyph_or_fail (
			self,
			hb_font_t anAeHbFont,
			hb_codepoint_t aGlyphIndex) )
]

{ #category : #palette }
AeHbGpuPaint >> palette [

	^ self ffiCall: #(uint hb_gpu_paint_get_palette (self))
]

{ #category : #palette }
AeHbGpuPaint >> palette: aPaletteIndex [

	self ffiCall: #(void hb_gpu_paint_set_palette (self, uint aPaletteIndex))
]

{ #category : #private }
AeHbGpuPaint >> primEncodeExtents: anAeHbGlyphExtentsOrNil [

	^ self ffiCall: #(
		hb_blob_t *
		hb_gpu_paint_encode (
			self,
			hb_glyph_extents_t * anAeHbGlyphExtentsOrNil) )
]

{ #category : #recycling }
AeHbGpuPaint >> recycleBlob: anAeHbBlob [

	self ffiCall: #(
		void
		hb_gpu_paint_recycle_blob (
			self,
			hb_blob_t anAeHbBlob) )
]

{ #category : #refcounting }
AeHbGpuPaint >> reference [

	^ self ffiCall: #(
		hb_gpu_paint_t *
		hb_gpu_paint_reference (self) )
]

{ #category : #clearing }
AeHbGpuPaint >> reset [

	self ffiCall: #(void hb_gpu_paint_reset (self))
]

{ #category : #accessing }
AeHbGpuPaint >> scale [

	| xAddress yAddress |
	xAddress := FFIInt32 newBuffer.
	yAddress := FFIInt32 newBuffer.
	self getScaleIntoX: xAddress y: yAddress.
	^ Point x: (xAddress int32AtOffset: 0) y: (yAddress int32AtOffset: 0)
]

{ #category : #accessing }
AeHbGpuPaint >> scale: aPoint [

	self setScaleX: aPoint x asInteger y: aPoint y asInteger
]

{ #category : #palette }
AeHbGpuPaint >> setCustomPaletteColorIndex: aColorIndex color: aColorUint32 [

	^ self ffiCall: #(
		hb_bool_t
		hb_gpu_paint_set_custom_palette_color (
			self,
			uint aColorIndex,
			uint32 aColorUint32) )
]

{ #category : #private }
AeHbGpuPaint >> setScaleX: anXInteger y: aYInteger [

	self ffiCall: #(
		void
		hb_gpu_paint_set_scale (
			self,
			int anXInteger,
			int aYInteger) )
]
