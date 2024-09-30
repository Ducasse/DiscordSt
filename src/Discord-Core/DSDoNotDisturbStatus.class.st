"
I represent DND, Do Not Disturd status.
"
Class {
	#name : 'DSDoNotDisturbStatus',
	#superclass : 'DSConnectionStatus',
	#category : 'Discord-Core-Model',
	#package : 'Discord-Core',
	#tag : 'Model'
}

{ #category : 'accessing' }
DSDoNotDisturbStatus class >> description [
	^ 'Do Not Disturb'
]

{ #category : 'accessing' }
DSDoNotDisturbStatus class >> statusString [
	^ 'dnd'
]
