"
I represent Discord Gateway Resume Payload Message used for communication between a client and a server.

I am sent to the server, when new WebSocket connection is established and HELLO payload received, and the client want to replay all missed events.

See documentation at https://discordapp.com/developers/docs/topics/gateway#gateway-op-codespayloads
https://discordapp.com/developers/docs/topics/gateway#gateway-resume

It includes Hello Event: DSGatewayResumeEvent as dataEvent.
"
Class {
	#name : 'DSGatewayResumePayload',
	#superclass : 'DSGatewayPayload',
	#category : 'Discord-Gateway-Model',
	#package : 'Discord-Gateway',
	#tag : 'Model'
}

{ #category : 'examples' }
DSGatewayResumePayload class >> basic [
	
	^ DSGatewayModelJsonMapping 
		readPayload: DSGatewayModelJsonMapping jsonResumePayload.
]

{ #category : 'accessing' }
DSGatewayResumePayload class >> code [
	^ 6
]
