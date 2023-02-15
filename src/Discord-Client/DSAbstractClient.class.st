"
I am an abstract class.
I represent a user client and bot app to communicate with Discord.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	announcer:		<Announcer>
	gateway:		<DSGateway>
	restApi:			<DSRestApi>

"
Class {
	#name : #DSAbstractClient,
	#superclass : #Object,
	#instVars : [
		'gateway',
		'announcer',
		'restApi'
	],
	#category : 'Discord-Client'
}

{ #category : #announce }
DSAbstractClient >> announce: aDSAnnouncement [ 
	self announcer announce: aDSAnnouncement
]

{ #category : #accessing }
DSAbstractClient >> announcer [
	^ announcer
]

{ #category : #protocol }
DSAbstractClient >> connect [
	"Connect to Discord Gateway.
	Discord Gateway is a server that informs clients about new messages and other events.
	Discord Gateway uses WebSocket connection."

	self gateway connect
]

{ #category : #'accessing - convenience' }
DSAbstractClient >> directChannels [
	"Returns a list of user guild objects the current user is a member of.
	See https://discordapp.com/developers/docs/resources/user#get-current-user-guilds"
	^ self restApi directChannels
]

{ #category : #protocol }
DSAbstractClient >> disconnect [
	"Disconnect from Discord Gateway.
	Discord Gateway is a server that informs clients about new messages and other events.
	Discord Gateway uses WebSocket connection."

	self gateway disconnect
]

{ #category : #accessing }
DSAbstractClient >> gateway [
	"Return object responsible for Discord Gateway API (WebSocket) communication."
	^ gateway
]

{ #category : #'gt-inspector-extension' }
DSAbstractClient >> gtInspectorDirectChannels: composite [
	<gtInspectorPresentationOrder: 3>
	^ composite fastList
		title: [ 'Direct Channels' translated ];
		display: [ self directChannels ];
		when: [ self isAuthenticated ];
		selectionAct: [ :presentation | | id |
			id := presentation rawSelection recipients first id.
			Clipboard clipboardText: id asString. ]
			entitled: 'Copy Recipient''s id';
		enableFilter;
		yourself
]

{ #category : #'gt-inspector-extension' }
DSAbstractClient >> gtInspectorMembers: composite [
	<gtInspectorPresentationOrder: 2>
	^ composite fastTree
		title: [ 'Members' translated ];
		display: [ self servers ];
		when: [ self isAuthenticated ];
		children: [ :item | item members ];
		expandedUntil: 0;
		yourself
]

{ #category : #'gt-inspector-extension' }
DSAbstractClient >> gtInspectorServers: composite [
	<gtInspectorPresentationOrder: 1>
	^ composite fastTree
		title: [ 'Servers' translated ];
		display: [ self servers ];
		when: [ self isAuthenticated ];
		children: [ :item | item children ];
		expandedUntil: 1;
		yourself
]

{ #category : #initialization }
DSAbstractClient >> initialize [
	super initialize.
	announcer := self newAnnouncer.
	restApi := self newRestApi.
	gateway := self newGateway
		session: self session;
		announcer: self announcer;
		yourself
]

{ #category : #testing }
DSAbstractClient >> isAuthenticated [
	"Return true if the client was previously authenticated successfully."
	^ self restApi isAuthenticated
]

{ #category : #testing }
DSAbstractClient >> isConnected [
	"Return true if the client is connected to the Gateway."
	^ self gateway isConnected
]

{ #category : #protocol }
DSAbstractClient >> me [
	"Return User object that identyfies the logged user.
	See https://discordapp.com/developers/docs/resources/user#user-object"

	^ self restApi me
]

{ #category : #protocol }
DSAbstractClient >> message [
	"Return a builder to compose a user message.
	For the message structure, see https://discordapp.com/developers/docs/resources/channel#create-message"
	^ self restApi messageBuilder
]

{ #category : #'instance creation' }
DSAbstractClient >> newAnnouncer [
	^ Announcer new
]

{ #category : #'instance creation' }
DSAbstractClient >> newGateway [
	^ DSGateway defaultClass new
]

{ #category : #'instance creation' }
DSAbstractClient >> newRestApi [
	^ DSRestApi defaultClass new
]

{ #category : #accessing }
DSAbstractClient >> restApi [
	"Return object responsible for Discord REST API communication."
	^ restApi
]

{ #category : #'accessing - convenience' }
DSAbstractClient >> servers [
	"Returns a list of user guild objects the current user is a member of.
	See https://discordapp.com/developers/docs/resources/user#get-current-user-guilds"
	^ self restApi meGuilds
]

{ #category : #'accessing - convenience' }
DSAbstractClient >> session [
	"Get session object that keeps email, password and token for the Discord communication."
	^ self restApi session
]

{ #category : #'accessing - convenience' }
DSAbstractClient >> token [
	"Get an authentification token"

	^ self restApi token
]

{ #category : #'accessing - convenience' }
DSAbstractClient >> token: aString [
	"Set an authentification token"

	self restApi token: aString
]

{ #category : #protocol }
DSAbstractClient >> user [
	"Return User object that identyfies the logged user.
	See https://discordapp.com/developers/docs/resources/user#user-object"
	^ self me
]

{ #category : #scripting }
DSAbstractClient >> with: aBlockClosure [ 
	^ aBlockClosure cull: self
]
