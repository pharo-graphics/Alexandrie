"
I represent FFI bindings to `hb_gpu_draw_t`.

An opaque GPU shape encoder. I accumulate outlines via draw callbacks, then encode them into a compact blob for GPU rendering.

See: https://harfbuzz.github.io/harfbuzz-hb-gpu.html#hb-gpu-draw-t
"
Class {
	#name : #AeHbGpuDraw,
	#superclass : #FFIExternalObject,
	#traits : 'AeTHarfbuzzGPULibrary + AeTExternalFree',
	#classTraits : 'AeTHarfbuzzGPULibrary classTrait + AeTExternalFree classTrait',
	#pools : [
		'AeHbGpuTypes',
		'AeHbTypes'
	],
	#category : #'Alexandrie-HarfbuzzGPU-Core'
}

{ #category : #shaders }
AeHbGpuDraw class >> drawShaderSourceStage: aStage lang: aLang [

	^ self ffiCall: #(
		String
		hb_gpu_draw_shader_source (
			hb_gpu_shader_stage_t aStage,
			hb_gpu_shader_lang_t  aLang) )
]

{ #category : #finalization }
AeHbGpuDraw class >> externallyFree: aHandle [

	self ffiCall: #(void hb_gpu_draw_destroy (void * aHandle))
]

{ #category : #'instance creation' }
AeHbGpuDraw class >> new [

	| instance |
	instance := self unownedNew.

	instance getHandle isNull ifTrue: [
		self error: 'Failed to create hb_gpu_draw_t' ].

	instance autoRelease.

	^ instance
]

{ #category : #shaders }
AeHbGpuDraw class >> shaderSourceStage: aStage lang: aLang [

	^ self ffiCall: #(
		String
		hb_gpu_shader_source (
			hb_gpu_shader_stage_t aStage,
			hb_gpu_shader_lang_t  aLang) )
]

{ #category : #'instance creation' }
AeHbGpuDraw class >> unownedNew [

	^ self ffiCall: #(
		hb_gpu_draw_t *
		hb_gpu_draw_create_or_fail (void) )
]

{ #category : #clearing }
AeHbGpuDraw >> clear [

	self ffiCall: #(void hb_gpu_draw_clear (self))
]

{ #category : #drawing }
AeHbGpuDraw >> drawGlyphFont: anAeHbFont glyph: aGlyphIndex [

	self ffiCall: #(
		void
		hb_gpu_draw_glyph (
			self,
			hb_font_t anAeHbFont,
			hb_codepoint_t aGlyphIndex) )
]

{ #category : #drawing }
AeHbGpuDraw >> drawGlyphOrFailFont: anAeHbFont glyph: aGlyphIndex [

	^ self ffiCall: #(
		hb_bool_t
		hb_gpu_draw_glyph_or_fail (
			self,
			hb_font_t anAeHbFont,
			hb_codepoint_t aGlyphIndex) )
]

{ #category : #encoding }
AeHbGpuDraw >> encodeExtents: anAeHbGlyphExtentsOrNil [

	| blob |
	blob := self primEncodeExtents: anAeHbGlyphExtentsOrNil.
	blob getHandle isNull ifTrue: [ ^ nil ].
	^ blob
]

{ #category : #private }
AeHbGpuDraw >> getScaleIntoX: xHolder y: yHolder [

	self ffiCall: #(
		void
		hb_gpu_draw_get_scale (
			self,
			int * xHolder,
			int * yHolder) )
]

{ #category : #private }
AeHbGpuDraw >> primEncodeExtents: anAeHbGlyphExtentsOrNil [

	^ self ffiCall: #(
		hb_blob_t *
		hb_gpu_draw_encode (
			self,
			hb_glyph_extents_t * anAeHbGlyphExtentsOrNil) )
]

{ #category : #recycling }
AeHbGpuDraw >> recycleBlob: anAeHbBlob [

	self ffiCall: #(
		void
		hb_gpu_draw_recycle_blob (
			self,
			hb_blob_t anAeHbBlob) )
]

{ #category : #refcounting }
AeHbGpuDraw >> reference [

	^ self ffiCall: #(
		hb_gpu_draw_t *
		hb_gpu_draw_reference (self) )
]

{ #category : #clearing }
AeHbGpuDraw >> reset [

	self ffiCall: #(void hb_gpu_draw_reset (self))
]

{ #category : #accessing }
AeHbGpuDraw >> scale [

	| xAddress yAddress |
	xAddress := FFIInt32 newBuffer.
	yAddress := FFIInt32 newBuffer.
	self getScaleIntoX: xAddress y: yAddress.
	^ Point x: (xAddress int32AtOffset: 0) y: (yAddress int32AtOffset: 0)
]

{ #category : #accessing }
AeHbGpuDraw >> scale: aPoint [

	self setScaleX: aPoint x asInteger y: aPoint y asInteger
]

{ #category : #private }
AeHbGpuDraw >> setScaleX: anXInteger y: aYInteger [

	self ffiCall: #(
		void
		hb_gpu_draw_set_scale (
			self,
			int anXInteger,
			int aYInteger) )
]
