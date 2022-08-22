"
I am a Cairo FFI binding for an Image `cairo_surface_t`.

See: https://www.cairographics.org/manual/cairo-Image-Surfaces.html
"
Class {
	#name : #AeCairoImageSurface,
	#superclass : #AeCairoSurface,
	#category : #'Alexandrie-Cairo-Surfaces'
}

{ #category : #'instance creation' }
AeCairoImageSurface class >> createExtent: anExtent format: aSurfaceFormat [

	^ (self
		   primCreateWidth: anExtent x
		   height: anExtent y
		   format: aSurfaceFormat)
		  autoRelease;
		  yourself
]

{ #category : #'instance creation' }
AeCairoImageSurface class >> extent: aPoint [

	^ self
		  createExtent: aPoint
		  format: AeCairoSurfaceFormat CAIRO_FORMAT_ARGB32
]

{ #category : #'instance creation' }
AeCairoImageSurface class >> fromForm: aForm [

	| form aSurface newBits |
	form := aForm unhibernate; asFormOfDepth: 32.

	aSurface := AeCairoImageSurface
		createExtent: aForm extent
		format: AeCairoSurfaceFormat CAIRO_FORMAT_ARGB32.
	
	"Convert form bits with premultiplied alpha"
	newBits := form bits collect: [ :pixel |
		| alpha r g b |
		alpha := (pixel >> 24) / 255.
		
		r := ( (pixel bitAnd: 255) * alpha ) asInteger.
		g := ( (pixel >>8 bitAnd: 255) * alpha ) asInteger.
		b := ( (pixel >>16 bitAnd: 255) * alpha ) asInteger.
		
		(pixel bitAnd: 16rFF000000) + (b<<16) + (g<<8) + r ].
	
	LibC
		memCopy: newBits
		to: aSurface primData getHandle
		size: (form width * form height * 4).
	
	^ aSurface
		markDirty;
		yourself
]

{ #category : #'instance creation' }
AeCairoImageSurface class >> newForData: aData extent: aPoint stride: stride format: aSurfaceFormat [

	^ (self
		   primCreateForData: aData
		   width: aPoint x
		   height: aPoint y
		   stride: stride
		   format: aSurfaceFormat)
		  autoRelease;
		  yourself
]

{ #category : #'private - ffi' }
AeCairoImageSurface class >> primCreateForData: aData width: width height: height stride: stride format: aSurfaceFormat [

	^ self ffiCall: #( AeCairoImageSurface cairo_image_surface_create_for_data (
		void* aData,
		AeCairoSurfaceFormat aSurfaceFormat,
		int width,
		int height,
		int stride) )
]

{ #category : #'private - ffi' }
AeCairoImageSurface class >> primCreateWidth: aWidth height: aHeight format: aSurfaceFormat [

	^ self ffiCall: #( AeCairoImageSurface cairo_image_surface_create (
		AeCairoSurfaceFormat	aSurfaceFormat,
		int	 aWidth,
		int	 aHeight ) )
]

{ #category : #'private - fii' }
AeCairoImageSurface class >> primStrideForWidth: aWidth format: aSurfaceFormat [

	^ self ffiCall: #( int cairo_format_stride_for_width (
		AeCairoSurfaceFormat	aSurfaceFormat,
		int	 aWidth ) )
]

{ #category : #converting }
AeCairoImageSurface >> asForm [
	"Answer a Form with a copy of my current pixels.
	Only implemented for ARGB32 format, i.e.:
		self format = AeCairoSurfaceFormat CAIRO_FORMAT_ARGB32
	"
	| theData aBitmap |
	self flush.

	theData := FFIExternalArray
		fromHandle: self primData getHandle
		type: FFIUInt32
		size: self primHeight * self primStride / 4.
	aBitmap := Bitmap newFrom: theData.

	^ Form extent: self extent depth: 32 bits: aBitmap

]

{ #category : #API }
AeCairoImageSurface >> extent [

	^ self primWidth @ self primHeight
]

{ #category : #API }
AeCairoImageSurface >> format [

	^ self primFormat
]

{ #category : #API }
AeCairoImageSurface >> height [

	^ self primHeight
]

{ #category : #'private - ffi' }
AeCairoImageSurface >> newSimilarImageFormat: aFormat width: aWidth height: aHeight [

	^ self
		  primCreateSimilarImageFormat: aFormat
		  width: aWidth
		  height: aHeight
]

{ #category : #'private - ffi' }
AeCairoImageSurface >> primCreateSimilarImageFormat: aFormat width: aWidth height: aHeight [

	^ self ffiCall: #(
		AeCairoImageSurface cairo_surface_create_similar_image (
			self,
			AeCairoSurfaceFormat aFormat,
			int aWidth,
			int aHeight ) )
]

{ #category : #'private - ffi' }
AeCairoImageSurface >> primData [

	^ self ffiCall: #(uchar* cairo_image_surface_get_data ( self ) )
]

{ #category : #'private - ffi' }
AeCairoImageSurface >> primFormat [

	^ self ffiCall: #(AeCairoSurfaceFormat cairo_image_surface_get_format (self) )
]

{ #category : #'private - ffi' }
AeCairoImageSurface >> primHeight [

	^ self ffiCall: #(int cairo_image_surface_get_height ( self ) )
]

{ #category : #'private - ffi' }
AeCairoImageSurface >> primStride [

	^ self ffiCall: #(int cairo_image_surface_get_stride ( self ) )
]

{ #category : #'private - ffi' }
AeCairoImageSurface >> primWidth [

	^ self ffiCall: #(int cairo_image_surface_get_width ( self ) )
]

{ #category : #API }
AeCairoImageSurface >> width [

	^ self primWidth
]
