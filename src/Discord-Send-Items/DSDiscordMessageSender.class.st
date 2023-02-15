Class {
	#name : #DSDiscordMessageSender,
	#superclass : #DSMessageSender,
	#instVars : [
		'messageBuilder',
		'sharedData'
	],
	#category : 'Discord-Send-Items'
}

{ #category : #'instance creation' }
DSDiscordMessageSender >> newDiscordSharedDataSender [
	<return: #DSDiscordSharedDataSender>
	^ self subclassResponsibility 
]

{ #category : #actions }
DSDiscordMessageSender >> send [
	"Build a messages based on items and send it using registry."
	self informAboutStartSending.
	self sendSharedData.
	self sendMainMessage.
	self informAboutEndSending.
]

{ #category : #private }
DSDiscordMessageSender >> sendMainMessage [
	"Send the main user message."
	^ self subclassResponsibility
]

{ #category : #private }
DSDiscordMessageSender >> sendSharedData [
	"Send shared data, separated from an user (main) message."
	sharedData := self newDiscordSharedDataSender 
		items: self items;
		registry: self registry;
		send;
		yourself.

]

{ #category : #visiting }
DSDiscordMessageSender >> visitDSAnimatedGifScreenshot: aDSAnimatedGifScreenshot [ 
	aDSAnimatedGifScreenshot isSelected ifFalse: [ ^ self ].
	aDSAnimatedGifScreenshot bytes ifNil: [ ^ self ].
	messageBuilder attachGifBytes: aDSAnimatedGifScreenshot bytes
]

{ #category : #visiting }
DSDiscordMessageSender >> visitDSMorphScreenshot: aDSMorphScreenshot [ 
	| form |
	aDSMorphScreenshot isSelected ifFalse: [ ^ self ].
	form := aDSMorphScreenshot form.
	form extent isZero ifFalse: [
		messageBuilder attachForm: form ].
]

{ #category : #visiting }
DSDiscordMessageSender >> visitDSSendCodeSnippetAttachment: aDSSendCodeSnippetAttachment [ 
	"ignore"
]

{ #category : #visiting }
DSDiscordMessageSender >> visitDSSendInformationItem: aDSSendInformationItem [ 
	aDSSendInformationItem infos do: [ :eachInfo | 
		messageBuilder embedInlineFieldName: eachInfo name value: eachInfo value ].
]

{ #category : #visiting }
DSDiscordMessageSender >> visitDSSendPackagesAttachment: aDSSendPackagesAttachment [ 
	"ignore"
]

{ #category : #visiting }
DSDiscordMessageSender >> visitDSSendScreenshotsAttachment: aDSSendScreenshotsAttachment [ 
	aDSSendScreenshotsAttachment isSelected ifFalse: [ ^ self ].
	aDSSendScreenshotsAttachment hasSelectedForms ifFalse: [ ^ self ].
	aDSSendScreenshotsAttachment screenshots do: [ :eachScreenshot | 
		eachScreenshot accept: self ].
]

{ #category : #visiting }
DSDiscordMessageSender >> visitDSSendUserTextMessageItem: aDSSendUserTextMessageItem [ 
	messageBuilder content: aDSSendUserTextMessageItem text
]
