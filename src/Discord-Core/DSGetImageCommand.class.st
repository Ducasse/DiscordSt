Class {
	#name : 'DSGetImageCommand',
	#superclass : 'DSCommand',
	#instVars : [
		'image'
	],
	#category : 'Discord-Core-Commands',
	#package : 'Discord-Core',
	#tag : 'Commands'
}

{ #category : 'execute' }
DSGetImageCommand >> execute [
	self image data
]

{ #category : 'accessing' }
DSGetImageCommand >> image [
	^ image
]

{ #category : 'accessing' }
DSGetImageCommand >> image: anObject [
	image := anObject
]
