Class {
	#name : #DSSendItems,
	#superclass : #Object,
	#instVars : [
		'collection'
	],
	#category : 'Discord-Send-Items'
}

{ #category : #examples }
DSSendItems class >> textAndRegistries [
	<gtExample>
	<label: 'Choose registry'>
	^ self new 
		collection: { 
			DSSendUserTextMessageItem new.
			DSSendRegistriesItem twoWebhooksAndOneClient };
		yourself
]

{ #category : #examples }
DSSendItems class >> textScreenshotsAndRegistries [
	<gtExample>
	<label: 'Choose registry'>
	^ self new 
		collection: { 
			DSSendUserTextMessageItem new.
			DSSendAttachmentsItem twoRandomMorphs.
			DSSendRegistriesItem twoWebhooksAndOneClient };
		yourself
]

{ #category : #examples }
DSSendItems class >> textScreenshotsPackagesAndRegistries [
	<gtExample>
	<label: 'Choose registry'>
	^ self new 
		collection: { 
			DSSendUserTextMessageItem new.
			DSSendAttachmentsItem screenshotsAndPackages.
			DSSendRegistriesItem twoWebhooksAndOneClient };
		yourself
]

{ #category : #adding }
DSSendItems >> addCodeSnippetAttachment: aString [ 
	^ self attachmentItem addCodeSnippet: aString
]

{ #category : #adding }
DSSendItems >> addMorphScreenshotAttachment: aMorph [ 
	^ self attachmentItem addMorphScreenshot: aMorph
]

{ #category : #adding }
DSSendItems >> addPackagesAttachment: aDSPackages [ 
	^ self attachmentItem addPackages: aDSPackages
]

{ #category : #'accessing - convenience' }
DSSendItems >> attachmentItem [
	"Return an attachment item"
	<return: #DSSendAttachmentsItem>
	^ self ensureItem: #isAttachmentItem ofClass: DSSendAttachmentsItem
]

{ #category : #accessing }
DSSendItems >> collection [
	^ collection
]

{ #category : #accessing }
DSSendItems >> collection: anObject [
	collection := anObject
]

{ #category : #initialization }
DSSendItems >> defaultCollection [
	"Return a collection of default items that should be send (displayed to user)."
	^ OrderedCollection 
		with: DSSendUserTextMessageItem new
		with: DSSendRegistriesItem new.
]

{ #category : #enumerating }
DSSendItems >> do: oneArgBlock [
	"iterate items" 
	collection do: oneArgBlock
]

{ #category : #'accessing - convenience' }
DSSendItems >> ensureItem: messageSymbol ofClass: aClass [
	<return: #DSSendItem>
	^ self collection 
		detect: [ :eachItem | eachItem perform: messageSymbol ]  
		ifFound: [ :anItem | anItem ] 
		ifNone: [ self collection add: aClass new ]
]

{ #category : #'gt-inspector-extension' }
DSSendItems >> gtInspectorItemsIn: composite [
	<gtInspectorPresentationOrder: 1>
	^ composite fastTree
		title: [ 'Items' translated ];
		display: [ self collection ];
		when: [ self collection notEmpty ];
		children: [ :each | each children ];
		expandedUntil: 2;
		yourself
]

{ #category : #'accessing - convenience' }
DSSendItems >> informationItem [
	"Return an information item"
	<return: #DSSendInformationItem>
	^ self ensureItem: #isInformationItem ofClass: DSSendInformationItem
]

{ #category : #initialization }
DSSendItems >> initialize [
	super initialize.
	collection := self defaultCollection.
]

{ #category : #testing }
DSSendItems >> isEmptyOrNil [
	^ self collection isEmptyOrNil
]

{ #category : #accessing }
DSSendItems >> registries [
	<return: #DSSendRegistriesItem>
	^ self collection detect: #isRegistriesItem
]

{ #category : #'accessing - convenience' }
DSSendItems >> screenshotsAttachment [
	^ self attachmentItem screenshotsAttachment
]

{ #category : #actions }
DSSendItems >> send [
	"Send message to a particular communication channel."
	self registries send: self.
]

{ #category : #'accessing - convenience' }
DSSendItems >> userTextMessageItem [
	"Return an user text message item"
	<return: #DSSendUserTextMessageItem>
	^ self ensureItem: #isUserTextMessageItem ofClass: DSSendUserTextMessageItem
]

{ #category : #enumerating }
DSSendItems >> withIndexDo: twoArgsBlock [
	"iterate items" 
	collection withIndexDo: twoArgsBlock
]
