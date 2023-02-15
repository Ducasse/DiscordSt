"
I represent idle status.
"
Class {
	#name : #DSIdleStatus,
	#superclass : #DSConnectionStatus,
	#category : 'Discord-Core-Model'
}

{ #category : #accessing }
DSIdleStatus class >> description [
	^ 'Away from Keyboard (AFK)'
]

{ #category : #accessing }
DSIdleStatus class >> statusString [
	^ 'idle'
]
