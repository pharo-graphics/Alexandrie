"
I am a FFI binding to a PDF or SVG surface type in the Cairo library (`cairo_surface_t`).

The main difference between my subclasses is given by the function that creates the external surface via FFI.

Use me like a `AeCairoImageSurface` with the following differences:
1. On instance creation, the user specifies (a) output filename as String and (b) the extent in points (1 point == 1/72.0 inch).
2. When drawing is done, the user should send `#finish` to write the file trailer into the library buffer and then flush to disk.

Note 1: Before `#finish`, the file may already exist in disk with 0 bytes.
Note 2: If the garbage collector finalizes the instance before `#close`, the exported file may have an invalid format.

References:
* http://zetcode.com/gfx/cairo/cairobackends/
* http://www.ie.u-ryukyu.ac.jp/~e085739/c.cairo.3.html
* https://cairographics.org/manual/cairo-PDF-Surfaces.html
* https://cairographics.org/manual/cairo-SVG-Surfaces.html

"
Class {
	#name : #AeCairoExportSurface,
	#superclass : #AeCairoSurface,
	#category : #'Alexandrie-Cairo-Surfaces'
}

{ #category : #'instance creation' }
AeCairoExportSurface class >> extent: aPoint to: aFileReference [
	"Answer a new PDF surface of the specified size in points (1 point == 1/72.0 inch) to be written to the specified file."

	^ self extent: aPoint toPathString: aFileReference pathString
]

{ #category : #'instance creation' }
AeCairoExportSurface class >> extent: aPoint toPathString: aString [
	"Answer a new PDF surface of the specified size in points (1 point == 1/72.0 inch) to be written to the specified file."

	| encodedPath |
	encodedPath := aString nullTerminatedEncodeWith: #utf8.

	^ (self
		   unownedNewExportingTo: encodedPath
		   width: aPoint x
		   height: aPoint y)
		  autoRelease;
		  yourself
]

{ #category : #'instance creation' }
AeCairoExportSurface class >> unownedNewExportingTo: fileName width: width height: height [

	^ self subclassResponsibility
]
