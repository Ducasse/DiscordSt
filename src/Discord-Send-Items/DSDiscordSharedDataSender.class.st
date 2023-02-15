Class {
	#name : #DSDiscordSharedDataSender,
	#superclass : #DSMessageSender,
	#instVars : [
		'messageBuilder',
		'attachmentTypes',
		'messages'
	],
	#category : 'Discord-Send-Items'
}

{ #category : #adding }
DSDiscordSharedDataSender >> addShareLinkInformation [
	| link |
	self attachmentTypes ifEmpty: [ ^ self ].
	link := DSPharoLinkV2Converter new
		data: self attachmentTypes;
		markdown.
	self items informationItem
		add: (DSSendInformation newShare value: link; yourself).
]

{ #category : #actions }
DSDiscordSharedDataSender >> associateAttachmentsAndTypes [
	messages do: [ :eachMessage | 
		eachMessage attachments do: [ :eachAttachment |
			attachmentTypes 
				detect: [ :eachType | eachType fileName = eachAttachment filename ]
				ifFound: [ :aType | aType url: eachAttachment url ] ]
		 ].
]

{ #category : #accessing }
DSDiscordSharedDataSender >> attachmentTypes [
	^ attachmentTypes
]

{ #category : #'gt-inspector-extension' }
DSDiscordSharedDataSender >> gtInspectorAttachmentTypesIn: composite [
	<gtInspectorPresentationOrder: 2>
	^ composite fastList
			title: [ 'Attachments' translated ];
			display: [ self attachmentTypes ];
			when: [ self attachmentTypes isEmptyOrNil not ];
			yourself
]

{ #category : #'gt-inspector-extension' }
DSDiscordSharedDataSender >> gtInspectorItemsIn: composite [
	<gtInspectorPresentationOrder: 0>
	^ composite fastTree
			title: [ 'Items' translated ];
			display: [ self items collection ];
			when: [ self items isEmptyOrNil not ];
			children: [ :each | each children ];
			expandedUntil: 2;
			yourself
]

{ #category : #'gt-inspector-extension' }
DSDiscordSharedDataSender >> gtInspectorMessagesIn: composite [
	<gtInspectorPresentationOrder: 1>
	^ composite fastList
			title: [ 'Messages' translated ];
			display: [ self messages ];
			when: [ self messages isEmptyOrNil not ];
			yourself
]

{ #category : #initialization }
DSDiscordSharedDataSender >> initialize [
	super initialize.
	attachmentTypes := OrderedCollection new: 2.
	messages := OrderedCollection new: 2.
]

{ #category : #initialization }
DSDiscordSharedDataSender >> initializeMessageBuilder [
	self subclassResponsibility
]

{ #category : #accessing }
DSDiscordSharedDataSender >> messages [
	^ messages
]

{ #category : #actions }
DSDiscordSharedDataSender >> send [
	self initializeMessageBuilder.
	self items do: [ :eachItem | eachItem accept: self ].
	messageBuilder isPostValid ifTrue: [ 
		messages add: messageBuilder send ].
	self associateAttachmentsAndTypes.
	self addShareLinkInformation.
	^ messages.
]

{ #category : #visiting }
DSDiscordSharedDataSender >> visitDSSendCodeSnippetAttachment: aDSSendCodeSnippetAttachment [ 
	aDSSendCodeSnippetAttachment isSelected ifFalse: [ ^ self ].
	messageBuilder fileName: 'code-snippet.st' string: aDSSendCodeSnippetAttachment codeSnippet.
	attachmentTypes add: (DSSharedData newCodeSnippet fileName: 'code-snippet.st'; yourself).
]

{ #category : #visiting }
DSDiscordSharedDataSender >> visitDSSendInformationItem: aDSSendInformationItem [ 
	"ignore"
]

{ #category : #visiting }
DSDiscordSharedDataSender >> visitDSSendPackagesAttachment: aDSSendPackagesAttachment [ 
	| zipFile selectedPackages |
	aDSSendPackagesAttachment isSelected ifFalse: [ ^ self ].
	selectedPackages := aDSSendPackagesAttachment packages
		select: #isSelected thenCollect: #item.
	selectedPackages ifEmpty: [ ^ self ].
	zipFile := DSSerializePackagesWithTonelCommand new
		packages: selectedPackages;
		execute;
		zipFile.
	messageBuilder fileName: 'tonel.zip' fileReference: zipFile.
	attachmentTypes add: (DSSharedData newTonel fileName: 'tonel.zip'; yourself).
]

{ #category : #visiting }
DSDiscordSharedDataSender >> visitDSSendScreenshotsAttachment: aDSSendScreenshotsAttachment [ 
	"ignore"
]

{ #category : #visiting }
DSDiscordSharedDataSender >> visitDSSendUserTextMessageItem: aDSSendUserTextMessageItem [ 
	"ignore"
]
