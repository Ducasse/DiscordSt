"
I represent Discord Gateway Dispatch Payload Message used for communication between a client and a server.
I represent MESSAGE_UPDATE event.

See documentation at https://discordapp.com/developers/docs/topics/gateway#gateway-op-codespayloads
https://discordapp.com/developers/docs/topics/gateway#message-update
"
Class {
	#name : 'DSGatewayDispatchMessageUpdatePayload',
	#superclass : 'DSGatewayDispatchPayload',
	#category : 'Discord-Gateway-Model',
	#package : 'Discord-Gateway',
	#tag : 'Model'
}

{ #category : 'accessing' }
DSGatewayDispatchMessageUpdatePayload class >> eventName [
	^ 'MESSAGE_UPDATE'
]

{ #category : 'visiting' }
DSGatewayDispatchMessageUpdatePayload >> accept: aVisitor [
	^ aVisitor visitDSGatewayDispatchMessageUpdatePayload: self
]
