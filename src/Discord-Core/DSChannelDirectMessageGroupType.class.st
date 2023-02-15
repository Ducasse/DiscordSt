"
I represent direct message group channel type.
I am  a type of a private channel among  several users.
"
Class {
	#name : #DSChannelDirectMessageGroupType,
	#superclass : #DSChannelType,
	#category : 'Discord-Core-Model'
}

{ #category : #accessing }
DSChannelDirectMessageGroupType class >> typeNumber [
	^ 3
]

{ #category : #converting }
DSChannelDirectMessageGroupType >> asSpecifiedChannel: aDSUnspecifiedChannel [ 
	^ DSDirectMessageGroupChannel new
		id: aDSUnspecifiedChannel id;
		name: aDSUnspecifiedChannel name;
		ownerId: aDSUnspecifiedChannel ownerId;
		icon: aDSUnspecifiedChannel icon;
		lastMessageId: aDSUnspecifiedChannel lastMessageId;
		recipients: aDSUnspecifiedChannel recipients;
		yourself
]

{ #category : #accessing }
DSChannelDirectMessageGroupType >> name [
	^ 'Direct Message Group'
]
