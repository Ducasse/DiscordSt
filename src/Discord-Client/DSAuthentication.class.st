"
I am an abstract object.
I represent a Discord authentication.
Discord has several authentication options, see https://discordapp.com/developers/docs/reference#authentication 

"
Class {
	#name : #DSAuthentication,
	#superclass : #Object,
	#category : 'Discord-Client-REST-Api'
}

{ #category : #visiting }
DSAuthentication >> accept: aVisitor [
	^ self subclassResponsibility
]
