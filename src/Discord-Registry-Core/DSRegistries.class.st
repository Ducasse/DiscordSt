Class {
	#name : #DSRegistries,
	#superclass : #OrderedCollection,
	#instVars : [
		'selection',
		'announcer'
	],
	#classInstVars : [
		'uniqueInstance',
		'collector'
	],
	#category : 'Discord-Registry-Core'
}

{ #category : #private }
DSRegistries class >> addRegistryFromPragma: aPragma [
	self uniqueInstance
		add:
			((aPragma methodClass instanceSide perform: aPragma methodSelector)
				origin: aPragma)
]

{ #category : #cleanup }
DSRegistries class >> cleanUp [
	self reset.
]

{ #category : #initialization }
DSRegistries class >> initialize [
	"Reset on 2018-02-27 because of #47 error"
	self reset
]

{ #category : #'announcement handling' }
DSRegistries class >> pragmaChanged: aPragmaAnnouncement [
	"New Pragma added or updated. We should updated corresponding registry."
	self pragmaRemoved: aPragmaAnnouncement.
	self addRegistryFromPragma: aPragmaAnnouncement pragma.
]

{ #category : #'announcement handling' }
DSRegistries class >> pragmaRemoved: aPragmaRemoved [ 
	self uniqueInstance
		detect: [ :eachRegistry | eachRegistry origin = aPragmaRemoved pragma ]
		ifFound: [ :existingRegistry | self uniqueInstance remove: existingRegistry ]
		ifNone: [ "ignore" ].
]

{ #category : #cleanup }
DSRegistries class >> reset [
	collector ifNotNil: [ :aCollector | aCollector release. collector := nil. ].
	uniqueInstance := nil.
]

{ #category : #private }
DSRegistries class >> setUniqueInstance [
	"The Singleton registries listen to method changes and updates its items."

	uniqueInstance := self new.
	collector := PragmaCollector
		filter: [ :prg | prg selector = 'registryOrder:' ].
	collector reset.
	collector
		when: PragmaAdded , PragmaUpdated
		send: #pragmaChanged:
		to: self.
	collector when: PragmaRemoved send: #pragmaRemoved: to: self.
	collector collected
		do: [ :eachPragma | self addRegistryFromPragma: eachPragma ]
]

{ #category : #examples }
DSRegistries class >> twoWebhooks [
	<gtExample>
	<label: 'Two webhook registries'>
	^ self 
		with: DSWebhookRegistry learningHelpChannel
		with: DSWebhookRegistry developmentChannel
]

{ #category : #examples }
DSRegistries class >> twoWebhooksAndOneClient [
	<gtExample>
	<label: 'Two webhooks and one client registries'>
	^ self twoWebhooks
		addFirst: DSClientRegistry mockClient;
		yourself
]

{ #category : #accessing }
DSRegistries class >> uniqueInstance [
	uniqueInstance ifNil: [ self setUniqueInstance ].
	^ uniqueInstance
]

{ #category : #examples }
DSRegistries class >> webhook [
	<gtExample>
	<label: 'One webhook registry'>
	^ self with: DSWebhookRegistry learningHelpChannel
]

{ #category : #announcing }
DSRegistries >> announceSelectionChanged: aDSRegistry [ 
	announcer ifNil: [ ^ self ].
	self announcer announce: (DSRegistrySelectionChangedAnnouncement new 
		registries: self; 
		selection: aDSRegistry; 
		yourself)
]

{ #category : #accessing }
DSRegistries >> announcer [
	^ announcer ifNil: [ announcer := self newAnnouncer ]
]

{ #category : #initialize }
DSRegistries >> defaultSelection [
	^ self ifEmpty: [ nil ] ifNotEmpty: #first
]

{ #category : #'instance creation' }
DSRegistries >> newAnnouncer [
	^ Announcer new
]

{ #category : #'announcement registration' }
DSRegistries >> onSelectionChangedDo: oneArgBlock [
	"Register for selection changes.
	oneArgBlock receives the announcement object."

	^ self announcer
		when: DSRegistrySelectionChangedAnnouncement
		do: oneArgBlock
]

{ #category : #accessing }
DSRegistries >> selection [
	^ selection ifNil: [ selection := self defaultSelection ]
]

{ #category : #accessing }
DSRegistries >> selection: anObject [
	self 
		assert: [ anObject isKindOf: DSConnectionRegistry ]
		description: 'It should be a registry'.
	selection := anObject.
	self announceSelectionChanged: anObject.
]

{ #category : #'announcement registration' }
DSRegistries >> unsubscribe: anObject [
	"Unsubscribe all subscriptions of anObject from the receiver"
	self announcer unsubscribe: anObject
]
