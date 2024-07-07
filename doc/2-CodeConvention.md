# FFI Code Convention

We will show code convention about FFI calls with some examples.

### Simplest case

A function call binding can be as simple as:
```smalltalk
AeCairoContext >>
closePath
	"Adds a line segment to the path from the current point to the beginning of the current sub-path, (the most recent point passed to `cairo_move_to()`), and closes this sub-path. After this call the current point will be at the joined endpoint of the sub-path.
	
	See: https://www.cairographics.org/manual/cairo-Paths.html#cairo-close-path"

	self ffiCall: #( void cairo_close_path ( self ) )
```
Please note:
- The answer is just self (in the absence of `^`) as the function returns void.
- The `See:` links to the official documentation for this function.
- The comment is an adaptation and often a simplification of official documentation.

### Fetching information in an argument
Often to retrieve complex information, a function receives a pointer to an external struct.
```smalltalk
AeCairoContext >>
getMatrixInto: aCairoMatrix
	"Fetches the current transformation matrix.
	
	See: https://www.cairographics.org/manual/cairo-Transformations.html#cairo-get-matrix"

	self ffiCall: #(
		void
		cairo_get_matrix (
			self,
			AeCairoMatrix *aCairoMatrix ) )
```
Note:
- The argument is a `AeCairoMatrix` (subclass of `FFIExternalStructure`), and the function will receive its address to use at output. The selector includes "Into" word in these cases.
- The indentation in `ffiCall:`'s argument is used when several arguments are passed.

### Ownership transferred to caller
Within Alexandrie bindings, selectors with the `unowned` word will transfer the responsibility of freeing/destroying it to the caller (sender for us).
```smalltalk
AeCairoContext >>
unownedNewFor: targetSurface
	"Answer a new instance with all graphics state parameters set to default values.
	
	See: https://www.cairographics.org/manual/cairo-cairo-t.html#cairo-create"

	^ self ffiCall: #(
		AeCairoContext
		cairo_create (
			AeCairoSurface targetSurface ) )
```
Typically above method is accompanied by another method that sends `autoRelease` to the newly created object:
```smalltalk
AeCairoContext >>
newFor: aSurface

	^ (self unownedNewFor: aSurface)
		initializeWith: aSurface;
		autoRelease;
		yourself
```
Note the surface is passed to `initializeWith:`, which will store it in an instance variable. The reason is ensuring the Pharo's Garbage Collector doesn't release the surface while the context still needs it alive.
