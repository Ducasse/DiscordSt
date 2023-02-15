Class {
	#name : #DSSendAttachmentsItem,
	#superclass : #DSSendSelectableItem,
	#instVars : [
		'attachments'
	],
	#category : 'Discord-Send-Items'
}

{ #category : #accessing }
DSSendAttachmentsItem class >> codeSnippet [
	<gtExample>
	<label: 'With a code snippet attachment'>
	^ self new
		addCodeSnippet: (String loremIpsum: 100);
		yourself
]

{ #category : #accessing }
DSSendAttachmentsItem class >> screenshotsAndPackages [
	<gtExample>
	<label: 'With screenshots and packages'>
	^ self new
		add: DSSendScreenshotsAttachment twoRandomMorphs;
		add: DSSendPackagesAttachment withObjectAndCollectionClasses;
		yourself
]

{ #category : #accessing }
DSSendAttachmentsItem class >> twoPackages [
	<gtExample>
	<label: 'With a packages attachment'>
	^ self new
		add: DSSendPackagesAttachment withObjectAndCollectionClasses;
		yourself
]

{ #category : #accessing }
DSSendAttachmentsItem class >> twoRandomMorphs [
	<gtExample>
	<label: 'With a two random morpht attachments'>
	^ self new
		add: DSSendScreenshotsAttachment twoRandomMorphs;
		yourself
]

{ #category : #visiting }
DSSendAttachmentsItem >> accept: aVisitor [
	^ aVisitor visitDSSendAttachmentsItem: self
]

{ #category : #adding }
DSSendAttachmentsItem >> add: aDSSendAttachment [ 
	aDSSendAttachment isEnabled: self isSelectedAndEnabled.
	^ self attachments add: aDSSendAttachment
]

{ #category : #adding }
DSSendAttachmentsItem >> addCodeSnippet: aString [ 
	^ self add: (DSSendCodeSnippetAttachment new codeSnippet: aString; yourself)
]

{ #category : #adding }
DSSendAttachmentsItem >> addMorphScreenshot: aMorph [ 
	^ self screenshotsAttachment addMorph: aMorph
]

{ #category : #adding }
DSSendAttachmentsItem >> addPackages: aDSPackages [ 
	^ self add: (DSSendPackagesAttachment new packages: aDSPackages; yourself)
]

{ #category : #accessing }
DSSendAttachmentsItem >> attachments [
	^ attachments
]

{ #category : #accessing }
DSSendAttachmentsItem >> attachments: anObject [
	attachments := anObject
]

{ #category : #private }
DSSendAttachmentsItem >> basicChildren [
	^ self attachments
]

{ #category : #accessing }
DSSendAttachmentsItem >> children [
	"Return attachments that should be displayed to user"
	<return: #Array of: #DSSentAttachment>
	^ self attachments
]

{ #category : #'gt-inspector-extension' }
DSSendAttachmentsItem >> gtInspectorAttachmentsIn: composite [
	<gtInspectorPresentationOrder: 2>
	^ composite fastTree
		title: [ 'Attachments' translated ];
		display: [ self attachments ];
		children: [ :item | item children ];
		expandedUntil: 1;
		yourself
]

{ #category : #initialization }
DSSendAttachmentsItem >> initialize [
	super initialize.
	attachments := OrderedCollection new.
]

{ #category : #testing }
DSSendAttachmentsItem >> isAttachmentItem [
	^ true
]

{ #category : #testing }
DSSendAttachmentsItem >> isSelectedAndEnabled [
	^ self isSelected and: [ self isEnabled ]
]

{ #category : #accessing }
DSSendAttachmentsItem >> screenshotsAttachment [
	"Ensure there is a screenshots attachment"
	^ self attachments 
		detect: [ :eachAttachment | eachAttachment class = DSSendScreenshotsAttachment ]
		ifFound: [ :attachment | attachment ]
		ifNone: [ self add: DSSendScreenshotsAttachment new ]
]
