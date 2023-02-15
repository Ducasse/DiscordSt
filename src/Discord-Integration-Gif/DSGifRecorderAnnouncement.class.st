Class {
	#name : #DSGifRecorderAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'recorder'
	],
	#category : 'Discord-Integration-Gif'
}

{ #category : #'instance creation' }
DSGifRecorderAnnouncement class >> recorder: aDSAnimatedGifRecorder [ 
	^ self new
		recorder: aDSAnimatedGifRecorder;
		yourself.
]

{ #category : #accessing }
DSGifRecorderAnnouncement >> recorder [
	^ recorder
]

{ #category : #accessing }
DSGifRecorderAnnouncement >> recorder: anObject [
	recorder := anObject
]
