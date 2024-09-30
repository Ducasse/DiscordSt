"
I represent a bot application that connects to Discord.

I am used to interact with the Discord WebSocket and API.

I use DSSession to keep a bot token for the Discrod communication.

Public API and Key Messages

- token: - set bot token
 
Internal Representation and Key Implementation Points.

 
"
Class {
	#name : 'DSBot',
	#superclass : 'DSAbstractClient',
	#category : 'Discord-Client',
	#package : 'Discord-Client'
}

{ #category : 'examples' }
DSBot class >> joinedServers [
	<gtExample>
	^ self new
		token: 'BOT-TOKEN'";
		servers"
		
]

{ #category : 'examples' }
DSBot class >> sendMessage [
	<gtExample>
	^ self new 
		token: 'BOT-TOKEN';
		with: [ :bot | bot message
			content: 'Hi! I am a bot :-)'";
			sendToServer: 'Pharo' channel: 'general'" ].
]

{ #category : 'initialization' }
DSBot >> initialize [
	super initialize.
	restApi beBot.
]
