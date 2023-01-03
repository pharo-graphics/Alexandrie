"
I am a Cairo FFI binding for `cairo_device_t`.

A `cairo_device_t` represents the driver interface for drawing operations to a `cairo_surface_t`. There are different subtypes of `cairo_device_t` for different drawing backends; for example, `cairo_egl_device_create()` creates a device that wraps an EGL display and context.

See: https://www.cairographics.org/manual/cairo-cairo-device-t.html#cairo-device-t
"
Class {
	#name : #AeCairoDevice,
	#superclass : #FFIExternalObject,
	#traits : 'AeTCairoLibrary',
	#classTraits : 'AeTCairoLibrary classTrait',
	#category : #'Alexandrie-Cairo-Structures'
}
