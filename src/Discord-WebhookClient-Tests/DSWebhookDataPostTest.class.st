"
A DSDataWebhookPostTest is a test class for testing the behavior of DSDataWebhookPost
"
Class {
	#name : 'DSWebhookDataPostTest',
	#superclass : 'DSWebhookPostTest',
	#category : 'Discord-WebhookClient-Tests',
	#package : 'Discord-WebhookClient-Tests'
}

{ #category : 'instance creation' }
DSWebhookDataPostTest >> newPost [
	^ DSWebhookDataPost new
]

{ #category : 'tests' }
DSWebhookDataPostTest >> testAsDataPost [
	object := self newPost.
	self assert: object asDataPost == object.
]
