"
I am a Cairo FFI binding for `cairo_surface_t`.

See: https://www.cairographics.org/manual/cairo-cairo-surface-t.html
"
Class {
	#name : #AeCairoSurface,
	#superclass : #FFIExternalReference,
	#traits : 'AeTCairoLibrary + AeTCairoDestroy',
	#classTraits : 'AeTCairoLibrary classTrait + AeTCairoDestroy classTrait',
	#category : #'Alexandrie-FFI-Surfaces'
}

{ #category : #converting }
AeCairoSurface class >> asExternalTypeOn: generator [
	^ FFIExternalObjectType objectClass: self
]

{ #category : #finalization }
AeCairoSurface class >> primDestroy: aHandle [
	
	self ffiCall: #( void cairo_surface_destroy ( void * aHandle ) )
]

{ #category : #'private - ffi' }
AeCairoSurface >> deviceScale [

	| xPointer yPointer |
	xPointer := FFIFloat64 newBuffer.
	yPointer := FFIFloat64 newBuffer.
	self primGetDeviceScaleX: xPointer y: yPointer.
	^ (xPointer doubleAt: 1) @ (yPointer doubleAt: 1)

]

{ #category : #'private - ffi' }
AeCairoSurface >> deviceScale: aPoint [

	self primSetDeviceScaleX: aPoint x y: aPoint y
]

{ #category : #API }
AeCairoSurface >> flush [

	self primFlush
]

{ #category : #API }
AeCairoSurface >> markDirty [

	self primMarkDirty
]

{ #category : #API }
AeCairoSurface >> newContext [

	^ AeCairoContext create: self
]

{ #category : #'private - ffi' }
AeCairoSurface >> primFlush [

	^ self ffiCall: #(void cairo_surface_flush ( self ) )
]

{ #category : #'private - ffi' }
AeCairoSurface >> primGetDeviceScaleX: xPointer y: yPointer [

	self ffiCall: #(
		void cairo_surface_get_device_scale (
			self,
			double * xPointer,
			double * yPointer ) )

]

{ #category : #'private - ffi' }
AeCairoSurface >> primMarkDirty [
	
	^ self ffiCall: #(void cairo_surface_mark_dirty ( self ) )
]

{ #category : #'private - ffi' }
AeCairoSurface >> primSetDeviceScaleX: xScale y: yScale [
	"Sets a scale that is multiplied to the device coordinates determined by the CTM when drawing to surface. One common use for this is to render to very high resolution display devices at a scale factor, so that code that assumes 1 pixel will be a certain size will still work. Setting a transformation via cairo_translate() isn't sufficient to do this, since functions like cairo_device_to_user() will expose the hidden scale.

Note that the scale affects drawing to the surface as well as using the surface in a source pattern.

	See: https://www.cairographics.org/manual/cairo-cairo-surface-t.html#cairo-surface-set-device-scale"

	self ffiCall: #(
		void cairo_surface_set_device_scale (
			self,
			double xScale,
			double yScale ) )

]
