"
A DSCategoryChannelTest is a test class for testing the behavior of DSCategoryChannel
"
Class {
	#name : 'DSCategoryChannelTest',
	#superclass : 'DSObjectTest',
	#instVars : [
		'category'
	],
	#category : 'Discord-Core-Tests-Model',
	#package : 'Discord-Core-Tests',
	#tag : 'Model'
}

{ #category : 'running' }
DSCategoryChannelTest >> classToTest [
	^ DSCategoryChannel
]

{ #category : 'instance creation' }
DSCategoryChannelTest >> newObjectToTest [
	^ self classToTest new
]

{ #category : 'tests' }
DSCategoryChannelTest >> testRestApi [
	category := self classToTest new.
	category restApi: DSRestBasic new.
	category subordinateChannels: { DSGuildTextChannel new }.
	self assert: category subordinateChannels first restApi equals: category restApi.
]

{ #category : 'tests' }
DSCategoryChannelTest >> testRestApi2 [
	category := self classToTest new.
	category subordinateChannels: { DSGuildTextChannel new }.
	category restApi: DSRestBasic new.
	self assert: category subordinateChannels first restApi equals: category restApi.
]
