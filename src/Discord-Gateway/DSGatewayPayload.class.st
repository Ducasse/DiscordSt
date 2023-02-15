"
I represent Discord Gateway Payload Message used for communication between a client and a server.

See documentation at https://discordapp.com/developers/docs/topics/gateway#gateway-opcodespayloads

Field	Type	Description	Present
op	integer	opcode for the payload	Always
d	?mixed (object, integer, bool)	event data	Always
s	integer	sequence number, used for resuming sessions and heartbeats	Only for Opcode 0
t	string	the event name for this payload	Only for Opcode 0


Gateway Opcodes

Code	Name	Client Action	Description
0	Dispatch	Receive	dispatches an event
1	Heartbeat	Send/Receive	used for ping checking
2	Identify	Send	used for client handshake
3	Status Update	Send	used to update the client status
4	Voice State Update	Send	used to join/move/leave voice channels
5	Voice Server Ping	Send	used for voice ping checking
6	Resume	Send	used to resume a closed connection
7	Reconnect	Receive	used to tell clients to reconnect to the gateway
8	Request Guild Members	Send	used to request guild members
9	Invalid Session	Receive	used to notify client they have an invalid session id
10	Hello	Receive	sent immediately after connecting, contains heartbeat and server debug information
11	Heartbeat ACK	Receive	sent immediately following a client heartbeat that was received

"
Class {
	#name : #DSGatewayPayload,
	#superclass : #Object,
	#instVars : [
		'eventData',
		'sequenceNumber',
		'eventName'
	],
	#category : 'Discord-Gateway-Model'
}

{ #category : #enumerating }
DSGatewayPayload class >> allPayloads [
	"Return all classes representing payloads."
	<return: #Array of: #DSGatewayPayload>
	^ self allSubclasses reject: #isAbstract
]

{ #category : #accessing }
DSGatewayPayload class >> code [
	"Return a number, that represents the specific payload. See class comment for details."
	<return: #Integer>
	^ self subclassResponsibility
]

{ #category : #testing }
DSGatewayPayload class >> isAbstract [
	^ self name = #DSGatewayPayload 
]

{ #category : #testing }
DSGatewayPayload class >> represents: aDSGatewayUnspecifiedPayload [ 
	"Return true if a class represents the given payload."
	^ self code = aDSGatewayUnspecifiedPayload code
]

{ #category : #accessing }
DSGatewayPayload class >> schemaFromUnspecifidPayload: aDSGatewayUnspecifiedPayload [ 
	"Return a specific class that represent the given payload, using code and eventName."
	<return: #DSGatewayPayload>
	^ self allPayloads 
		detect: [ :eachPayload | eachPayload represents: aDSGatewayUnspecifiedPayload ]
		ifNone: [ DSGatewayUnclassifiedPayload ]
]

{ #category : #visiting }
DSGatewayPayload >> accept: aVisitor [ 
	^ self subclassResponsibility
]

{ #category : #accessing }
DSGatewayPayload >> code [
	^ self class code
]

{ #category : #accessing }
DSGatewayPayload >> eventData [
	^ eventData
]

{ #category : #accessing }
DSGatewayPayload >> eventData: anObject [
	eventData := anObject
]

{ #category : #accessing }
DSGatewayPayload >> eventName [
	^ eventName
]

{ #category : #accessing }
DSGatewayPayload >> eventName: anObject [
	eventName := anObject
]

{ #category : #accessing }
DSGatewayPayload >> sequenceNumber [
	^ sequenceNumber
]

{ #category : #accessing }
DSGatewayPayload >> sequenceNumber: anObject [
	sequenceNumber := anObject
]
