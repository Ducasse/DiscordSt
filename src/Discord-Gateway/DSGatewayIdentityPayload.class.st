"
I represent Discord Gateway Identify Payload Message used for communication between a client and a server.

It is sent to the server when new WebSocket connection is established and HELLO payload received.

See documentation at https://discordapp.com/developers/docs/topics/gateway#gateway-op-codespayloads

It includes Hello Event: DSGatewayIdentityEvent as dataEvent.
"
Class {
	#name : #DSGatewayIdentityPayload,
	#superclass : #DSGatewayPayload,
	#category : 'Discord-Gateway-Model'
}

{ #category : #examples }
DSGatewayIdentityPayload class >> basic [
	<gtExample>
	^ DSGatewayModelJsonMapping 
		readPayload: DSGatewayModelJsonMapping jsonIdentityPayload.
]

{ #category : #accessing }
DSGatewayIdentityPayload class >> code [
	^ 2
]
