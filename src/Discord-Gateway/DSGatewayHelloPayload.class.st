"
I represent Discord Gateway Hello Payload Message used for communication between a client and a server.

It is sent by the server when new WebSocket connection is established.

See documentation at https://discordapp.com/developers/docs/topics/gateway#gateway-op-codespayloads

It includes Hello Event: DSGatewayHelloEvent as dataEvent.
"
Class {
	#name : 'DSGatewayHelloPayload',
	#superclass : 'DSGatewayPayload',
	#category : 'Discord-Gateway-Model',
	#package : 'Discord-Gateway',
	#tag : 'Model'
}

{ #category : 'examples' }
DSGatewayHelloPayload class >> basic [
	<gtExample>
	^ DSGatewayModelJsonMapping 
		readPayload: DSGatewayModelJsonMapping jsonHelloPayload.
]

{ #category : 'accessing' }
DSGatewayHelloPayload class >> code [
	^ 10
]

{ #category : 'visiting' }
DSGatewayHelloPayload >> accept: aVisitor [ 
	^ aVisitor visitDSGatewayHelloPayload: self
]

{ #category : 'accessing - convenience' }
DSGatewayHelloPayload >> heartbeatInterval [
	<return: #Integer>
	^ self eventData heartbeatInterval
]
