"
I flatten a tree hierarchy to a collection of channels. 
The flattened collection ends up with all channels and categories.
The flattened collection keeps the same order os the original collection.
I expect only one level tree. It means, channel categories can contain only real channels, expluding other categories. 
I complement DSSortChannelsCommand.
I am useful for displaying channels in a list.

Public API and Key Messages

- channels collection of channels to flattern
- flattenedChannels all channels in one collection, including the channels in category

Internal Representation and Key Implementation Points.

    Instance Variables
	channels:				<Array>
	flattenedChannels:		<Array>

"
Class {
	#name : 'DSFlattenChannelsKeepOrderCommand',
	#superclass : 'DSChannelsCommand',
	#instVars : [
		'flattenedChannels'
	],
	#category : 'Discord-Core-Commands',
	#package : 'Discord-Core',
	#tag : 'Commands'
}

{ #category : 'execute' }
DSFlattenChannelsKeepOrderCommand >> execute [
	self flattenedChannels: (Array streamContents: [ :aStream |
		self channels do: [ :eachChannel | 
			aStream nextPut: eachChannel.
			eachChannel isCategory ifTrue: [ aStream nextPutAll: eachChannel subordinateChannels ] ] ]).
]

{ #category : 'accessing' }
DSFlattenChannelsKeepOrderCommand >> flattenedChannels [
	^ flattenedChannels
]

{ #category : 'accessing' }
DSFlattenChannelsKeepOrderCommand >> flattenedChannels: anObject [
	flattenedChannels := anObject
]
