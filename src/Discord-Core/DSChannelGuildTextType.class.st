"
I am a text based channel type.
"
Class {
	#name : 'DSChannelGuildTextType',
	#superclass : 'DSChannelType',
	#category : 'Discord-Core-Model',
	#package : 'Discord-Core',
	#tag : 'Model'
}

{ #category : 'accessing' }
DSChannelGuildTextType class >> typeNumber [
	^ 0
]

{ #category : 'converting' }
DSChannelGuildTextType >> asSpecifiedChannel: aDSUnspecifiedChannel [ 
	"Return a DSGuildTextChannel"
	
	^ DSGuildTextChannel new
		id: aDSUnspecifiedChannel id;
		guildId: aDSUnspecifiedChannel guildId;
		position: aDSUnspecifiedChannel position;
		permissionOverwrites: aDSUnspecifiedChannel permissionOverwrites;
		name: aDSUnspecifiedChannel name;
		topic: aDSUnspecifiedChannel topic;
		nsfw: aDSUnspecifiedChannel nsfw;
		lastMessageId: aDSUnspecifiedChannel lastMessageId;
		icon: aDSUnspecifiedChannel icon;
		parentId: aDSUnspecifiedChannel parentId;
		yourself
]

{ #category : 'accessing' }
DSChannelGuildTextType >> name [
	^ 'Text Channel'
]
