"
I represent direct message channel type.
"
Class {
	#name : 'DSChannelDirectMessageType',
	#superclass : 'DSChannelType',
	#category : 'Discord-Core-Model',
	#package : 'Discord-Core',
	#tag : 'Model'
}

{ #category : 'accessing' }
DSChannelDirectMessageType class >> typeNumber [
	^ 1
]

{ #category : 'converting' }
DSChannelDirectMessageType >> asSpecifiedChannel: aDSUnspecifiedChannel [ 
	^ DSDirectMessageChannel new
		id: aDSUnspecifiedChannel id;
		lastMessageId: aDSUnspecifiedChannel lastMessageId;
		recipients: aDSUnspecifiedChannel recipients;
		yourself
]

{ #category : 'accessing' }
DSChannelDirectMessageType >> name [
	^ 'Direct Message'
]
