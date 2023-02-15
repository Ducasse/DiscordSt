Class {
	#name : #DSGifRectangleRequestAnnouncement,
	#superclass : #DSGifRecorderAnnouncement,
	#instVars : [
		'rectangle'
	],
	#category : 'Discord-Integration-Gif'
}

{ #category : #accessing }
DSGifRectangleRequestAnnouncement >> rectangle [
	^ rectangle
]

{ #category : #accessing }
DSGifRectangleRequestAnnouncement >> rectangle: anObject [
	rectangle := anObject
]
