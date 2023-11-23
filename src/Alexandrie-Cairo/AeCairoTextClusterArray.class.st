"
I'm an array of `AeCairoTextCluster`.
"
Class {
	#name : #AeCairoTextClusterArray,
	#superclass : #AeFFIExternalArray,
	#traits : 'AeTCairoLibrary',
	#classTraits : 'AeTCairoLibrary classTrait',
	#category : #'Alexandrie-Cairo-Text'
}

{ #category : #finalization }
AeCairoTextClusterArray class >> externallyFree: aHandle [
	"See: https://www.cairographics.org/manual/cairo-text.html#cairo-text-cluster-free"

	self ffiCall: #( void cairo_text_cluster_free ( void * aHandle ) )
]

{ #category : #accessing }
AeCairoTextClusterArray class >> initialize [

	resolvedType := self resolveType: AeCairoTextCluster
]
