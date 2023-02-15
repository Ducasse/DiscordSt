"
I am a voice channel type.
"
Class {
	#name : #DSChannelGuildVoiceType,
	#superclass : #DSChannelType,
	#category : 'Discord-Core-Model'
}

{ #category : #accessing }
DSChannelGuildVoiceType class >> typeNumber [
	^ 2
]

{ #category : #converting }
DSChannelGuildVoiceType >> asSpecifiedChannel: aDSUnspecifiedChannel [ 
	<return: #DSGuildVoiceChannel>
	^ DSGuildVoiceChannel new
		id: aDSUnspecifiedChannel id;
		guildId: aDSUnspecifiedChannel guildId;
		position: aDSUnspecifiedChannel position;
		permissionOverwrites: aDSUnspecifiedChannel permissionOverwrites;
		name: aDSUnspecifiedChannel name;
		bitrate: aDSUnspecifiedChannel bitrate;
		userLimit: aDSUnspecifiedChannel userLimit;
		parentId: aDSUnspecifiedChannel parentId;
		yourself
]

{ #category : #accessing }
DSChannelGuildVoiceType >> name [
	^ 'Voice Channel'
]
