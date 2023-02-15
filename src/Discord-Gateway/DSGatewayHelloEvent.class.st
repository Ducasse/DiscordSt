"
I am an Gateway Hello event.
I am received by a client on a connection to the websocket. Defines the heartbeat interval that the client should heartbeat to.

See https://discordapp.com/developers/docs/topics/gateway#gateway-hello

Field	Type	Description
heartbeat_interval	integer	the interval (in milliseconds) the client should heartbeat with
_trace	array of strings	used for debugging, array of servers connected to

"
Class {
	#name : #DSGatewayHelloEvent,
	#superclass : #DSGatewayEvent,
	#instVars : [
		'heartbeatInterval',
		'traces'
	],
	#category : 'Discord-Gateway-Model'
}

{ #category : #examples }
DSGatewayHelloEvent class >> basic [
	<gtExample>
	^ DSGatewayModelJsonMapping 
		read: self 
		withMapping: #helloEventMappingFor: 
		on: DSGatewayModelJsonMapping jsonHelloEvent readStream.
]

{ #category : #accessing }
DSGatewayHelloEvent >> heartbeatInterval [
	<return: #Integer>
	^ heartbeatInterval
]

{ #category : #accessing }
DSGatewayHelloEvent >> heartbeatInterval: anObject [
	heartbeatInterval := anObject
]

{ #category : #accessing }
DSGatewayHelloEvent >> traces [
	<return: #Array of: #String>
	^ traces
]

{ #category : #accessing }
DSGatewayHelloEvent >> traces: anObject [
	traces := anObject
]
