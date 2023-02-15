"
I am a superclass for all Discord client events that someone might want to announce. 
I am an abstract announcement.

"
Class {
	#name : #DSAnnouncement,
	#superclass : #Announcement,
	#category : 'Discord-Announcements'
}

{ #category : #testing }
DSAnnouncement class >> isAbstract [
	^ self = DSAnnouncement
]
