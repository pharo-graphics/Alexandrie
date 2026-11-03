"
I represent FFI bindings to `hb_gpu_shader_stage_t` enum: Shader pipeline stage.

See: https://harfbuzz.github.io/harfbuzz-hb-gpu.html#hb-gpu-shader-stage-t
"
Class {
	#name : #AeHbGpuShaderStage,
	#superclass : #AeEnumeration,
	#classVars : [
		'HB_GPU_SHADER_STAGE_FRAGMENT',
		'HB_GPU_SHADER_STAGE_VERTEX'
	],
	#category : #'Alexandrie-HarfbuzzGPU-Enumerations'
}

{ #category : #'accessing enum' }
AeHbGpuShaderStage class >> HB_GPU_SHADER_STAGE_FRAGMENT [
	"This method was automatically generated"
	^ HB_GPU_SHADER_STAGE_FRAGMENT
]

{ #category : #'accessing enum' }
AeHbGpuShaderStage class >> HB_GPU_SHADER_STAGE_VERTEX [
	"This method was automatically generated"
	^ HB_GPU_SHADER_STAGE_VERTEX
]

{ #category : #'enum declaration' }
AeHbGpuShaderStage class >> enumDecl [
	"
	self rebuildEnumAccessors
	"

	^ #( HB_GPU_SHADER_STAGE_VERTEX 0 HB_GPU_SHADER_STAGE_FRAGMENT 1 )
]

{ #category : #'accessing enum' }
AeHbGpuShaderStage class >> fragment [

	^ HB_GPU_SHADER_STAGE_FRAGMENT
]

{ #category : #hook }
AeHbGpuShaderStage class >> underlinedNamePrefix [

	^ 'HB_GPU_SHADER_STAGE_'
]

{ #category : #'accessing enum' }
AeHbGpuShaderStage class >> vertex [

	^ HB_GPU_SHADER_STAGE_VERTEX
]
