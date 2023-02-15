Class {
	#name : #DSGatewayHeartbeatProcess,
	#superclass : #DSGatewayProcess,
	#instVars : [
		'heartbeatPayload',
		'heartbeatInterval',
		'delay'
	],
	#category : 'Discord-Gateway-API'
}

{ #category : #private }
DSGatewayHeartbeatProcess >> doCycle [
	"Start Heartbeat process. 
	It first delay the activity for hearbeat interval period, 
	then do send the heartbeat code and receives the heartbeat ACK code."
	delay := self heartbeatInterval milliSeconds asDelay.
	delay wait.
	delay := nil.
	self canDoNextCycle ifTrue: [ self sendHeartbeat ]
]

{ #category : #accessing }
DSGatewayHeartbeatProcess >> heartbeatInterval [
	<return: #Integer>
	^ heartbeatInterval
]

{ #category : #accessing }
DSGatewayHeartbeatProcess >> heartbeatInterval: anInteger [
	"Time between two heartbeats in milliseconds."
	heartbeatInterval := anInteger
]

{ #category : #accessing }
DSGatewayHeartbeatProcess >> heartbeatString [
	"Return the JSON representation of the heartbeat payload."
	<return: #String>
	^ mutex critical: [ DSGatewayModelJsonMapping writePayload: heartbeatPayload ]
]

{ #category : #initialization }
DSGatewayHeartbeatProcess >> initialize [
	super initialize.
	heartbeatPayload := DSGatewayHeartbeatPayload new
]

{ #category : #printing }
DSGatewayHeartbeatProcess >> printProcessNameOn: aStream [
	aStream
		nextPutAll: self className;
		nextPutAll: ' heartbeat process'
]

{ #category : #private }
DSGatewayHeartbeatProcess >> sendHeartbeat [
	"Send OP 1 Heartbeat message to a Discord Gateway server."
	self websocket sendMessage: self heartbeatString
]

{ #category : #accessing }
DSGatewayHeartbeatProcess >> sequenceNumber [
	"Return a sequence number (a part of the payload event data) for the next payload."
	^ mutex critical: [ heartbeatPayload eventData ]
]

{ #category : #accessing }
DSGatewayHeartbeatProcess >> sequenceNumber: anInteger [
	"Set sequence number (as event data) for the next payload."
	mutex critical: [ heartbeatPayload eventData: anInteger ]
]
