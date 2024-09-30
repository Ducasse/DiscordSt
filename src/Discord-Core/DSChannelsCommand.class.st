Class {
	#name : 'DSChannelsCommand',
	#superclass : 'DSCommand',
	#instVars : [
		'channels'
	],
	#category : 'Discord-Core-Commands',
	#package : 'Discord-Core',
	#tag : 'Commands'
}

{ #category : 'accessing' }
DSChannelsCommand >> channels [
	^ channels
]

{ #category : 'accessing' }
DSChannelsCommand >> channels: anObject [
	channels := anObject
]
