"
A DSEmbedFooterObjectTest is a test class for testing the behavior of DSEmbedFooterObject
"
Class {
	#name : #DSEmbedFooterTest,
	#superclass : #DSObjectTest,
	#category : 'Discord-Core-Tests-Model'
}

{ #category : #'instance creation' }
DSEmbedFooterTest >> newObjectToTest [
	^ self newEmbedFooterObject 
]

{ #category : #tests }
DSEmbedFooterTest >> testIconUrl [
	object := self newEmbedFooterObject iconUrl: self anyString; yourself.
	self assert: object iconUrl equals: self anyString.
]

{ #category : #tests }
DSEmbedFooterTest >> testProxyIconUrl [
	object := self newEmbedFooterObject proxyIconUrl: self anyString; yourself.
	self assert: object proxyIconUrl equals: self anyString.
]

{ #category : #tests }
DSEmbedFooterTest >> testText [
	object := self newEmbedFooterObject text: self anyString; yourself.
	self assert: object text equals: self anyString.
]
