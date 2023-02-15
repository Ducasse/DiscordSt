Class {
	#name : #DSSendDialogMorph,
	#superclass : #DSPanelMorph,
	#instVars : [
		'items'
	],
	#category : 'Discord-Integration-Morph'
}

{ #category : #examples }
DSSendDialogMorph class >> empty [
	<gtExample>
	<label: 'An empty dialog that informs when the Send button is pressed'>
	^ self new
		onSendDo: [ :ann | self inform: 'Send message...' ];
		extent: 500@300;
		yourself
]

{ #category : #examples }
DSSendDialogMorph class >> emptyInWindow [
	<example>
	^ self empty openInWindow
]

{ #category : #examples }
DSSendDialogMorph class >> textOnly [
	<gtExample>
	<label: 'Send dialog with text editing area'>
	^ self empty
		items: DSSendItems textAndRegistries;
		yourself
]

{ #category : #examples }
DSSendDialogMorph class >> textOnlyInWindow [
	<example>
	^ self textOnly openInWindow
]

{ #category : #examples }
DSSendDialogMorph class >> textScreenshotsAndRegistries [
	<gtExample>
	<label: 'Send dialog with text editing area and screenshots'>
	^ self empty
		items: DSSendItems textScreenshotsAndRegistries;
		yourself
]

{ #category : #examples }
DSSendDialogMorph class >> textScreenshotsAndRegistriesInWindow [
	<example>
	^ self textScreenshotsAndRegistries openInWindow
]

{ #category : #examples }
DSSendDialogMorph class >> textScreenshotsPackagesAndRegistries [
	<gtExample>
	<label: 'Send dialog with text editing area, screenshots, and packages'>
	^ self empty
		items: DSSendItems textScreenshotsPackagesAndRegistries;
		yourself
]

{ #category : #examples }
DSSendDialogMorph class >> textScreenshotsPackagesAndRegistriesInWindow [
	<example>
	^ self textScreenshotsPackagesAndRegistries openInWindow
]

{ #category : #'private-actions' }
DSSendDialogMorph >> cancelAction [
	"Handle cancel user request (an user clicked on Cancel button)."
	self close.
]

{ #category : #'initialize-release' }
DSSendDialogMorph >> close [
	self containingWindow ifNotNil: #delete ifNil: [ self delete ]
]

{ #category : #accessing }
DSSendDialogMorph >> defaultLabel [
	^ 'Send Message Dialog'
]

{ #category : #initialization }
DSSendDialogMorph >> defaultListDirection [
	^ #topToBottom
]

{ #category : #initialization }
DSSendDialogMorph >> initialize [
	super initialize.
	items := DSSendItems new.
	self itemsChangedFrom: nil to: items.
]

{ #category : #accessing }
DSSendDialogMorph >> items [
	^ items
]

{ #category : #accessing }
DSSendDialogMorph >> items: aDSSendItems [
	| oldItems |
	aDSSendItems = items ifTrue: [ ^ self ].
	oldItems := items.
	items := aDSSendItems.
	self itemsChangedFrom: oldItems to: aDSSendItems.
]

{ #category : #accessing }
DSSendDialogMorph >> itemsChangedFrom: oldSendItems to: aDSSendItems [
	DSSendDialogBuilder new
		morph: self;
		updateMorph
]

{ #category : #enumerating }
DSSendDialogMorph >> onSendDo: oneArgBlock [
	"Announce the send request.
	DSScreenshotSendRequestAnnouncement instance holds an instance of myself."
	self onAnnouncement: DSScreenshotSendRequestAnnouncement do: oneArgBlock.
]

{ #category : #'private-actions' }
DSSendDialogMorph >> sendAction [
	"Handle send user request (an user clicked on Send button)."
	self items send.
	self close.
]
