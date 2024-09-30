"
A DSEmbedThumbnailTest is a test class for testing the behavior of DSEmbedThumbnail
"
Class {
	#name : 'DSEmbedThumbnailTest',
	#superclass : 'DSObjectTest',
	#category : 'Discord-Core-Tests-Model',
	#package : 'Discord-Core-Tests',
	#tag : 'Model'
}

{ #category : 'instance creation' }
DSEmbedThumbnailTest >> newObjectToTest [
	^ DSEmbedThumbnail new
]

{ #category : 'tests' }
DSEmbedThumbnailTest >> testHeight [
	object := self newObjectToTest.
	object height: 42.
	self assert: object height equals: 42.
]

{ #category : 'tests' }
DSEmbedThumbnailTest >> testProxyUrl [
	object := self newObjectToTest.
	object proxyUrl: self anyString.
	self assert: object proxyUrl equals: self anyString.

]

{ #category : 'tests' }
DSEmbedThumbnailTest >> testUrl [
	object := self newObjectToTest url: self anyString; yourself.
	self assert: object url equals: self anyString.
]

{ #category : 'tests' }
DSEmbedThumbnailTest >> testWidth [
	object := self newObjectToTest.
	object width: 42.
	self assert: object width equals: 42.
]
