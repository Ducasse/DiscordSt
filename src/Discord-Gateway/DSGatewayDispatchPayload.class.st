"
I represent Discord Gateway Dispatch Payload Message used for communication between a client and a server.

I am sent by the server to dispatch events, e.g., new message event.

See documentation at https://discordapp.com/developers/docs/topics/gateway#gateway-opcodespayloads
"
Class {
	#name : 'DSGatewayDispatchPayload',
	#superclass : 'DSGatewayPayload',
	#category : 'Discord-Gateway-Model',
	#package : 'Discord-Gateway',
	#tag : 'Model'
}

{ #category : 'accessing' }
DSGatewayDispatchPayload class >> code [
	^ 0
]

{ #category : 'accessing' }
DSGatewayDispatchPayload class >> eventName [
	"Return event name, that represent a particular Discord event."
	<return: #String>
	^ self subclassResponsibility
]

{ #category : 'testing' }
DSGatewayDispatchPayload class >> isAbstract [
	^ self name = #DSGatewayDispatchPayload 
]

{ #category : 'testing' }
DSGatewayDispatchPayload class >> represents: aDSGatewayUnspecifiedPayload [ 
	"Return true if a class represents the given payload."
	^ (super represents: aDSGatewayUnspecifiedPayload) 
			and: [ self eventName = aDSGatewayUnspecifiedPayload eventName ]
]
