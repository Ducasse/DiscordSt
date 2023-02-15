"
I am a channel category type.
"
Class {
	#name : #DSChannelGuildCategoryType,
	#superclass : #DSChannelType,
	#category : 'Discord-Core-Model'
}

{ #category : #accessing }
DSChannelGuildCategoryType class >> typeNumber [
	^ 4
]

{ #category : #converting }
DSChannelGuildCategoryType >> asSpecifiedChannel: aDSUnspecifiedChannel [ 
	^ DSCategoryChannel new
		id: aDSUnspecifiedChannel id;
		guildId: aDSUnspecifiedChannel guildId;
		position: aDSUnspecifiedChannel position;
		permissionOverwrites: aDSUnspecifiedChannel permissionOverwrites;
		name: aDSUnspecifiedChannel name;
		nsfw: aDSUnspecifiedChannel nsfw;
		yourself
]

{ #category : #accessing }
DSChannelGuildCategoryType >> name [
	^ 'Category'
]
