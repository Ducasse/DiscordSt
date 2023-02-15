Class {
	#name : #DSChannelsCommand,
	#superclass : #DSCommand,
	#instVars : [
		'channels'
	],
	#category : 'Discord-Core-Commands'
}

{ #category : #accessing }
DSChannelsCommand >> channels [
	^ channels
]

{ #category : #accessing }
DSChannelsCommand >> channels: anObject [
	channels := anObject
]
