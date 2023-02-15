"
I am a Trait.
I provide an API to build Discord objects to send them to the Discord server.
I provide API that is used by bots and user clients.
"
Trait {
	#name : #TDSClientPostBuilder,
	#traits : 'TDSPostBuilder',
	#category : 'Discord-Core-Trait'
}

{ #category : #accessing }
TDSClientPostBuilder >> embed [
	"Create an embed object if necessary and return it."
	<return: #DSEmbed>
	^ self embed 
		ifNil: [ self post embed: self newEmbed ]
		ifNotNil: [ self post embed ]
]

{ #category : #'protocol - basic' }
TDSClientPostBuilder >> isTextToSpeech: aBoolean [
	"Set that this is a Text To Speech message."
	self post isTextToSpeech: aBoolean
]

{ #category : #'protocol - basic' }
TDSClientPostBuilder >> nonce: snowflake [ 
	"Set the message nonce that can be used for optimistic message sending"
	self post nonce: snowflake
]
