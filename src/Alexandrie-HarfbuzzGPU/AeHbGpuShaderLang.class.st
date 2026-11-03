"
I represent FFI bindings to `hb_gpu_shader_lang_t` enum: Shader language variant.

See: https://harfbuzz.github.io/harfbuzz-hb-gpu.html#hb-gpu-shader-lang-t
"
Class {
	#name : #AeHbGpuShaderLang,
	#superclass : #AeEnumeration,
	#classVars : [
		'HB_GPU_SHADER_LANG_GLSL',
		'HB_GPU_SHADER_LANG_HLSL',
		'HB_GPU_SHADER_LANG_INVALID',
		'HB_GPU_SHADER_LANG_MSL',
		'HB_GPU_SHADER_LANG_WGSL'
	],
	#category : #'Alexandrie-HarfbuzzGPU-Enumerations'
}

{ #category : #'accessing enum' }
AeHbGpuShaderLang class >> HB_GPU_SHADER_LANG_GLSL [
	"This method was automatically generated"
	^ HB_GPU_SHADER_LANG_GLSL
]

{ #category : #'accessing enum' }
AeHbGpuShaderLang class >> HB_GPU_SHADER_LANG_HLSL [
	"This method was automatically generated"
	^ HB_GPU_SHADER_LANG_HLSL
]

{ #category : #'accessing enum' }
AeHbGpuShaderLang class >> HB_GPU_SHADER_LANG_INVALID [
	"This method was automatically generated"
	^ HB_GPU_SHADER_LANG_INVALID
]

{ #category : #'accessing enum' }
AeHbGpuShaderLang class >> HB_GPU_SHADER_LANG_MSL [
	"This method was automatically generated"
	^ HB_GPU_SHADER_LANG_MSL
]

{ #category : #'accessing enum' }
AeHbGpuShaderLang class >> HB_GPU_SHADER_LANG_WGSL [
	"This method was automatically generated"
	^ HB_GPU_SHADER_LANG_WGSL
]

{ #category : #'enum declaration' }
AeHbGpuShaderLang class >> enumDecl [
	"
	self rebuildEnumAccessors
	"

	^ #( HB_GPU_SHADER_LANG_INVALID 0 HB_GPU_SHADER_LANG_GLSL 1 HB_GPU_SHADER_LANG_WGSL 2 HB_GPU_SHADER_LANG_MSL
	     3 HB_GPU_SHADER_LANG_HLSL 4 )
]

{ #category : #'accessing enum' }
AeHbGpuShaderLang class >> glsl [

	^ HB_GPU_SHADER_LANG_GLSL
]

{ #category : #'accessing enum' }
AeHbGpuShaderLang class >> hlsl [

	^ HB_GPU_SHADER_LANG_HLSL
]

{ #category : #'accessing enum' }
AeHbGpuShaderLang class >> invalid [

	^ HB_GPU_SHADER_LANG_INVALID
]

{ #category : #'accessing enum' }
AeHbGpuShaderLang class >> msl [

	^ HB_GPU_SHADER_LANG_MSL
]

{ #category : #hook }
AeHbGpuShaderLang class >> underlinedNamePrefix [

	^ 'HB_GPU_SHADER_LANG_'
]

{ #category : #'accessing enum' }
AeHbGpuShaderLang class >> wgsl [

	^ HB_GPU_SHADER_LANG_WGSL
]
