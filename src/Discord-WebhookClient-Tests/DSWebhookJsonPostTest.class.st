"
A DSJSONWebhookPostTest is a test class for testing the behavior of DSJSONWebhookPost
"
Class {
	#name : #DSWebhookJsonPostTest,
	#superclass : #DSWebhookPostTest,
	#category : 'Discord-WebhookClient-Tests'
}

{ #category : #'instance creation' }
DSWebhookJsonPostTest >> newPost [
	^ DSWebhookJsonPost new
]

{ #category : #tests }
DSWebhookJsonPostTest >> testAsDataPost [
	| convertedPost |
	object := self newPost.
	convertedPost := object asDataPost.
	self deny: convertedPost == object.
	self assert: convertedPost class equals: DSWebhookDataPost.
	
]

{ #category : #tests }
DSWebhookJsonPostTest >> testAsDataPost2 [
	| convertedPost |
	object := self newPost.
	object
		content: 'a content';
		username: '1234';
		avatarUrl: 'http://example.com/avatar.png' asZnUrl;
		isTextToSpeech: true;
		embeds: { DSEmbed new description: 'embed description'; yourself }.
	convertedPost := object asDataPost.
	self deny: convertedPost == object.
	self assert: convertedPost class equals: DSWebhookDataPost.
	self assert: convertedPost content equals: 'a content'.
	self assert: convertedPost username equals: '1234'.
	self assert: convertedPost avatarUrl equals: 'http://example.com/avatar.png' asZnUrl.
	self assert: convertedPost isTextToSpeech.
	self assert: convertedPost embeds notNil.
	self assert: convertedPost embeds size equals: 1.
	self assert: convertedPost embeds first description equals: 'embed description'.
	
]
