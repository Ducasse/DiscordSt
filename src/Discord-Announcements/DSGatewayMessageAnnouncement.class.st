Class {
	#name : #DSGatewayMessageAnnouncement,
	#superclass : #DSGatewayPayloadAnnouncement,
	#category : 'Discord-Announcements'
}

{ #category : #accessing }
DSGatewayMessageAnnouncement >> message [
	^ self payload eventData
]
