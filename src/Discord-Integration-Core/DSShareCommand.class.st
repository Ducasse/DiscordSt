Class {
	#name : #DSShareCommand,
	#superclass : #DSCommand,
	#instVars : [
		'registries'
	],
	#category : 'Discord-Integration-Core'
}

{ #category : #private }
DSShareCommand >> addMorphScreenshot: aMorph to: items [
	items addMorphScreenshotAttachment: aMorph.
	items screenshotsAttachment 
		isSelected: self settingsClass wasScreenshotsSelected;
		onSelectionChangedDo: [ :announcement | 
			self settingsClass wasScreenshotsSelected: announcement state ].
]

{ #category : #initialization }
DSShareCommand >> initialize [
	super initialize.
	registries := DSRegistries uniqueInstance.
]

{ #category : #accessing }
DSShareCommand >> registries [
	<return: #DSRegistries>
	^ registries
]

{ #category : #accessing }
DSShareCommand >> registries: aDSRegistries [
	self assert: [ aDSRegistries notNil ] description: 'It has to be a DSRegistries object'.
	registries := aDSRegistries
]

{ #category : #accessing }
DSShareCommand >> settingsClass [
	^ DSShareSettings
]
