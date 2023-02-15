Class {
	#name : #DSNoRegistry,
	#superclass : #DSConnectionRegistry,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : 'Discord-Registry-Core'
}

{ #category : #cleanup }
DSNoRegistry class >> cleanUp [
	self reset.
]

{ #category : #accessing }
DSNoRegistry class >> reset [
	uniqueInstance := nil.
]

{ #category : #accessing }
DSNoRegistry class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #accessing }
DSNoRegistry >> channelsOfSelectedServer [
	^ DSChannels empty
]

{ #category : #accessing }
DSNoRegistry >> selectedChannel [
	"Nothing is selected"
	^ nil
]

{ #category : #accessing }
DSNoRegistry >> selectedServer [
	"Nothing is selected"
	^ nil
]

{ #category : #accessing }
DSNoRegistry >> servers [
	^ DSGuilds new
]
