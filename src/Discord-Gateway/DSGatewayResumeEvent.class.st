"
I am a Gateway Resume event.

See https://discordapp.com/developers/docs/topics/gateway#gateway-resume

Field	Type	Description
token	string	session token
session_id	string	session id
seq	integer	last sequence number received

"
Class {
	#name : 'DSGatewayResumeEvent',
	#superclass : 'DSGatewayEvent',
	#instVars : [
		'token',
		'sessionId',
		'sequenceNumber'
	],
	#category : 'Discord-Gateway-Model',
	#package : 'Discord-Gateway',
	#tag : 'Model'
}

{ #category : 'examples' }
DSGatewayResumeEvent class >> basic [
	
	^ DSGatewayModelJsonMapping 
		read: self 
		withMapping: #resumeEventMappingFor: 
		on: DSGatewayModelJsonMapping jsonResumeEvent readStream.
]

{ #category : 'accessing' }
DSGatewayResumeEvent >> sequenceNumber [
	^ sequenceNumber
]

{ #category : 'accessing' }
DSGatewayResumeEvent >> sequenceNumber: anObject [
	sequenceNumber := anObject
]

{ #category : 'accessing' }
DSGatewayResumeEvent >> sessionId [
	^ sessionId
]

{ #category : 'accessing' }
DSGatewayResumeEvent >> sessionId: anObject [
	sessionId := anObject
]

{ #category : 'accessing' }
DSGatewayResumeEvent >> token [
	^ token
]

{ #category : 'accessing' }
DSGatewayResumeEvent >> token: anObject [
	token := anObject
]
