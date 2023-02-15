Class {
	#name : #DSStateChangedAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'object',
		'state'
	],
	#category : 'Discord-Tools-Support'
}

{ #category : #accessing }
DSStateChangedAnnouncement >> object [
	^ object
]

{ #category : #accessing }
DSStateChangedAnnouncement >> object: anObject [
	object := anObject
]

{ #category : #accessing }
DSStateChangedAnnouncement >> state [
	^ state
]

{ #category : #accessing }
DSStateChangedAnnouncement >> state: anObject [
	state := anObject
]
