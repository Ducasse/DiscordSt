"
A DSGatewayMessageReceiverTest is a test class for testing the behavior of DSGatewayMessageReceiver
"
Class {
	#name : #DSGatewayMessageReceiverTest,
	#superclass : #DSGatewayTestCase,
	#instVars : [
		'receiver',
		'websocket'
	],
	#category : 'Discord-Gateway-Tests-API'
}

{ #category : #'instance creation' }
DSGatewayMessageReceiverTest >> newMessageReceiver [
	^ DSGatewayMessageReceiver new
]

{ #category : #'instance creation' }
DSGatewayMessageReceiverTest >> newMessageReceiverInitialized [
	^ self newMessageReceiver
		announcer: self newAnnouncer;
		session: (DSSession new token: self anyString);
		heartbeatProcess: DSGatewayHeartbeatProcess new;
		yourself.
]

{ #category : #running }
DSGatewayMessageReceiverTest >> tearDown [
	websocket ifNotNil: [ :aWebSocket | 
		[ aWebSocket close ] on: ConnectionClosed, ConnectionTimedOut do: [ "ignore" ] ].

]

{ #category : #tests }
DSGatewayMessageReceiverTest >> testValueMessageCreateEvent [
	| results |
	results := OrderedCollection new.
	receiver := self newMessageReceiverInitialized.
	receiver announcer when: DSGatewayMessageCreateAnnouncement do: [ :ann | results add: ann ].
	receiver value: self gatewayModelJsonMapping jsonMessageCreatePayload.
	self assert: results size equals: 1.
	self assert: results first class equals: DSGatewayMessageCreateAnnouncement.
	self assert: receiver sequenceNumber equals: 4.
]

{ #category : #tests }
DSGatewayMessageReceiverTest >> testValueMessageUpdateEvent [
	| results |
	results := OrderedCollection new.
	receiver := self newMessageReceiverInitialized.
	receiver announcer when: DSGatewayMessageUpdateAnnouncement do: [ :ann | results add: ann ].
	receiver value: self gatewayModelJsonMapping jsonMessageUpdatePayload.
	self assert: results size equals: 1.
	self assert: results first class equals: DSGatewayMessageUpdateAnnouncement.
	self assert: receiver sequenceNumber equals: 5.
]

{ #category : #tests }
DSGatewayMessageReceiverTest >> testValueReadyEvent [
	receiver := self newMessageReceiverInitialized.
	receiver value: self gatewayModelJsonMapping jsonReadyPayload.
	self assert: receiver sequenceNumber equals: 2.
	self assert: receiver sessionId equals: 21.
	
]
