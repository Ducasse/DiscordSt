"
I represent online status.
"
Class {
	#name : #DSOnlineStatus,
	#superclass : #DSConnectionStatus,
	#category : 'Discord-Core-Model'
}

{ #category : #accessing }
DSOnlineStatus class >> description [
	^ 'Online'
]

{ #category : #accessing }
DSOnlineStatus class >> statusString [
	^ 'online'
]
