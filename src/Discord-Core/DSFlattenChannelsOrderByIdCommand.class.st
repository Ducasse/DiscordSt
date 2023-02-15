"
I flatten a tree hierarchy to a collection of channels. 
The flattened collection ends up with all channels and categories.
The flattened collection is ordered by channel ids.
I expect only one level tree. It means, channel categories can contain only real channels, expluding other categories. 
I complement DSSortChannelsCommand and I am useful for testing purpose.

Public API and Key Messages

- channels collection of channels to flattern
- flattenedChannels all channels in one collection, including the channels in category

Internal Representation and Key Implementation Points.

    Instance Variables
	channels:				<Array>
	flattenedChannels:		<Array>

"
Class {
	#name : #DSFlattenChannelsOrderByIdCommand,
	#superclass : #DSChannelsCommand,
	#instVars : [
		'flattenedChannels'
	],
	#category : 'Discord-Core-Commands'
}

{ #category : #execute }
DSFlattenChannelsOrderByIdCommand >> execute [
	self flattenedChannels: (Array streamContents: [ :aStream |
		self channels do: [ :eachChannel | 
			aStream nextPut: eachChannel.
			eachChannel isCategory ifTrue: [ aStream nextPutAll: eachChannel subordinateChannels ] ] ]).
	self flattenedChannels sort: [ :a :b | a id < b id ].
]

{ #category : #accessing }
DSFlattenChannelsOrderByIdCommand >> flattenedChannels [
	"Return a flattened collection of channels."
	<return: #Array of: #DSChannel>
	^ flattenedChannels
]

{ #category : #accessing }
DSFlattenChannelsOrderByIdCommand >> flattenedChannels: anObject [
	flattenedChannels := anObject
]
