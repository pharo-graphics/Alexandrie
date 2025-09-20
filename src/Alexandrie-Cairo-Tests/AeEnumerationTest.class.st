Class {
	#name : #AeEnumerationTest,
	#superclass : #TestCase,
	#category : #'Alexandrie-Cairo-Tests'
}

{ #category : #tests }
AeEnumerationTest >> testAllValues [

	self
		assertCollection: AeCairoContent allValues
		hasSameElements: {
			AeCairoContent colorOnly.
			AeCairoContent colorAndAlpha.
			AeCairoContent alphaOnly }
]

{ #category : #tests }
AeEnumerationTest >> testCamelCaseName [

	self assert: AeCairoAntialias CAIRO_ANTIALIAS_SUBPIXEL camelCaseName equals: 'subpixel'.
	self assert: AeCairoContent CAIRO_CONTENT_COLOR_ALPHA camelCaseName equals: 'colorAlpha'.
]
