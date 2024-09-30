"
I am an abstract Discord server error.
My subclasses are raised if Discord server response is not successful, e.g., incorrect login and password.
"
Class {
	#name : 'DSDiscordResponseError',
	#superclass : 'DSDiscordError',
	#instVars : [
		'response'
	],
	#category : 'Discord-Core-Exceptions',
	#package : 'Discord-Core',
	#tag : 'Exceptions'
}

{ #category : 'accessing' }
DSDiscordResponseError >> response [
	"Get responce object received from a Discord server."
	^ response
]

{ #category : 'accessing' }
DSDiscordResponseError >> response: aZnResponse [
	"Set response object received from a Discord server."
	response := aZnResponse
]
