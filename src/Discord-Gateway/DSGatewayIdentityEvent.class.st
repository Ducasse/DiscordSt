"
I am an Gateway Identity event.
See https://discordapp.com/developers/docs/topics/gateway#gateway-identify

Field	Type	Description
token	string	authentication token
properties	object	connection properties
compress	bool	whether this connection supports compression of packets
large_threshold	integer	value between 50 and 250, total number of members where the gateway will stop sending offline members in the guild member list
shard	array of two integers (shard_id, num_shards)	used for Guild Sharding
presence	gateway status update object	presence structure for initial presence information

"
Class {
	#name : 'DSGatewayIdentityEvent',
	#superclass : 'DSGatewayEvent',
	#instVars : [
		'token',
		'properties',
		'compress',
		'largeThreshold',
		'shard',
		'status'
	],
	#category : 'Discord-Gateway-Model',
	#package : 'Discord-Gateway',
	#tag : 'Model'
}

{ #category : 'examples' }
DSGatewayIdentityEvent class >> basic [
	
	^ DSGatewayModelJsonMapping 
		read: self 
		withMapping: #identityEventMappingFor: 
		on: DSGatewayModelJsonMapping jsonIdentityEvent readStream.
]

{ #category : 'accessing' }
DSGatewayIdentityEvent >> compress [
	^ compress
]

{ #category : 'accessing' }
DSGatewayIdentityEvent >> compress: anObject [
	compress := anObject
]

{ #category : 'accessing' }
DSGatewayIdentityEvent >> largeThreshold [
	^ largeThreshold
]

{ #category : 'accessing' }
DSGatewayIdentityEvent >> largeThreshold: anObject [
	largeThreshold := anObject
]

{ #category : 'accessing' }
DSGatewayIdentityEvent >> properties [
	^ properties
]

{ #category : 'accessing' }
DSGatewayIdentityEvent >> properties: anObject [
	properties := anObject
]

{ #category : 'accessing' }
DSGatewayIdentityEvent >> shard [
	^ shard
]

{ #category : 'accessing' }
DSGatewayIdentityEvent >> shard: anObject [
	shard := anObject
]

{ #category : 'accessing' }
DSGatewayIdentityEvent >> status [
	^ status
]

{ #category : 'accessing' }
DSGatewayIdentityEvent >> status: anObject [
	status := anObject
]

{ #category : 'accessing' }
DSGatewayIdentityEvent >> token [
	^ token
]

{ #category : 'accessing' }
DSGatewayIdentityEvent >> token: anObject [
	token := anObject
]
