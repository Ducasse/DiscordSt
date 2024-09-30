"
I am an Gateway Ready event.

The ready event is dispatched when a client has completed the initial handshake with the gateway (for new sessions). The ready event can be the largest and most complex event the gateway will send, as it contains all the state required for a client to begin interacting with the rest of the platform.

See https://discordapp.com/developers/docs/topics/gateway#ready

Field	Type	Description
v	integer	gateway protocol version
user	user object	information about the user including email
private_channels	array of DM channel objects	the direct messages the user is in
guilds	array of Unavailable Guild objects	the guilds the user is in
session_id	string	used for resuming connections
_trace	array of strings	used for debugging - the guilds the user is in
"
Class {
	#name : 'DSGatewayReadyEvent',
	#superclass : 'DSGatewayEvent',
	#instVars : [
		'version',
		'user',
		'privateChannels',
		'guilds',
		'sessionId',
		'traces'
	],
	#category : 'Discord-Gateway-Model',
	#package : 'Discord-Gateway',
	#tag : 'Model'
}

{ #category : 'examples' }
DSGatewayReadyEvent class >> basic [

	^ DSGatewayModelJsonMapping 
		read: self 
		withMapping: #readyEventMappingFor: 
		on: DSGatewayModelJsonMapping jsonReadyEvent readStream.
]

{ #category : 'accessing' }
DSGatewayReadyEvent >> guilds [
	^ guilds
]

{ #category : 'accessing' }
DSGatewayReadyEvent >> guilds: anObject [
	guilds := anObject
]

{ #category : 'accessing' }
DSGatewayReadyEvent >> privateChannels [
	^ privateChannels
]

{ #category : 'accessing' }
DSGatewayReadyEvent >> privateChannels: anObject [
	privateChannels := anObject
]

{ #category : 'accessing' }
DSGatewayReadyEvent >> sessionId [
	^ sessionId
]

{ #category : 'accessing' }
DSGatewayReadyEvent >> sessionId: anObject [
	sessionId := anObject
]

{ #category : 'accessing' }
DSGatewayReadyEvent >> traces [
	^ traces
]

{ #category : 'accessing' }
DSGatewayReadyEvent >> traces: anObject [
	traces := anObject
]

{ #category : 'accessing' }
DSGatewayReadyEvent >> user [
	^ user
]

{ #category : 'accessing' }
DSGatewayReadyEvent >> user: anObject [
	user := anObject
]

{ #category : 'accessing' }
DSGatewayReadyEvent >> version [
	^ version
]

{ #category : 'accessing' }
DSGatewayReadyEvent >> version: anObject [
	version := anObject
]
