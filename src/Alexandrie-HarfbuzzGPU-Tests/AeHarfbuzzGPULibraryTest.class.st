"
I test the Harfbuzz-GPU library bindings.
"
Class {
	#name : #AeHarfbuzzGPULibraryTest,
	#superclass : #TestCase,
	#category : #'Alexandrie-HarfbuzzGPU-Tests'
}

{ #category : #tests }
AeHarfbuzzGPULibraryTest >> testDrawShaderSource [

	| source |
	source := AeHbGpuDraw drawShaderSourceStage: AeHbGpuShaderStage fragment lang: AeHbGpuShaderLang hlsl.
	self assert: (source includesSubstring: 'hb_gpu_draw')
]

{ #category : #tests }
AeHarfbuzzGPULibraryTest >> testIsAvailable [

	self assert: AeHarfbuzzGPULibrary isAvailable
]

{ #category : #tests }
AeHarfbuzzGPULibraryTest >> testPaintShaderSource [

	| source |
	source := AeHbGpuPaint paintShaderSourceStage: AeHbGpuShaderStage fragment lang: AeHbGpuShaderLang msl.
	self assert: (source includesSubstring: 'hb_gpu_paint')
]

{ #category : #tests }
AeHarfbuzzGPULibraryTest >> testShaderSource [

	| source |
	source := AeHbGpuDraw shaderSourceStage: AeHbGpuShaderStage vertex lang: AeHbGpuShaderLang msl.
	self assert: (source includesSubstring: 'hb_gpu_dilate')
]
