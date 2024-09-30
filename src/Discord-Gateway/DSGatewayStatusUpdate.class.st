"
I represt a user status.
I am sent by the client to indicate a presence or status update.

See https://discordapp.com/developers/docs/topics/gateway#gateway-status-update

Field	Type	Description
since	?integer	unix time (in milliseconds) of when the client went idle, or null if the client is not idle
game	?game object	null, or the user's new activity
status	string	the user's new status
afk	bool	whether or not the client is afk (away from keyboad)

"
Class {
	#name : 'DSGatewayStatusUpdate',
	#superclass : 'DSGatewayProperties',
	#instVars : [
		'since',
		'game',
		'status',
		'awayFromKeyboard'
	],
	#category : 'Discord-Gateway-Model',
	#package : 'Discord-Gateway',
	#tag : 'Model'
}

{ #category : 'accessing' }
DSGatewayStatusUpdate >> awayFromKeyboard [
	^ awayFromKeyboard
]

{ #category : 'accessing' }
DSGatewayStatusUpdate >> awayFromKeyboard: anObject [
	awayFromKeyboard := anObject
]

{ #category : 'accessing' }
DSGatewayStatusUpdate >> game [
	^ game
]

{ #category : 'accessing' }
DSGatewayStatusUpdate >> game: anObject [
	game := anObject
]

{ #category : 'accessing' }
DSGatewayStatusUpdate >> since [
	^ since
]

{ #category : 'accessing' }
DSGatewayStatusUpdate >> since: anObject [
	since := anObject
]

{ #category : 'accessing' }
DSGatewayStatusUpdate >> status [
	^ status
]

{ #category : 'accessing' }
DSGatewayStatusUpdate >> status: anObject [
	status := anObject
]
