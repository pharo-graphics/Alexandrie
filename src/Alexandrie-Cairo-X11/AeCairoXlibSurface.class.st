Class {
	#name : #AeCairoXlibSurface,
	#superclass : #AeCairoImageSurface,
	#category : #'Alexandrie-Cairo-X11'
}

{ #category : #examples }
AeCairoXlibSurface class >> exampleDrawOnWindow [

	| inputXlibSurface radius xlibData |
	radius := 300.
	xlibData := LibX11 exampleWindowDisplayVisual.
	inputXlibSurface := AeCairoXlibSurface
		                    unownedNewWithDisplay: xlibData second
		                    drawable: xlibData first
		                    visual: xlibData third
		                    width: radius * 2
		                    height: radius * 2.
	inputXlibSurface autoRelease.
	inputXlibSurface status ensureIsSuccess.

	inputXlibSurface newContext
		circleRadius: radius;
		sourceColor: Color orange;
		fill.
	inputXlibSurface writePngToPathString: 'x11test.png'

	"it is drawn on the main window for a moment (until cursor blink produces a redraw)"
]

{ #category : #'instance creation' }
AeCairoXlibSurface class >> unownedNewWithDisplay: display drawable: drawable visual: visual width: width height: height [

	^ self ffiCall: #(
		AeCairoXlibSurface
		cairo_xlib_surface_create (
			"Display" void *display,
			"Drawable" void *drawable,
			"Visual" void *visual,
			int width,
			int height ) )
]
