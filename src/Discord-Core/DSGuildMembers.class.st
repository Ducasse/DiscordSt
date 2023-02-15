"
I represent collection of DSGuildMember.
"
Class {
	#name : #DSGuildMembers,
	#superclass : #DSOrderedCollection,
	#category : 'Discord-Core-Collections'
}

{ #category : #examples }
DSGuildMembers class >> basic [
	<gtExample>
	<label: 'One Guild Member'>
	^ self jsonMappingClass
		read: #CollectionOfGuildMembers
		withMapping: #collectionOfGuildMembersMappingFor:
		on: self jsonMappingClass jsonCollectionOfGuildMembersOne readStream
]

{ #category : #'gt-inspector-extension' }
DSGuildMembers >> gtInspectorMembers: composite [
	<gtInspectorPresentationOrder: -1>
	^ composite fastTree
		title: [ 'Members' translated ];
		display: [ self ];
		when: [ self notEmpty ];
		children: [ :item | item children ];
		yourself
]
