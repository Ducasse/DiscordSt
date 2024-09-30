"
I represent Discord Gateway Heartbeat Payload Message.

I am by the client periodically to keep the connection alive.

See documentation at https://discordapp.com/developers/docs/topics/gateway#gateway-op-codespayloads

Event data includes the last received sequence number.
"
Class {
	#name : 'DSGatewayHeartbeatPayload',
	#superclass : 'DSGatewayPayload',
	#category : 'Discord-Gateway-Model',
	#package : 'Discord-Gateway',
	#tag : 'Model'
}

{ #category : 'examples' }
DSGatewayHeartbeatPayload class >> basic [
	
	^ DSGatewayModelJsonMapping 
		readPayload: DSGatewayModelJsonMapping jsonHeartbeatPayload.
]

{ #category : 'accessing' }
DSGatewayHeartbeatPayload class >> code [
	^ 1
]
