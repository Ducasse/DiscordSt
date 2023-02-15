"
A DSEmbedProviderTest is a test class for testing the behavior of DSEmbedProvider
"
Class {
	#name : #DSEmbedProviderTest,
	#superclass : #DSObjectTest,
	#category : 'Discord-Core-Tests-Model'
}

{ #category : #'instance creation' }
DSEmbedProviderTest >> newObjectToTest [
	^ DSEmbedProvider new
]

{ #category : #tests }
DSEmbedProviderTest >> testName [
	object := self newObjectToTest name: self anyString; yourself.
	self assert: object name equals: self anyString.
]

{ #category : #tests }
DSEmbedProviderTest >> testUrl [
	object := self newObjectToTest url: self anyString; yourself.
	self assert: object url equals: self anyString.
]
