Class {
	#name : #DSSingletonClientRegistry,
	#superclass : #DSConnectionRegistry,
	#instVars : [
		'directChannelsItem',
		'selectedChannels',
		'selectedServer'
	],
	#category : 'Discord-Registry-Core'
}

{ #category : #visiting }
DSSingletonClientRegistry >> accept: aVisitor [
	^ aVisitor visitDSClientRegistry: self
]

{ #category : #accessing }
DSSingletonClientRegistry >> announcer [
	<return: #Announcer>
	^ self client announcer
]

{ #category : #accessing }
DSSingletonClientRegistry >> channelsOfSelectedServer [
	^ self selectedServer 
		ifNotNil: #textChannels
		ifNil: [ DSChannels empty ]
]

{ #category : #accessing }
DSSingletonClientRegistry >> client [
	<return: #DSClient>
	^ DSClient default
]

{ #category : #initialization }
DSSingletonClientRegistry >> defaultIcon [
	^ self iconNamed: #user
]

{ #category : #accessing }
DSSingletonClientRegistry >> directChannels [
	^ self client directChannels
]

{ #category : #accessing }
DSSingletonClientRegistry >> email [
	^ self client email
]

{ #category : #accessing }
DSSingletonClientRegistry >> email: anObject [
	self client email: anObject
]

{ #category : #initialization }
DSSingletonClientRegistry >> initialize [
	super initialize.
	selectedChannels := Dictionary new.
	directChannelsItem := DSDirectMessageItem registry: self.
]

{ #category : #testing }
DSSingletonClientRegistry >> isAuthenticated [
	^ self client isAuthenticated 
]

{ #category : #public }
DSSingletonClientRegistry >> login [
	"Login to a Discord server."
	self client login
]

{ #category : #accessing }
DSSingletonClientRegistry >> name [
	^ self email
]

{ #category : #accessing }
DSSingletonClientRegistry >> password [
	^ self client password
]

{ #category : #accessing }
DSSingletonClientRegistry >> password: anObject [
	self client password: anObject
]

{ #category : #accessing }
DSSingletonClientRegistry >> selectedChannel [
	^ self selectedServer
		ifNotNil: [ :aServer | | previousChannel |
			previousChannel := selectedChannels at: aServer id ifAbsent: nil.
			previousChannel ifNil: [ | anyChannel |
				anyChannel := aServer textChannels ifNotEmpty: #first ifEmpty: nil.
				self selectedChannel: anyChannel.
				anyChannel ] ].
]

{ #category : #accessing }
DSSingletonClientRegistry >> selectedChannel: aDSChannel [ 
	self selectedServer 
		ifNil: [ selectedChannels at: #noServer put: aDSChannel ]
		ifNotNil: [ :aServer | selectedChannels at: aServer id put: aDSChannel ]
]

{ #category : #accessing }
DSSingletonClientRegistry >> selectedServer [
	^ selectedServer ifNil: [ selectedServer := self servers ifEmpty: nil ifNotEmpty: #first ]
]

{ #category : #accessing }
DSSingletonClientRegistry >> selectedServer: aDSGuild [ 
	selectedServer := aDSGuild
]

{ #category : #accessing }
DSSingletonClientRegistry >> servers [
	^ self client servers copyWith: directChannelsItem
]
