"
I represent Discord Gateway Dispatch Payload Message used for communication between a client and a server.

I am sent by the server when the communication is established and ready to use.

See documentation at https://discordapp.com/developers/docs/topics/gateway#gateway-opcodespayloads
"
Class {
	#name : #DSGatewayDispatchReadyPayload,
	#superclass : #DSGatewayDispatchPayload,
	#category : 'Discord-Gateway-Model'
}

{ #category : #examples }
DSGatewayDispatchReadyPayload class >> basic [
	<gtExample>
	^ DSGatewayModelJsonMapping 
		readPayload: DSGatewayModelJsonMapping jsonReadyPayload.
]

{ #category : #accessing }
DSGatewayDispatchReadyPayload class >> eventName [
	^ 'READY'
]

{ #category : #visiting }
DSGatewayDispatchReadyPayload >> accept: aVisitor [ 
	^ aVisitor visitDSGatewayDispatchReadyPayload: self
]

{ #category : #'accessing - convenience' }
DSGatewayDispatchReadyPayload >> sessionId [
	^ self eventData sessionId
]
