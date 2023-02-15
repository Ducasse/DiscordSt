Class {
	#name : #DSSendDialogBuilder,
	#superclass : #Object,
	#instVars : [
		'morph',
		'itemIndex'
	],
	#category : 'Discord-Integration-Morph'
}

{ #category : #private }
DSSendDialogBuilder >> ensureSubmorphOfClass: aDSSendItemMorphClass [ 
	^ self morph submorphs 
		detect: [ :eachMorph | eachMorph class = aDSSendItemMorphClass ] 
		ifFound: [ :aMorph | aMorph ] 
		ifNone: [ | newMorph |
			newMorph := aDSSendItemMorphClass new.
			itemIndex > 1 
				ifTrue: [ | previousMorph |
					previousMorph := self morph submorphs at: itemIndex - 1.
					self morph addMorph: newMorph after: previousMorph ]
				ifFalse: [ 
					self morph addMorphBack: newMorph ].
			newMorph ]
]

{ #category : #enumerating }
DSSendDialogBuilder >> itemsDo: oneArgBlock [
	"iterate morph's items" 
	self morph items do: oneArgBlock
]

{ #category : #enumerating }
DSSendDialogBuilder >> itemsWithIndexDo: twoArgsBlock [
	"iterate morph's items" 
	self morph items withIndexDo: twoArgsBlock
]

{ #category : #accessing }
DSSendDialogBuilder >> morph [
	^ morph
]

{ #category : #accessing }
DSSendDialogBuilder >> morph: anObject [
	morph := anObject
]

{ #category : #actions }
DSSendDialogBuilder >> updateMorph [
	"Update SendDialogMorph object according to its items object."
	self itemsWithIndexDo: [ :sendItem :index | 
		itemIndex := index.
		sendItem accept: self ]
]

{ #category : #visiting }
DSSendDialogBuilder >> visitDSSendAttachmentsItem: aDSSendAttachmentsItem [ 
	| submorph |
	submorph := self ensureSubmorphOfClass: DSSendAttachmentsItemMorph.
	submorph item: aDSSendAttachmentsItem.
]

{ #category : #visiting }
DSSendDialogBuilder >> visitDSSendInformationItem: aDSSendInformationItem [ 
	"ignore"
]

{ #category : #visiting }
DSSendDialogBuilder >> visitDSSendRegistriesItem: aDSSendRegistriesItem [ 
	| submorph |
	submorph := self ensureSubmorphOfClass: DSSendRegistriesItemMorph.
	submorph item: aDSSendRegistriesItem.
	submorph unsubscribeCancelAndSendActions: self morph.
	submorph 
		onCancelSend: #cancelAction to: self morph;
		onSendSend: #sendAction to: self morph.
]

{ #category : #visiting }
DSSendDialogBuilder >> visitDSSendUserTextMessageItem: aDSSendUserTextMessageItem [ 
	| itemMorph |
	itemMorph := self ensureSubmorphOfClass: DSSendUserTextMessageItemMorph.
	itemMorph item: aDSSendUserTextMessageItem.
]
