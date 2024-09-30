"
A DSClientPostTest is a test class for testing the behavior of DSClientPost
"
Class {
	#name : 'DSClientPostTest',
	#superclass : 'DSCoreTestCase',
	#instVars : [
		'post'
	],
	#category : 'Discord-Client-Tests',
	#package : 'Discord-Client-Tests'
}

{ #category : 'testing' }
DSClientPostTest class >> isAbstract [
	^ self = DSClientPostTest 
]

{ #category : 'instance creation' }
DSClientPostTest >> newPost [
	"Return a post object"
	^ self subclassResponsibility 
]

{ #category : 'tests' }
DSClientPostTest >> testAsDataPost [
	self subclassResponsibility
]

{ #category : 'tests' }
DSClientPostTest >> testContent [
	post := self newPost content: self contentString; yourself.
	self assert: post content equals: self contentString.
]

{ #category : 'tests' }
DSClientPostTest >> testContent2 [
	post := self newPost content: self newContentObject; yourself.
	self assert: post content equals: self newContentObject asString.

]

{ #category : 'tests' }
DSClientPostTest >> testContent3 [
	"The"
	post := self newPost.
	self should: [ post content: self contentLongString ] raise: DSLongMessageError.
	self assert: post content isNil.
]

{ #category : 'tests' }
DSClientPostTest >> testContentDefault [
	post := self newPost.
	self assert: post content isNil
]

{ #category : 'tests' }
DSClientPostTest >> testEmbed [
	post := self newPost embed: self contentString; yourself.
	self assert: post embed equals: self contentString.
]

{ #category : 'tests' }
DSClientPostTest >> testEmbedDefault [
	post := self newPost.
	self assert: post embed isNil
]

{ #category : 'tests' }
DSClientPostTest >> testNonce [
	post := self newPost nonce: self anyString; yourself.
	self assert: post nonce equals: self anyString.
]
