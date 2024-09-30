Class {
	#name : 'DSNoCommand',
	#superclass : 'DSCommand',
	#classInstVars : [
		'uniqueInstance'
	],
	#category : 'Discord-Core-Commands',
	#package : 'Discord-Core',
	#tag : 'Commands'
}

{ #category : 'cleanup' }
DSNoCommand class >> cleanUp [
	self reset.
]

{ #category : 'cleanup' }
DSNoCommand class >> reset [
	uniqueInstance := nil.
]

{ #category : 'accessing' }
DSNoCommand class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : 'execute' }
DSNoCommand >> execute [
	"do nothing"
]
