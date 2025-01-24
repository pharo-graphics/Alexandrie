"
I am a Cairo FFI binding for a `cairo_surface_t` for Microsoft Windows.

The Microsoft Windows surface is used to render cairo graphics to Microsoft Windows windows, bitmaps, and printing device contexts.

See: https://www.cairographics.org/manual/cairo-Win32-Surfaces.html
"
Class {
	#name : #AeCairoWin32Surface,
	#superclass : #AeCairoImageSurface,
	#category : #'Alexandrie-Cairo-Surfaces'
}

{ #category : #tests }
AeCairoWin32Surface class >> surfaceWithColoredCircles [
	<sampleInstance>

	| inputWin32Surface inputSurface outputColors outputSurface outputContext |
	inputWin32Surface := AeCairoWin32Surface extent: 16@16.
	inputWin32Surface newContext
		circleRadius: 8;
		sourceColor: Color black;
		fill.
	inputSurface := inputWin32Surface image.

	outputColors := Color wheel: 7.

	"Create a surface and associated context"
	outputSurface := AeCairoImageSurface
	    extent: (inputSurface width * outputColors size) @ inputSurface height
	    format: AeCairoSurfaceFormat argb32.
	outputContext := outputSurface newContext.

	"Paint the inputSurface with each color"
	outputColors
	    do: [ :eachColor |
	        outputContext
	            sourceColor: eachColor;
	            maskSurface: inputSurface ]
	    separatedBy: [
	        outputContext
	            translateByX: inputSurface width
	            y: 0 ].

	^ outputSurface
]

{ #category : #'instance creation' }
AeCairoWin32Surface class >> unownedNewWithFormat: aFormat width: aWidth height: aHeight [
	"Creates a device-independent-bitmap surface not associated with any particular existing surface or device context. The created bitmap will be uninitialized.
	
	See: https://www.cairographics.org/manual/cairo-Win32-Surfaces.html#cairo-win32-surface-create-with-dib"

	^ self ffiCall: #(
		AeCairoWin32Surface
		cairo_win32_surface_create_with_dib (
			AeCairoSurfaceFormat aFormat,
			int aWidth,
			int aHeight ) )
]

{ #category : #accessing }
AeCairoWin32Surface >> image [
	"Returns a cairo_surface_t image surface that refers to the same bits as the DIB of the Win32 surface. If the passed-in win32 surface is not a DIB surface, NULL is returned.
	
	See: https://www.cairographics.org/manual/cairo-Win32-Surfaces.html#cairo-win32-surface-get-image"

	^ self ffiCall: #(
		AeCairoImageSurface cairo_win32_surface_get_image ( self ) )
]
