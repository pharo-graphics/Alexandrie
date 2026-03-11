"
An AeHarfbuzzLibraryTest is a test class for testing the behavior of AeHarfbuzzLibrary
"
Class {
	#name : #AeHarfbuzzLibraryTest,
	#superclass : #TestCase,
	#instVars : [
		'lib'
	],
	#category : #'Alexandrie-Harfbuzz-Tests'
}

{ #category : #running }
AeHarfbuzzLibraryTest >> setUp [
	super setUp.

	lib := AeHarfbuzzLibrary uniqueInstance
]

{ #category : #tests }
AeHarfbuzzLibraryTest >> testIsAtLeastVersionMajorMinorMicro [

	| version major minor micro |
	version := $. split: lib versionString.
	major := version first asInteger.
	minor := version second asInteger.
	micro := version third asInteger.

	self assert: (lib isAtLeastVersionMajor: major minor: minor micro: micro).
	self deny: (lib isAtLeastVersionMajor: major minor: minor micro: micro + 1).
	self deny: (lib isAtLeastVersionMajor: major + 1 minor: minor micro: micro)
]

{ #category : #tests }
AeHarfbuzzLibraryTest >> testVersionString [

	self assert: lib versionString isString.
	self assert: ($. split: lib versionString) size equals: 3
]
