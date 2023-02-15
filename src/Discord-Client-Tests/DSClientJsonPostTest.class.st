"
A DSClientJsonPostTest is a test class for testing the behavior of DSClientJsonPost
"
Class {
	#name : #DSClientJsonPostTest,
	#superclass : #DSClientPostTest,
	#category : 'Discord-Client-Tests'
}

{ #category : #'instance creation' }
DSClientJsonPostTest >> newPost [
	^ DSClientJsonPost new
]

{ #category : #tests }
DSClientJsonPostTest >> testAsDataPost [
	| convertedPost |
	post := self newPost.
	convertedPost := post asDataPost.
	self deny: convertedPost == post.
	self assert: convertedPost class equals: DSClientDataPost.
	
]

{ #category : #tests }
DSClientJsonPostTest >> testAsDataPost2 [
	| convertedPost |
	post := self newPost.
	post
		content: 'a content';
		nonce: '1234';
		isTextToSpeech: true;
		embed: ( DSEmbed new description: 'embed description'; yourself).
	convertedPost := post asDataPost.
	self deny: convertedPost == post.
	self assert: convertedPost class equals: DSClientDataPost.
	self assert: convertedPost content equals: 'a content'.
	self assert: convertedPost nonce equals: '1234'.
	self assert: convertedPost isTextToSpeech.
	self assert: convertedPost embed notNil.
	self assert: convertedPost embed description equals: 'embed description'.
	
]
