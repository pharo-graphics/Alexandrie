Class {
	#name : #AeCairoTeeSurface,
	#superclass : #AeCairoSurface,
	#category : #'Alexandrie-Cairo-Surfaces'
}

{ #category : #'instance creation' }
AeCairoTeeSurface class >> newWith: primarySurface [

	^ (self unownedNewPrimary: primarySurface)
		  autoRelease;
		  yourself
]

{ #category : #'instance creation' }
AeCairoTeeSurface class >> unownedNewPrimary: primarySurface [
	"Creates a new tee surface.

	The primary surface is used when querying surface options, like font options and extents.
	Operations performed on the tee surface will be replayed on any surface added to it.

	See: https://www.cairographics.org/manual/cairo-Tee-surface.html#cairo-tee-surface-create"

	^ self ffiCall: #(
		AeCairoTeeSurface *
		cairo_tee_surface_create (
			AeCairoSurface * primarySurface ) )
]

{ #category : #adding }
AeCairoTeeSurface >> add: aSurface [
	"Adds a new target surface to the list of replicas of a tee surface.

	See: https://www.cairographics.org/manual/cairo-Tee-surface.html#cairo-tee-surface-add"

	self ffiCall: #(
		void
		cairo_tee_surface_add (
			self,
			AeCairoSurface aSurface) )
]

{ #category : #adding }
AeCairoTeeSurface >> remove: aSurface [
	"Removes the given surface from the list of replicas of a tee surface.

	See: https://www.cairographics.org/manual/cairo-Tee-surface.html#cairo-tee-surface-remove"

	self ffiCall: #(
		void
		cairo_tee_surface_remove (
			self,
			AeCairoSurface aSurface) )
]
