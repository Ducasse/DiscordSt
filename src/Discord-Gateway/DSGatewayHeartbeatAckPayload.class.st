"
I represent Discord Gateway Heartbeat ACK Payload Message used for communication between a client and a server.

I am sent by the server as a confirmation of Heartbeat Payload message that has to be regularly send to the server. See DSGatewayHeartbeatProcess.

See documentation at https://discordapp.com/developers/docs/topics/gateway#gateway-op-codespayloads

"
Class {
	#name : 'DSGatewayHeartbeatAckPayload',
	#superclass : 'DSGatewayPayload',
	#category : 'Discord-Gateway-Model',
	#package : 'Discord-Gateway',
	#tag : 'Model'
}

{ #category : 'examples' }
DSGatewayHeartbeatAckPayload class >> basic [
	<gtExample>
	^ DSGatewayModelJsonMapping 
		readPayload: DSGatewayModelJsonMapping jsonHeartbeatAckPayload.
]

{ #category : 'accessing' }
DSGatewayHeartbeatAckPayload class >> code [
	^ 11
]

{ #category : 'visiting' }
DSGatewayHeartbeatAckPayload >> accept: aVisitor [ 
	^ aVisitor visitDSGatewayHeartbeatAckPayload: self
]
