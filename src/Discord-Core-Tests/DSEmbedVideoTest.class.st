"
A DSEmbedVideoTest is a test class for testing the behavior of DSEmbedVideo
"
Class {
	#name : #DSEmbedVideoTest,
	#superclass : #DSObjectTest,
	#category : 'Discord-Core-Tests-Model'
}

{ #category : #'instance creation' }
DSEmbedVideoTest >> newObjectToTest [
	^ DSEmbedVideo new
]

{ #category : #tests }
DSEmbedVideoTest >> testHeight [
	object := self newObjectToTest.
	object height: 42.
	self assert: object height equals: 42.
]

{ #category : #tests }
DSEmbedVideoTest >> testUrl [
	object := self newObjectToTest url: self anyString; yourself.
	self assert: object url equals: self anyString.
]

{ #category : #tests }
DSEmbedVideoTest >> testWidth [
	object := self newObjectToTest.
	object width: 42.
	self assert: object width equals: 42.
]
