"
I am a Cairo FFI binding for `cairo_surface_t`.

See: https://www.cairographics.org/manual/cairo-cairo-surface-t.html
"
Class {
	#name : #AeCairoSurface,
	#superclass : #FFIExternalObject,
	#traits : 'AeTCairoLibrary + AeTExternalFree',
	#classTraits : 'AeTCairoLibrary classTrait + AeTExternalFree classTrait',
	#category : #'Alexandrie-Cairo-Surfaces'
}

{ #category : #finalization }
AeCairoSurface class >> externallyFree: aHandle [
	
	self ffiCall: #( void cairo_surface_destroy ( void * aHandle ) )
]

{ #category : #'instance creation' }
AeCairoSurface class >> newSimilarTo: aSurface contentType: aContent width: aWidth height: aHeight [

	^ (self
		   unownedNewSimilarTo: aSurface
		   contentType: aContent
		   width: aWidth
		   height: aHeight)
		  autoRelease;
		  yourself
]

{ #category : #'instance creation' }
AeCairoSurface class >> unownedNewSimilarTo: aSurface contentType: aContentType width: aWidth height: aHeight [
	"Create a new surface that is as compatible as possible with an existing surface. For example the new surface will have the same device scale, fallback resolution and font options as other . Generally, the new surface will also use the same backend as other , unless that is not possible for some reason. The type of the returned surface may be examined with cairo_surface_get_type().

	Initially the surface contents are all 0 (transparent if contents have transparency, black otherwise).
	
	Return a pointer to the newly allocated surface. The caller owns the surface and should call cairo_surface_destroy() when done with it.

	This function always returns a valid pointer, but it will return a pointer to a ""nil"" surface if other is already in an error state or any other error occurs.

	See: https://www.cairographics.org/manual/cairo-cairo-surface-t.html#cairo-surface-create-similar"

	^ self ffiCall: #(
		AeCairoSurface
		cairo_surface_create_similar (
			AeCairoSurface * aSurface
			AeCairoContent	aContentType,
			int aWidth,
			int aHeight ) )
]

{ #category : #API }
AeCairoSurface >> device [
	"Return the device for surface, or NULL if the surface does not have an associated device.

	See: https://www.cairographics.org/manual/cairo-cairo-surface-t.html#cairo-surface-get-device"

	^ self ffiCall: #( AeCairoDevice cairo_surface_get_device ( self ) )

]

{ #category : #'private - ffi' }
AeCairoSurface >> deviceScale [

	| xPointer yPointer |
	xPointer := FFIFloat64 newBuffer.
	yPointer := FFIFloat64 newBuffer.
	self getDeviceScaleOnX: xPointer onY: yPointer.
	^ (xPointer doubleAt: 1) @ (yPointer doubleAt: 1)

]

{ #category : #'private - ffi' }
AeCairoSurface >> deviceScale: aPoint [

	self deviceScaleX: aPoint x y: aPoint y
]

{ #category : #'private - ffi' }
AeCairoSurface >> deviceScaleX: xScale y: yScale [
	"Sets a scale that is multiplied to the device coordinates determined by the CTM when drawing to surface. One common use for this is to render to very high resolution display devices at a scale factor, so that code that assumes 1 pixel will be a certain size will still work. Setting a transformation via cairo_translate() isn't sufficient to do this, since functions like cairo_device_to_user() will expose the hidden scale.

Note that the scale affects drawing to the surface as well as using the surface in a source pattern.

	See: https://www.cairographics.org/manual/cairo-cairo-surface-t.html#cairo-surface-set-device-scale"

	self ffiCall: #(
		void
		cairo_surface_set_device_scale (
			self,
			double xScale,
			double yScale ) )
]

{ #category : #initialization }
AeCairoSurface >> finish [
	"Finish the surface and drop all references to external resources.
	
	When the last call to `cairo_surface_destroy()` decreases the reference count to zero, cairo will call `cairo_surface_finish()` if it hasn't been called already, before freeing the resources associated with the surface.
	
	See: https://www.cairographics.org/manual/cairo-cairo-surface-t.html#cairo-surface-finish"

	self ffiCall: #( void cairo_surface_finish ( self ) )
]

{ #category : #'private - ffi' }
AeCairoSurface >> flush [

	self ffiCall: #( void cairo_surface_flush ( self ) )
]

{ #category : #'private - ffi' }
AeCairoSurface >> getDeviceScaleOnX: xPointer onY: yPointer [

	self ffiCall: #(
		void
		cairo_surface_get_device_scale (
			self,
			double * xPointer,
			double * yPointer ) )

]

{ #category : #API }
AeCairoSurface >> hasDevice [
	"Answer whether I have an associated device.

	See: https://www.cairographics.org/manual/cairo-cairo-surface-t.html#cairo-surface-get-device"

	^ self device getHandle isNull not
]

{ #category : #'private - ffi' }
AeCairoSurface >> markDirty [
	
	self ffiCall: #( void cairo_surface_mark_dirty ( self ) )
]

{ #category : #API }
AeCairoSurface >> newContext [

	^ AeCairoContext newFor: self
]

{ #category : #'private - ffi' }
AeCairoSurface >> status [

	^ self ffiCall: #( AeCairoStatus cairo_surface_status ( self ) )
]
