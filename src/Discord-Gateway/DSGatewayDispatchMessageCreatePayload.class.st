"
I represent Discord Gateway Dispatch Payload Message used for communication between a client and a server.
I represent MESSAGE_CREATE event.

See documentation at https://discordapp.com/developers/docs/topics/gateway#gateway-op-codespayloads
https://discordapp.com/developers/docs/topics/gateway#message-create
"
Class {
	#name : #DSGatewayDispatchMessageCreatePayload,
	#superclass : #DSGatewayDispatchPayload,
	#category : 'Discord-Gateway-Model'
}

{ #category : #accessing }
DSGatewayDispatchMessageCreatePayload class >> eventName [
	^ 'MESSAGE_CREATE'
]

{ #category : #visiting }
DSGatewayDispatchMessageCreatePayload >> accept: aVisitor [ 
	^ aVisitor visitDSGatewayDispatchMessageCreatePayload: self
]
