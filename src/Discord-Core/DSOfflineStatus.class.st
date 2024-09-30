"
I represent offline status.
"
Class {
	#name : 'DSOfflineStatus',
	#superclass : 'DSConnectionStatus',
	#category : 'Discord-Core-Model',
	#package : 'Discord-Core',
	#tag : 'Model'
}

{ #category : 'accessing' }
DSOfflineStatus class >> description [
	^ 'Offline'
]

{ #category : 'accessing' }
DSOfflineStatus class >> statusString [
	^ 'offline'
]
