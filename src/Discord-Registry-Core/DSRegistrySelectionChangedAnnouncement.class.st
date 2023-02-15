Class {
	#name : #DSRegistrySelectionChangedAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'registries',
		'selection'
	],
	#category : 'Discord-Registry-Core'
}

{ #category : #accessing }
DSRegistrySelectionChangedAnnouncement >> registries [
	^ registries
]

{ #category : #accessing }
DSRegistrySelectionChangedAnnouncement >> registries: anObject [
	registries := anObject
]

{ #category : #accessing }
DSRegistrySelectionChangedAnnouncement >> selection [
	^ selection
]

{ #category : #accessing }
DSRegistrySelectionChangedAnnouncement >> selection: anObject [
	selection := anObject
]
