Class {
	#name : #DSDiscordClientSharedDataSender,
	#superclass : #DSDiscordSharedDataSender,
	#category : 'Discord-Send-Items'
}

{ #category : #initialization }
DSDiscordClientSharedDataSender >> initializeMessageBuilder [
	messageBuilder := self registry client message.
	messageBuilder channel: self registry selectedChannel.
]
