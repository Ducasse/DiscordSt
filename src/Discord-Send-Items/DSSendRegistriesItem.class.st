Class {
	#name : #DSSendRegistriesItem,
	#superclass : #DSSendItem,
	#instVars : [
		'registries'
	],
	#category : 'Discord-Send-Items'
}

{ #category : #examples }
DSSendRegistriesItem class >> twoWebhooksAndOneClient [
	<gtExample>
	<label: 'Choose registry'>
	^ self new
		registries: DSRegistries twoWebhooksAndOneClient;
		yourself
]

{ #category : #visiting }
DSSendRegistriesItem >> accept: aVisitor [
	^ aVisitor visitDSSendRegistriesItem: self
]

{ #category : #accessing }
DSSendRegistriesItem >> children [
	^ self registries
]

{ #category : #'gt-inspector-extension' }
DSSendRegistriesItem >> gtInspectorRegistriesIn: composite [
	<gtInspectorPresentationOrder: 1>
	^ composite fastList
			title: [ 'Registries' translated ];
			display: [ self registries ];
			when: [ self registries isEmptyOrNil not ];
			yourself
]

{ #category : #initialization }
DSSendRegistriesItem >> initialize [
	super initialize.
	registries := DSRegistries uniqueInstance.
]

{ #category : #testing }
DSSendRegistriesItem >> isRegistriesItem [
	^ true
]

{ #category : #accessing }
DSSendRegistriesItem >> registries [
	^ registries
]

{ #category : #accessing }
DSSendRegistriesItem >> registries: anObject [
	registries := anObject
]

{ #category : #accessing }
DSSendRegistriesItem >> selectedRegistry [
	<return: #DSConnectionRegistry>
	^ self registries selection
]

{ #category : #actions }
DSSendRegistriesItem >> send: aDSSendItems [ 
	"Send items to a selected communication channel."
	self selectedRegistry send: aDSSendItems
]
