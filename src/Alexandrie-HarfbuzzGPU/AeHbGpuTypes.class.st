"
I am a shared pool of Harfbuzz-GPU types for FFI callouts.
"
Class {
	#name : #AeHbGpuTypes,
	#superclass : #SharedPool,
	#classVars : [
		'hb_glyph_extents_t',
		'hb_gpu_draw_t',
		'hb_gpu_paint_t',
		'hb_gpu_shader_lang_t',
		'hb_gpu_shader_stage_t'
	],
	#category : #'Alexandrie-HarfbuzzGPU-Library'
}

{ #category : #initialization }
AeHbGpuTypes class >> initialize [

	hb_glyph_extents_t := AeHbGlyphExtents.
	hb_gpu_shader_lang_t := AeHbGpuShaderLang.
	hb_gpu_shader_stage_t := AeHbGpuShaderStage.
	hb_gpu_draw_t := AeHbGpuDraw.
	hb_gpu_paint_t := AeHbGpuPaint
]
