"
A DSWebhookPostTest is a test class for testing the behavior of DSWebhookPost
"
Class {
	#name : 'DSWebhookPostTest',
	#superclass : 'DSCoreTestCase',
	#instVars : [
		'object'
	],
	#category : 'Discord-WebhookClient-Tests',
	#package : 'Discord-WebhookClient-Tests'
}

{ #category : 'testing' }
DSWebhookPostTest class >> isAbstract [
	^ self = DSWebhookPostTest 
]

{ #category : 'instance creation' }
DSWebhookPostTest >> newPost [
	"Return post object"
	^ self subclassResponsibility
]

{ #category : 'tests' }
DSWebhookPostTest >> testAsDataPost [
	self subclassResponsibility
]

{ #category : 'tests' }
DSWebhookPostTest >> testAvatarUrl [
	object := self newPost avatarUrl: self avatarUrl; yourself.
	self assert: object avatarUrl equals: self avatarUrl.
]

{ #category : 'tests' }
DSWebhookPostTest >> testAvatarUrlDefault [
	object := self newPost.
	self assert: object avatarUrl isNil.
]

{ #category : 'tests' }
DSWebhookPostTest >> testContent [
	object := self newPost content: self contentString; yourself.
	self assert: object content equals: self contentString.
]

{ #category : 'tests' }
DSWebhookPostTest >> testContent2 [
	object := self newPost content: self newContentObject; yourself.
	self assert: object content equals: self newContentObject asString.
]

{ #category : 'tests' }
DSWebhookPostTest >> testContent3 [
	self 
		should: [ self newPost content: self contentLongString ]
		raise: DSLongMessageError.
]

{ #category : 'tests' }
DSWebhookPostTest >> testContentDefault [
	object := self newPost.
	self assert: object content isNil.
]

{ #category : 'tests' }
DSWebhookPostTest >> testIsTextToSpeech [
	object := self newPost.
	self assert: object isTextToSpeech isNil
]

{ #category : 'tests' }
DSWebhookPostTest >> testUsername [
	object := self newPost username: self username; yourself.
	self assert: object username equals: self username.
]

{ #category : 'tests' }
DSWebhookPostTest >> testUsernameDefault [
	object := self newPost.
	self assert: object username isNil
]
