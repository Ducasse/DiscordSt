"
A DSClientDataPostTest is a test class for testing the behavior of DSClientDataPost
"
Class {
	#name : 'DSClientDataPostTest',
	#superclass : 'DSClientPostTest',
	#category : 'Discord-Client-Tests',
	#package : 'Discord-Client-Tests'
}

{ #category : 'instance creation' }
DSClientDataPostTest >> newPost [
	^ DSClientDataPost new
]

{ #category : 'tests' }
DSClientDataPostTest >> testAsDataPost [
	post := self newPost.
	self assert: post asDataPost == post.
]
