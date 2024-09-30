"
I am a basic REST API that does not know anything. 
I just give basic responses, e.g., not authenticated and empty responses.
It is supposed to share one instance among all necessary places.
For this purpose call DSRestBasic uniqueInstance.
"
Class {
	#name : 'DSRestBasic',
	#superclass : 'DSRestApi',
	#classInstVars : [
		'uniqueInstance'
	],
	#category : 'Discord-Core-REST-Api',
	#package : 'Discord-Core',
	#tag : 'REST-Api'
}

{ #category : 'cleanup' }
DSRestBasic class >> cleanUp [
	self reset.
]

{ #category : 'accessing' }
DSRestBasic class >> reset [
	uniqueInstance := nil.
]

{ #category : 'accessing' }
DSRestBasic class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : 'accessing' }
DSRestBasic class >> versionNumber [
	^ 0
]

{ #category : 'public - user' }
DSRestBasic >> directChannels [
	"Return collection of dirrect channels"
	^ DSChannels new: 0
]

{ #category : 'public - channel' }
DSRestBasic >> messagesForChannel: aChannel [
	"Return a collection of messages for a given channel"
	^ DSMessages new: 0
]
