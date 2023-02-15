Class {
	#name : #DSNoRegistries,
	#superclass : #Object,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : 'Discord-Registry-Core'
}

{ #category : #cleanup }
DSNoRegistries class >> cleanUp [
	self reset.
]

{ #category : #cleanup }
DSNoRegistries class >> reset [
	uniqueInstance := nil
]

{ #category : #accessing }
DSNoRegistries class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #enumerating }
DSNoRegistries >> collect: aBlockClosure [ 
	^ #()
]

{ #category : #'as yet unclassified' }
DSNoRegistries >> includes: anObject [
	^ false
]

{ #category : #accessing }
DSNoRegistries >> selection [
	^ nil
]

{ #category : #accessing }
DSNoRegistries >> size [
	^ 0
]

{ #category : #subscription }
DSNoRegistries >> unsubscribe: anObject [
	"Unsubscribe all subscriptions of anObject from the receiver"
]
