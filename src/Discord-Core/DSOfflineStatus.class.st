"
I represent offline status.
"
Class {
	#name : #DSOfflineStatus,
	#superclass : #DSConnectionStatus,
	#category : 'Discord-Core-Model'
}

{ #category : #accessing }
DSOfflineStatus class >> description [
	^ 'Offline'
]

{ #category : #accessing }
DSOfflineStatus class >> statusString [
	^ 'offline'
]
