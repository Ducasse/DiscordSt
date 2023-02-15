"
I represent DND, Do Not Disturd status.
"
Class {
	#name : #DSDoNotDisturbStatus,
	#superclass : #DSConnectionStatus,
	#category : 'Discord-Core-Model'
}

{ #category : #accessing }
DSDoNotDisturbStatus class >> description [
	^ 'Do Not Disturb'
]

{ #category : #accessing }
DSDoNotDisturbStatus class >> statusString [
	^ 'dnd'
]
