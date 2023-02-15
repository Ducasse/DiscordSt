"
A DSApiTest is a test class for testing the behavior of DSApi
"
Class {
	#name : #DSApiTest,
	#superclass : #DSCoreTestCase,
	#instVars : [
		'api'
	],
	#category : 'Discord-Client-Tests-REST-Api'
}

{ #category : #'instance creation' }
DSApiTest >> newObjectToTest [
	^ self newRestApi
]

{ #category : #'instance creation' }
DSApiTest >> newRestApi [
	^ DSRestApi new 
]

{ #category : #tests }
DSApiTest >> testCacheAt [
	api := self newRestApi.
	self assert: (api cacheAt: 'user') isNil
]

{ #category : #tests }
DSApiTest >> testCacheAtIfAbsentPut [
	api := self newRestApi.
	api cacheAt: 'key' ifAbsentPut: [ self anyString ].
	api cacheAt: 'key' ifAbsentPut: [ self anyStringTwo ].
	self assert: (api cacheAt: 'key') equals: self anyString.
]

{ #category : #tests }
DSApiTest >> testCacheAtPut [
	api := self newRestApi.
	api cacheAt: 'key' put: self anyString.
	self assert: (api cacheAt: 'key') equals: self anyString.
]
