"
I represent Discord Gateway Dispatch Payload Message used for communication between a client and a server.
I represent PRESENCE_UPDATE event.

I keep as data event a DSPresenceUpdate object.

See documentation at https://discordapp.com/developers/docs/topics/gateway#gateway-op-codespayloads
https://discordapp.com/developers/docs/topics/gateway#presence-update
"
Class {
	#name : 'DSGatewayDispatchPresenceUpdatePayload',
	#superclass : 'DSGatewayDispatchPayload',
	#category : 'Discord-Gateway-Model',
	#package : 'Discord-Gateway',
	#tag : 'Model'
}

{ #category : 'accessing' }
DSGatewayDispatchPresenceUpdatePayload class >> eventName [
	^ 'PRESENCE_UPDATE'
]

{ #category : 'visiting' }
DSGatewayDispatchPresenceUpdatePayload >> accept: aVisitor [ 
	^ aVisitor visitDSGatewayDispatchPresenceUpdatePayload: self
]
