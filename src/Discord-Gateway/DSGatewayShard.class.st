"
I represent shard information.

See https://discordapp.com/developers/docs/topics/gateway#sharding
I am part of Gateway Identity, DSGatewayIdentityEvent.
 
"
Class {
	#name : 'DSGatewayShard',
	#superclass : 'DSGatewayProperties',
	#instVars : [
		'id',
		'numberOfShards'
	],
	#category : 'Discord-Gateway-Model',
	#package : 'Discord-Gateway',
	#tag : 'Model'
}

{ #category : 'accessing' }
DSGatewayShard >> id [
	^ id
]

{ #category : 'accessing' }
DSGatewayShard >> id: anObject [
	id := anObject
]

{ #category : 'accessing' }
DSGatewayShard >> numberOfShards [
	^ numberOfShards
]

{ #category : 'accessing' }
DSGatewayShard >> numberOfShards: anObject [
	numberOfShards := anObject
]
