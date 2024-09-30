"
A DSEmbedFieldTest is a test class for testing the behavior of DSEmbedField
"
Class {
	#name : 'DSEmbedFieldTest',
	#superclass : 'DSObjectTest',
	#category : 'Discord-Core-Tests-Model',
	#package : 'Discord-Core-Tests',
	#tag : 'Model'
}

{ #category : 'instance creation' }
DSEmbedFieldTest >> newObjectToTest [
	^ DSEmbedField new
]

{ #category : 'tests' }
DSEmbedFieldTest >> testBeInline [
	object := self newObjectToTest beInline; yourself.
	self assert: object isInline
]

{ #category : 'tests' }
DSEmbedFieldTest >> testIsInline [
	object := self newObjectToTest.
	self deny: object isInline
]

{ #category : 'tests' }
DSEmbedFieldTest >> testName [
	object := self newObjectToTest name: self anyString; yourself.
	self assert: object name equals: self anyString.
]

{ #category : 'tests' }
DSEmbedFieldTest >> testValue [
	object := self newObjectToTest value: self anyString; yourself.
	self assert: object value equals: self anyString.
]
