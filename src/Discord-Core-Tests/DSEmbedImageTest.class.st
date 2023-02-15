"
A DSEmbedImageTest is a test class for testing the behavior of DSEmbedImage
"
Class {
	#name : #DSEmbedImageTest,
	#superclass : #DSObjectTest,
	#category : 'Discord-Core-Tests-Model'
}

{ #category : #'instance creation' }
DSEmbedImageTest >> newObjectToTest [
	^ DSEmbedImage new
]

{ #category : #tests }
DSEmbedImageTest >> testExtent [
	object := self newObjectToTest.
	object width: 41.
	object height: 42.
	self assert: object extent equals: 41 @ 42

]

{ #category : #tests }
DSEmbedImageTest >> testHeight [
	object := self newObjectToTest.
	object height: 42.
	self assert: object height equals: 42.
]

{ #category : #tests }
DSEmbedImageTest >> testProxyUrl [
	object := self newObjectToTest.
	object proxyUrl: self anyString.
	self assert: object proxyUrl equals: self anyString.

]

{ #category : #tests }
DSEmbedImageTest >> testUrl [
	object := self newObjectToTest url: self anyString; yourself.
	self assert: object url equals: self anyString.
]

{ #category : #tests }
DSEmbedImageTest >> testWidth [
	object := self newObjectToTest.
	object width: 42.
	self assert: object width equals: 42.
]
