Class {
	#name : #AeCairoXlibSurface,
	#superclass : #AeCairoImageSurface,
	#category : #'Alexandrie-Cairo-X11'
}

{ #category : #examples }
AeCairoXlibSurface class >> exampleDrawOnWindow [
	"A circle is shown on the main window until World is repainted.
	Also, a PNG will be written to disk."
	
	| inputXlibSurface radius xlibData |
	radius := 300.
	xlibData := LibX11 exampleWindowDisplayVisual.
	inputXlibSurface := AeCairoXlibSurface
		                    newWithDisplay: xlibData second
		                    drawable: xlibData first
		                    visual: xlibData fourth
		                    width: xlibData fifth
		                    height: xlibData sixth.
	inputXlibSurface status ensureIsSuccess.

	inputXlibSurface newContext
		circleRadius: radius;
		sourceColor: Color orange;
		strokeSize: radius / 4;
		stroke.

	inputXlibSurface writePngToPathString: 'x11test.png'
]

{ #category : #'instance creation' }
AeCairoXlibSurface class >> newWithDisplay: display drawable: drawable visual: visual width: width height: height [

	^ (self
		   unownedNewWithDisplay: display
		   drawable: drawable
		   visual: visual
		   width: width
		   height: height)
		  autoRelease;
		  yourself
]

{ #category : #'instance creation' }
AeCairoXlibSurface class >> unownedNewWithDisplay: display drawable: drawable visual: visual width: width height: height [
	"Answer a new Xlib surface that draws to the given drawable. The way that colors are represented in the drawable is specified by the provided visual.

	Note: If drawable is a Window, then the function cairo_xlib_surface_set_size() must be called whenever the size of the window changes.

	When drawable is a Window containing child windows then drawing to the created surface will be clipped by those child windows. When the created surface is used as a source, the contents of the children will be included.

	See: https://www.cairographics.org/manual/cairo-XLib-Surfaces.html#cairo-xlib-surface-create"

	^ self ffiCall: #(
		AeCairoXlibSurface
		cairo_xlib_surface_create (
			"Display" void *display,
			"Drawable" void *drawable,
			"Visual" void *visual,
			int width,
			int height ) )
]
