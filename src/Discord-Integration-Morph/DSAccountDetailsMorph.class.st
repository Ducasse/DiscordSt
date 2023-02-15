Class {
	#name : #DSAccountDetailsMorph,
	#superclass : #DSPanelMorph,
	#instVars : [
		'registry'
	],
	#category : 'Discord-Integration-Morph'
}

{ #category : #examples }
DSAccountDetailsMorph class >> authenticatedClient [
	<gtExample>
	<label: 'Shows a client server and channel list'>
	^ self empty
		registry: DSMockClient authenticated asRegistry;
		yourself
]

{ #category : #examples }
DSAccountDetailsMorph class >> authenticatedClientInWindow [
	<example>
	^ self authenticatedClient openInWindow
]

{ #category : #examples }
DSAccountDetailsMorph class >> clientToLogin [
	<gtExample>
	<label: 'Shows a client login request'>
	^ self empty
		registry: DSMockClient unsigned asRegistry;
		yourself
]

{ #category : #examples }
DSAccountDetailsMorph class >> clientToLoginInWindow [
	<example>
	^ self clientToLogin openInWindow
]

{ #category : #examples }
DSAccountDetailsMorph class >> empty [
	<gtExample>
	<label: 'Basic Example'>
	^ self new 
			extent: 400@100;
			yourself.
]

{ #category : #examples }
DSAccountDetailsMorph class >> webhook [
	<gtExample>
	<label: 'Shows a webhook info (which is an empty window)'>
	^ self empty
		registry: DSWebhookRegistry learningHelpChannel;
		yourself
]

{ #category : #examples }
DSAccountDetailsMorph class >> webhookInWindow [
	<example>
	^ self webhook openInWindow
]

{ #category : #'private - adding' }
DSAccountDetailsMorph >> addAuthenticatedClientMorph [
	| morph |
	morph := self newAuthenticatedClientMorph.
	self addMorphBack: morph.
	^ morph
]

{ #category : #'private - adding' }
DSAccountDetailsMorph >> addClientLoginMorph [
	| loginMorph |
	loginMorph := self newClientLoginMorph.
	self addMorphBack: loginMorph.
	^ loginMorph
]

{ #category : #'private - adding' }
DSAccountDetailsMorph >> addWebhookMorph [
	| morph |
	morph := self newWebhookMorph.
	self addMorphBack: morph.
	^ morph
]

{ #category : #updating }
DSAccountDetailsMorph >> ensureAuthenticatedClientMorph [
	self
		assert: [ self submorphs size < 2 ]
		description: 'There should be at most one submorph'.
	self submorphs size isZero
		ifTrue: [ ^ self addAuthenticatedClientMorph ].
	self submorphs first isAuthenticatedClientMorph
		ifFalse: [ 
			self submorphs first delete.
			^ self addAuthenticatedClientMorph ].
	^ self submorphs first
]

{ #category : #updating }
DSAccountDetailsMorph >> ensureClientLoginMorph [
	self
		assert: [ self submorphs size < 2 ]
		description: 'There should be at most one submorph'.
	self submorphs size isZero
		ifTrue: [ ^ self addClientLoginMorph ].
	self submorphs first isClientLoginMorph
		ifFalse: [ 
			self submorphs first delete.
			^ self addClientLoginMorph ].
	^ self submorphs first
]

{ #category : #updating }
DSAccountDetailsMorph >> ensureWebhookRegistry [
	self
		assert: [ self submorphs size < 2 ]
		description: 'There should be at most one submorph'.
	self submorphs size isZero
		ifTrue: [ ^ self addWebhookMorph ].
	self submorphs first isWebhookMorph
		ifFalse: [ 
			self submorphs first delete.
			^ self addWebhookMorph ].
	^ self submorphs first
]

{ #category : #'announcement handling' }
DSAccountDetailsMorph >> handleUserAuthenticatedAnnouncement: aDSAuthenticatedAnnouncement [ 
	self updateView
]

{ #category : #'instance creation' }
DSAccountDetailsMorph >> newAuthenticatedClientMorph [
	^ DSServerChannelListMorph new
		vResizing: #shrinkWrap;
		yourself
]

{ #category : #'instance creation' }
DSAccountDetailsMorph >> newClientLoginMorph [
	^ DSClientLoginMorph new
		vResizing: #shrinkWrap;
		yourself
]

{ #category : #'instance creation' }
DSAccountDetailsMorph >> newWebhookMorph [
	^ DSWebhookMorph new
		hResizing: #spaceFill;
		vResizing: #shrinkWrap;
		yourself
]

{ #category : #private }
DSAccountDetailsMorph >> registerTo: aDSClientRegistry [ 
	"Register to changes (announcements)."
	aDSClientRegistry accept: (DSAccountDetailsSubscribeRequest new
		morph: self;
		yourself)
]

{ #category : #accessing }
DSAccountDetailsMorph >> registry [
	^ registry
]

{ #category : #accessing }
DSAccountDetailsMorph >> registry: aDSConnectionRegistry [
	registry := aDSConnectionRegistry.
	self registerTo: aDSConnectionRegistry. 
	self updateView.
]

{ #category : #updating }
DSAccountDetailsMorph >> updateView [
	"Update view according to new registry state."
	self registry accept: (DSAccountDetailsUpdateRequest new
		morph: self;
		yourself)
]
