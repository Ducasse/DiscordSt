Class {
	#name : #DSDirectMessageItem,
	#superclass : #Object,
	#instVars : [
		'registry'
	],
	#category : 'Discord-Registry-Core'
}

{ #category : #'instance creation' }
DSDirectMessageItem class >> registry: aDSRegistry [ 
	^ self new
		registry: aDSRegistry;
		yourself
]

{ #category : #accessing }
DSDirectMessageItem >> id [
	"Complement DSGuild id"
	^ '4e4e363f-a221-0d00-a38a-48c400dc3839'
]

{ #category : #accessing }
DSDirectMessageItem >> name [
	^ 'Direct Messages'
]

{ #category : #accessing }
DSDirectMessageItem >> registry [
	^ registry
]

{ #category : #accessing }
DSDirectMessageItem >> registry: anObject [
	registry := anObject
]

{ #category : #accessing }
DSDirectMessageItem >> textChannels [
	<return: #DSChannels of: #DSDirectMessageChannel>
	^ self registry directChannels
]
