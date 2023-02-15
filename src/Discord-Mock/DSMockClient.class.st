Class {
	#name : #DSMockClient,
	#superclass : #Object,
	#instVars : [
		'email',
		'password',
		'isAuthenticated',
		'servers',
		'loginAction',
		'announcer',
		'directChannels'
	],
	#category : 'Discord-Mock'
}

{ #category : #examples }
DSMockClient class >> authenticated [
	<gtExample>
	<label: 'An authenticated client with a server'>
	^ self new
		email: 'alice@example.com';
		password: 'alice password';
		isAuthenticated: true;
		servers: DSGuilds oneGuild;
		directChannels: DSChannels oneDirectChannel;
		yourself
]

{ #category : #examples }
DSMockClient class >> noServers [
	<gtExample>
	<label: 'A client without any server'>
	^ self new
		email: 'alice@example.com';
		password: 'alice password';
		isAuthenticated: true;
		yourself
]

{ #category : #examples }
DSMockClient class >> unsigned [
	<gtExample>
	<label: 'An unsigned (unlogged) client'>
	^ self new
		email: 'alice@example.com';
		password: 'alice password';
		isAuthenticated: false;
		servers: DSGuilds oneGuild;
		yourself
]

{ #category : #announce }
DSMockClient >> announce: anAnnouncement [ 
	self announcer announce: anAnnouncement
]

{ #category : #accessing }
DSMockClient >> announcer [
	^ announcer
]

{ #category : #accessing }
DSMockClient >> directChannels [
	^ directChannels
]

{ #category : #accessing }
DSMockClient >> directChannels: anObject [
	directChannels := anObject
]

{ #category : #accessing }
DSMockClient >> email [
	^ email
]

{ #category : #accessing }
DSMockClient >> email: anObject [
	email := anObject
]

{ #category : #initialization }
DSMockClient >> initialize [
	super initialize.
	announcer := self newAnnouncer.
	isAuthenticated := false.
	loginAction := [ :client | self isAuthenticated: true ].
	servers := DSGuilds new.
	directChannels := DSChannels new.
]

{ #category : #accessing }
DSMockClient >> isAuthenticated [
	^ isAuthenticated
]

{ #category : #accessing }
DSMockClient >> isAuthenticated: anObject [
	isAuthenticated := anObject
]

{ #category : #public }
DSMockClient >> login [
	loginAction cull: self.
	self isAuthenticated ifTrue: [ self announce: DSAuthenticatedAnnouncement ].
]

{ #category : #accessing }
DSMockClient >> loginAction [
	^ loginAction
]

{ #category : #accessing }
DSMockClient >> loginAction: anObject [
	loginAction := anObject
]

{ #category : #'instance creation' }
DSMockClient >> newAnnouncer [
	^ Announcer new
]

{ #category : #accessing }
DSMockClient >> password [
	^ password
]

{ #category : #accessing }
DSMockClient >> password: anObject [
	password := anObject
]

{ #category : #accessing }
DSMockClient >> servers [
	^ servers
]

{ #category : #accessing }
DSMockClient >> servers: anObject [
	servers := anObject
]
