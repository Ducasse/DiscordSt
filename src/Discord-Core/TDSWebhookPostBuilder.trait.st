"
I am a Trait.
I provide an API to build Discord objects to send them to the Discord server.
I provide API that is used by Webhooks.
"
Trait {
	#name : 'TDSWebhookPostBuilder',
	#traits : 'TDSPostBuilder',
	#category : 'Discord-Core-Trait',
	#package : 'Discord-Core',
	#tag : 'Trait'
}

{ #category : 'protocol - embed' }
TDSWebhookPostBuilder >> addNewEmbed [
	"Add new embed object and return it."
	<return: #DSEmbed>
	^ self post addEmbed: self newEmbed
]

{ #category : 'protocol - basic' }
TDSWebhookPostBuilder >> avatarUrl: aString [ 
	"Set the avatar URL."
	self post avatarUrl: aString 
]

{ #category : 'accessing' }
TDSWebhookPostBuilder >> embed [
	"Return an embed object. Create one if necessary."
	<return: #DSEmbed>
	^ self post embeds 
		ifEmpty: [ self addNewEmbed ]
		ifNotEmpty: [ self post embeds last ]
]

{ #category : 'protocol - basic' }
TDSWebhookPostBuilder >> username: aString [ 
	"Set the Webhook username."
	self post username: aString 
]
