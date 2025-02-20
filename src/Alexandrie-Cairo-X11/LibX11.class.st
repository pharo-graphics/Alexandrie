"
LibTTY’s #uniqueInstance provides access to ‘libtty’, a library included with the Pharo VM that offers a function to spawn a process connected to a pseudo-terminal.
"
Class {
	#name : #LibX11,
	#superclass : #FFILibrary,
	#category : #'Alexandrie-Cairo-X11'
}

{ #category : #examples }
LibX11 class >> exampleWindowDisplayVisual [
	<sampleInstance>

	| mainWindow wmInfo drawable display screen visual |
	mainWindow := SDL_Window allInstances detect: [ :each | each isNull not ].
	wmInfo := SDL_SysWMinfo new version: SDL_Version bindingVersion.
	mainWindow getWMInfo: wmInfo.

	^ {
		drawable := wmInfo info x11 window.
		display := wmInfo info x11 display.
		screen := LibX11 uniqueInstance defaultScreenOf: display.
		visual := LibX11 uniqueInstance defaultVisualOnDisplay: display screenNumber: screen.
		LibX11 uniqueInstance displayWidthOf: display screenNumber: screen.
		LibX11 uniqueInstance displayHeightOf: display screenNumber: screen. }
]

{ #category : #api }
LibX11 >> defaultScreenOf: displayPointer [

	^ self ffiCall: #(int XDefaultScreen("Display"void *displayPointer))
]

{ #category : #api }
LibX11 >> defaultVisualOnDisplay: displayPointer screenNumber: screenNumber [

	^ self ffiCall: #("Visual"void *XDefaultVisual("Display"void *displayPointer, int screenNumber))
]

{ #category : #api }
LibX11 >> displayHeightOf: displayPointer screenNumber: screenNumber [

	^ self ffiCall: #(int XDisplayHeight("Display"void *displayPointer, int screenNumber))
]

{ #category : #api }
LibX11 >> displayWidthOf: displayPointer screenNumber: screenNumber [

	^ self ffiCall: #(int XDisplayWidth("Display"void *displayPointer, int screenNumber))
]

{ #category : #'accessing - platform' }
LibX11 >> macLibraryName [

	self shouldNotImplement
]

{ #category : #'accessing - platform' }
LibX11 >> unixLibraryName [

	^ 'libX11.so'
]

{ #category : #'accessing - platform' }
LibX11 >> win32LibraryName [

	self shouldNotImplement
]
