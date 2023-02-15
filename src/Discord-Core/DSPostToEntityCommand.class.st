"
I convert a post object to a Zinc entity (ZnEntity).

If the post includes binary data, I return a ZnMultiPartFormDataEntity object. If all the data can be enconded in JSON, I return a ZnTextEntity object.
"
Class {
	#name : #DSPostToEntityCommand,
	#superclass : #DSCommand,
	#instVars : [
		'post',
		'entity'
	],
	#category : 'Discord-Core-Commands'
}

{ #category : #accessing }
DSPostToEntityCommand >> entity [
	^ entity
]

{ #category : #accessing }
DSPostToEntityCommand >> entity: anObject [
	entity := anObject
]

{ #category : #execute }
DSPostToEntityCommand >> execute [
	self post accept: self
]

{ #category : #accessing }
DSPostToEntityCommand >> post [
	^ post
]

{ #category : #accessing }
DSPostToEntityCommand >> post: anObject [
	post := anObject
]
