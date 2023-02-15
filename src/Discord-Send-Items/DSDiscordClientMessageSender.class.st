Class {
	#name : #DSDiscordClientMessageSender,
	#superclass : #DSDiscordMessageSender,
	#category : 'Discord-Send-Items'
}

{ #category : #'instance creation' }
DSDiscordClientMessageSender >> newDiscordSharedDataSender [
	^ DSDiscordClientSharedDataSender new
]

{ #category : #private }
DSDiscordClientMessageSender >> sendMainMessage [
	messageBuilder := self registry client message.
	messageBuilder channel: self registry selectedChannel.
	self items do: [ :eachItem | eachItem accept: self ].
	messageBuilder send.
]
