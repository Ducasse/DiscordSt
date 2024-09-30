"
I represent a client connection that connects to Discord.

I am used to interact with the Discord WebSocket and API.

I use DSSession to keep email, password and token for the Discrod communication.

Public API and Key Messages

- email:password: - set email and password to login
- message two 
 
Internal Representation and Key Implementation Points.

 
"
Class {
	#name : 'DSClient',
	#superclass : 'DSAbstractClient',
	#classInstVars : [
		'default'
	],
	#category : 'Discord-Client',
	#package : 'Discord-Client'
}

{ #category : 'examples' }
DSClient class >> constructEmbedDescriptionUsingMarkdownBuilder [
	"Send an embed object. Its description is build using a Markdown builder"
	
	^ DSClient new
		email: 'email@example.com' password: 'secret-password';
		"login;"
		with: [ :aClient | aClient message
			embedTitle: 'Discord Message Title';
			embedDescriptionMarkdown: [ :markdown | 
				markdown text: 'Hello! I am a message with a'; space; link: 'World.st' url: 'http://world.st' ];
			embedUrl: 'http://pharo.org';
			embedColor: Color random;
			embedFooterText: 'Pharo Project';
			embedFooterIconUrl: 'attachment://footer.png';
			embedThumbnailUrl: 'attachment://thumbnail.png';
			embedImageUrl: 'attachment://screenshot.png';
			embedInlineFieldName: 'Pharo' value: SystemVersion current version asString;
			embedInlineFieldName: 'OS' value: '[', Smalltalk os name asString, '](https://en.wikipedia.org/wiki/Operating_system)';
			fileName: 'screenshot.png' morph: World submorphs atRandom;
			fileName: 'thumbnail.png' form: #help asIcon;
			fileName: 'footer.png' form: #pharo asIcon";
			sendTo: [ :servers | servers first general ]" ];
		yourself
]

{ #category : 'public' }
DSClient class >> default [
	"Return the default instance that we manage.
	Note that this is a class instance variable."
	^ default ifNil: [ default := self newDefault ]
]

{ #category : 'instance creation' }
DSClient class >> newDefault [
	DSClientSettings updateSettings.
	^ self new
		email: DSClientSettings cleanDiscordClientEmail;
		password: DSClientSettings cleanDiscordClientPassword;
		token: DSClientSettings cleanDiscordClientToken;
		with: [ :theClient | 
			theClient announcer
				when: DSAuthenticatedAnnouncement
				do:
					[ :announcement | DSClientSettings storeDiscordClientSession: theClient ] ];
		yourself
]

{ #category : 'singleton' }
DSClient class >> resetDefault [
	<script>
	default 
		ifNil: [ ^ self ]
		ifNotNil: [ :aClient | 
			default := nil.
			aClient disconnect ].
]

{ #category : 'singleton' }
DSClient class >> resetToken [
	<script>
	default 
		ifNil: [ ^ self ]
		ifNotNil: [ :aClient | 
			aClient token: '' ].
]

{ #category : 'examples' }
DSClient class >> sendEmbed [
	"Send an embed object."
	
	^ DSClient new
		email: 'email@example.com' password: 'secret-password';
		"login;"
		with: [ :aClient | aClient message
			embedTitle: 'Discord Message Title';
			embedDescription: 'Hello! I am a message with a [link](http://world.st)';
			embedUrl: 'http://pharo.org';
			embedColor: Color random;
			embedFooterText: 'Pharo Project';
			embedFooterIconUrl: 'attachment://footer.png';
			embedThumbnailUrl: 'attachment://thumbnail.png';
			embedImageUrl: 'attachment://screenshot.png';
			embedInlineFieldName: 'Pharo' value: SystemVersion current version asString;
			embedInlineFieldName: 'OS' value: '[', Smalltalk os name asString, '](https://en.wikipedia.org/wiki/Operating_system)';
			fileName: 'screenshot.png' morph: World submorphs atRandom;
			fileName: 'thumbnail.png' form: #help asIcon;
			fileName: 'footer.png' form: #pharo asIcon";
			sendTo: [ :servers | servers first general ]" ];
		yourself
]

{ #category : 'examples' }
DSClient class >> sendFormAsScreenshot [
	"Post a Form object as an attached screenshot"
	
	^ DSClient new 
		email: 'email@example.com' password: 'secret-password';
		"login;"
		with: [ :aClient | aClient message 
			content: 'This is a help icon used in the Pharo image';
			fileName: 'help-icon.png' form: #help asIcon";
			sendTo: [ :servers | servers first general ];" ];
		yourself.

]

{ #category : 'examples' }
DSClient class >> sendImage [
	"Send an image or any other file"
	
	^ DSClient new 
		email: 'email@example.com' password: 'secret-password';
		"login;"
		with: [ :aClient | aClient message
			content: 'This message includes an image';
			fileName: 'random-image.jpg' 
			bytes: (ZnEasy 
				get: 'http://lorempixel.com/400/200') contents";
			sendTo: [ :servers | servers first general ]" ];
		yourself.
]

{ #category : 'examples' }
DSClient class >> sendMorphAsScreenshot [
	"Post a Morph object as an attached screenshot"
	
	^ DSClient new 
		email: 'email@example.com' password: 'secret-password';
		"login;"
		with: [ :aClient | aClient message
			content: 'This is a screenshot of my Pharo image';
			fileName: 'screen.png' morph: World";
			sendTo: [ :servers | servers first general ]" ];
		yourself

]

{ #category : 'examples' }
DSClient class >> sendObjectSerializedWithFuel [
	"Send an object (serialized with FUEL) as an attachment"
	
	^ DSClient new 
		email: 'email@example.com' password: 'secret-password';
		"login;"
		with: [ :aClient | aClient message
			content: 'This message includes a serialized object using FUEL';
			fileName: 'object.fuel'
			fuelObject: 'http://books.pharo.org' asZnUrl";
			sendTo: [ :servers | servers first general ]" ];
		yourself

]

{ #category : 'examples' }
DSClient class >> sendSimpleMessage [
	"Send a text message to the general channel"	
	^ DSClient new 
		email: 'email@example.com' password: 'secret-password';
		"login;"
		with: [ :aClient | aClient message
			content: 'Pharo loves Discord'";
			sendTo: [ :servers | servers first general ]" ];
		yourself

]

{ #category : 'accessing - convenience' }
DSClient >> email [
	"Get email or nil used to login into a Discord server."

	^ self restApi email
]

{ #category : 'accessing - convenience' }
DSClient >> email: aString [
	"Set email used to login into a Discord server."
	self session email: aString
]

{ #category : 'accessing - convenience' }
DSClient >> email: emailString password: passwordString [
	"Set email and password used to login into a Discord server."

	self restApi email: emailString password: passwordString
]

{ #category : 'protocol' }
DSClient >> login [
	"Login to Discord. 
	Raise DSCannotLogin on incorrect email or password.
	Raise NetworkError on any network problem."

	self restApi login.
	self announce: DSAuthenticatedAnnouncement.
]

{ #category : 'protocol' }
DSClient >> logout [
	"Logout from Discord.
	Currently, it only deletes token."

	self restApi isAuthenticated 
		ifTrue: [ self restApi logout ]
]

{ #category : 'accessing - convenience' }
DSClient >> password [
	"Get password or nil used to login into a Discord server."

	^ self restApi password
]

{ #category : 'accessing - convenience' }
DSClient >> password: aString [
	"Set password used to login into a Discord server."
	self session password: aString
]

{ #category : 'printing' }
DSClient >> printOn: aStream [
	super printOn: aStream.
	self email notNil
		ifTrue: [ aStream << ': ' << self email ].
	self isAuthenticated 
		ifTrue: [ aStream << ' (authenticated)' ]
		ifFalse: [ aStream << ' (unauthenticated)' ].
	self isConnected 
		ifTrue: [ aStream << ' (connected)' ]
		ifFalse: [ aStream << ' (disconnected)' ].
]
