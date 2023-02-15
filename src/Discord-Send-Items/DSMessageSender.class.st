Class {
	#name : #DSMessageSender,
	#superclass : #Object,
	#instVars : [
		'items',
		'registry'
	],
	#category : 'Discord-Send-Items'
}

{ #category : #accessing }
DSMessageSender >> items [
	^ items
]

{ #category : #accessing }
DSMessageSender >> items: anObject [
	items := anObject
]

{ #category : #accessing }
DSMessageSender >> registry [
	^ registry
]

{ #category : #accessing }
DSMessageSender >> registry: anObject [
	registry := anObject
]

{ #category : #actions }
DSMessageSender >> send [
	"Build a messages based on items and send it using registry."
	^ self subclassResponsibility 
]

{ #category : #visiting }
DSMessageSender >> visitDSSendAttachmentsItem: aDSSendAttachmentsItem [ 
	aDSSendAttachmentsItem isSelected ifFalse: [ ^ self ].
	aDSSendAttachmentsItem attachments do: [ :eachAttachment | 
		eachAttachment accept: self ]
]

{ #category : #visiting }
DSMessageSender >> visitDSSendRegistriesItem: aDSSendRegistriesItem [ 
	"ignore"
]
