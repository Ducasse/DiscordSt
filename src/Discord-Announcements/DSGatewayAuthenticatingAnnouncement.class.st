Class {
	#name : #DSGatewayAuthenticatingAnnouncement,
	#superclass : #DSGatewayAnnouncement,
	#instVars : [
		'status'
	],
	#category : 'Discord-Announcements'
}

{ #category : #accessing }
DSGatewayAuthenticatingAnnouncement >> status [
	^ status
]

{ #category : #accessing }
DSGatewayAuthenticatingAnnouncement >> status: anObject [
	status := anObject
]
