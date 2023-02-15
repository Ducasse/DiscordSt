"
I represent collection of DSChannels
"
Class {
	#name : #DSChannels,
	#superclass : #DSOrderedCollection,
	#category : 'Discord-Core-Collections'
}

{ #category : #examples }
DSChannels class >> oneDirectChannel [
	<gtExample>
	<label: 'One direct channel'>
	^ self with: DSDirectMessageChannel oneRecipient
]

{ #category : #examples }
DSChannels class >> twoChannels [
	<gtExample>
	<label: 'Two channels in one category'>
	^ self jsonMappingClass 
		read: #CollectionOfSortedChannels 
		withMapping: #collectionOfSortedChannelsMappingFor:
		on: self jsonMappingClass jsonCollectionOfChannelsThree readStream
]

{ #category : #'gt-inspector-extension' }
DSChannels >> gtInspectorChannels: composite [
	<gtInspectorPresentationOrder: -1>
	^ composite fastTree
		title: [ 'Channels' translated ];
		display: [ self ];
		when: [ self notEmpty ];
		children: [ :item | item children ];
		expandedUntil: 1;
		yourself
]

{ #category : #'neo-json' }
DSChannels >> neoJsonOn: neoJSONWriter [
	| flattenedChannels |
	flattenedChannels := DSFlattenChannelsOrderByIdCommand new
		channels: self;
		execute;
		flattenedChannels.
	neoJSONWriter writeList: flattenedChannels
]
