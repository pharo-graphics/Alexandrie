Extension { #name : #BlOSWindowSDL2HostSpace }

{ #category : #'*Alexandrie-Canvas' }
BlOSWindowSDL2HostSpace >> newBlHostRendererSurface [

	^ BlHostRendererBufferSurface newForHostSpace: self
]
