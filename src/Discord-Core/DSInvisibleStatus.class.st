"
I represent invisible status.
"
Class {
	#name : 'DSInvisibleStatus',
	#superclass : 'DSConnectionStatus',
	#category : 'Discord-Core-Model',
	#package : 'Discord-Core',
	#tag : 'Model'
}

{ #category : 'accessing' }
DSInvisibleStatus class >> description [
	^ 'Invisible and shown as offline'
]

{ #category : 'accessing' }
DSInvisibleStatus class >> statusString [
	^ 'invisible'
]
