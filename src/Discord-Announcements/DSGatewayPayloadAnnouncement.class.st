Class {
	#name : #DSGatewayPayloadAnnouncement,
	#superclass : #DSGatewayAnnouncement,
	#instVars : [
		'payload'
	],
	#category : 'Discord-Announcements'
}

{ #category : #'instance creation' }
DSGatewayPayloadAnnouncement class >> payload: aDSGatewayPayload [
	^ self new 
			payload: aDSGatewayPayload
			yourself
]

{ #category : #accessing }
DSGatewayPayloadAnnouncement >> payload [
	^ payload
]

{ #category : #accessing }
DSGatewayPayloadAnnouncement >> payload: anObject [
	payload := anObject
]
