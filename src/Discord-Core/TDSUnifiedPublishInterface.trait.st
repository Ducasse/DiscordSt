"
I am a Trait.
I provide unified interface to send messages to Discord using Webhooks, Bots, and User Clients.
"
Trait {
	#name : 'TDSUnifiedPublishInterface',
	#category : 'Discord-Core-Trait',
	#package : 'Discord-Core',
	#tag : 'Trait'
}

{ #category : 'protocol - sending' }
TDSUnifiedPublishInterface >> asyncSend [
	"Execute the post action in a forked process."
	[ self send ] 
		forkAt: Processor userBackgroundPriority 
		named: 'Discord Message Send Process'
]

{ #category : 'protocol - sending' }
TDSUnifiedPublishInterface >> send [
	"Send a message to a particular target.
	In case of Webhooks it is a Webhook URL.
	In case of Bots and User Clients it is a Channel object."
	<return: #DSMessage or: nil>
	^ self explicitRequirement
]

{ #category : 'protocol - sending' }
TDSUnifiedPublishInterface >> target: aChannelTarget [
	"Set a target where a particular message should be sent.
	In case of Webhooks it is a Webhook URL.
	In case of Bots and User Clients it is a Channel object."
	self explicitRequirement
]
