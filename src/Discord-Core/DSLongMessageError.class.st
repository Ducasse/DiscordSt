"
I indicate that a message content is too long.
Discord has lenght limits for DSMessage content and Embed description content.
It is 2000 characters.
"
Class {
	#name : 'DSLongMessageError',
	#superclass : 'DSDiscordValidationError',
	#instVars : [
		'content'
	],
	#category : 'Discord-Core-Exceptions',
	#package : 'Discord-Core',
	#tag : 'Exceptions'
}

{ #category : 'accessing' }
DSLongMessageError >> content [
	"Get the content that exceeds the lenght limit."
	^ content
]

{ #category : 'accessing' }
DSLongMessageError >> content: anObject [
	"Set the content that exceeds the lenght limit."
	content := anObject
]
