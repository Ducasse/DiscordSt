Class {
	#name : #DSSendRegistriesItemMorph,
	#superclass : #DSSendItemMorph,
	#instVars : [
		'items'
	],
	#category : 'Discord-Integration-Morph'
}

{ #category : #examples }
DSSendRegistriesItemMorph class >> twoWebhooksAndOneClient [
	<gtExample>
	<label: 'Choose registry'>
	^ self basic
		item: DSSendRegistriesItem twoWebhooksAndOneClient;
		yourself.
]

{ #category : #examples }
DSSendRegistriesItemMorph class >> twoWebhooksAndOneClientInWindow [
	<example>
	^ self twoWebhooksAndOneClient openInWindow
]

{ #category : #initialization }
DSSendRegistriesItemMorph >> defaultListDirection [
	^ #topToBottom
]

{ #category : #initialization }
DSSendRegistriesItemMorph >> defaultVerticalResizing [
	^ #shrinkWrap
]

{ #category : #initialization }
DSSendRegistriesItemMorph >> initialize [
	super initialize.
	self addMorphBack: self newSendbarMorph.
	self addMorphBack: self newAccountDetailsMorph.
]

{ #category : #'announcement handling' }
DSSendRegistriesItemMorph >> itemChangedFrom: oldDSSendItem to: newDSSendItem [
	oldDSSendItem registries unsubscribe: self.
	self submorphs first registries: newDSSendItem registries.
	self submorphs second registry: newDSSendItem registries selection.
	newDSSendItem registries onSelectionChangedDo: [ :ann | 
		self submorphs second registry: ann selection ].
]

{ #category : #accessing }
DSSendRegistriesItemMorph >> items [
	^ items
]

{ #category : #accessing }
DSSendRegistriesItemMorph >> items: anObject [
	items := anObject
]

{ #category : #'instance creation' }
DSSendRegistriesItemMorph >> newAccountDetailsMorph [
	^ DSAccountDetailsMorph new
		hResizing: #spaceFill;
		vResizing: #shrinkWrap;
		yourself
]

{ #category : #'instance creation' }
DSSendRegistriesItemMorph >> newSendItem [
	<return: #DSSendItem>
	^ DSSendRegistriesItem new.
]

{ #category : #'instance creation' }
DSSendRegistriesItemMorph >> newSendbarMorph [
	^ DSSendActionbarMorph new
		hResizing: #spaceFill; 
		vResizing: #shrinkWrap;
		yourself
]

{ #category : #'announcements-registration' }
DSSendRegistriesItemMorph >> onCancelSend: aSymbol to: anObject [ 
	^ self submorphs first onCancelSend: aSymbol to: anObject 
]

{ #category : #'announcements-registration' }
DSSendRegistriesItemMorph >> onSendSend: aSymbol to: anObject [ 
	^ self submorphs first onSendSend: aSymbol to: anObject 
]

{ #category : #'announcements-registration' }
DSSendRegistriesItemMorph >> unsubscribeCancelAndSendActions: anObject [ 
	self submorphs first unsubscribeCancelAndSendActions: anObject
]
