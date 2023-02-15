"
I am responsible for collecting anonymouse information for a research purpose.
I will be removed, once Juraj Kubelka's PhD is finished.
Using the tool helps me to finish Juraj's PhD and improve the user communication experience.
Thank you for using it :-)
ALL DATA ARE ANONYMOUS

"
Class {
	#name : #DSAnonymousSenderCollector,
	#superclass : #Object,
	#instVars : [
		'items',
		'output',
		'stream',
		'indent'
	],
	#category : 'Discord-Research'
}

{ #category : #actions }
DSAnonymousSenderCollector >> collect [
	output := String streamContents: [ :aStream | 
		stream := aStream.
		indent := 0.
		self items do: [ :eachItem | eachItem accept: self ] ]
]

{ #category : #private }
DSAnonymousSenderCollector >> decreaseIndent [
	indent := indent - 2
]

{ #category : #private }
DSAnonymousSenderCollector >> increaseIndent [
	indent := indent + 2
]

{ #category : #accessing }
DSAnonymousSenderCollector >> indentString [
	^ String new: indent withAll: Character space
]

{ #category : #accessing }
DSAnonymousSenderCollector >> items [
	^ items
]

{ #category : #accessing }
DSAnonymousSenderCollector >> items: anObject [
	items := anObject
]

{ #category : #accessing }
DSAnonymousSenderCollector >> output [
	^ output
]

{ #category : #visiting }
DSAnonymousSenderCollector >> visitDSAnimatedGifScreenshot: aDSAnimatedGifScreenshot [ 
	stream 
		nextPutAll: self indentString;
		nextPutAll: 'one animated GIF screenshot of size:';
		nextPutAll: (aDSAnimatedGifScreenshot bytes 
			ifNil: [ '0' ] ifNotNil: [ :aBytes | aBytes size asString ]);
		nextPutAll: ', selected: ';
		nextPutAll: aDSAnimatedGifScreenshot isSelected asString;
		nextPutAll: ', enabled: ';
		nextPutAll: aDSAnimatedGifScreenshot isEnabled asString;
		cr
]

{ #category : #visiting }
DSAnonymousSenderCollector >> visitDSMorphScreenshot: aDSMorphScreenshot [ 
	stream 
		nextPutAll: self indentString;
		nextPutAll: 'one morph screenshot, selected: ';
		nextPutAll: aDSMorphScreenshot isSelected asString;
		nextPutAll: ', enabled: ';
		nextPutAll: aDSMorphScreenshot isEnabled asString;
		cr
]

{ #category : #visiting }
DSAnonymousSenderCollector >> visitDSPackageSelection: aDSPackageSelection [ 
	stream 
		nextPutAll: self indentString;
		nextPutAll: 'package selected: ';
		nextPutAll: aDSPackageSelection isSelected asString;
		nextPutAll: ', enabled: ';
		nextPutAll: aDSPackageSelection isEnabled asString;
		cr.
]

{ #category : #visiting }
DSAnonymousSenderCollector >> visitDSSendAttachmentsItem: aDSSendAttachmentsItem [ 
	stream
		nextPutAll: self indentString;
		nextPutAll: 'attachments selected: ';
		nextPutAll: aDSSendAttachmentsItem isSelected asString;
		nextPutAll: ', enabled: ';
		nextPutAll: aDSSendAttachmentsItem isEnabled asString;
		cr.
	self increaseIndent.
	aDSSendAttachmentsItem attachments do: [ :eachAttachment |
		eachAttachment accept: self ].
	self decreaseIndent.
]

{ #category : #visiting }
DSAnonymousSenderCollector >> visitDSSendCodeSnippetAttachment: aDSSendCodeSnippetAttachment [ 
	stream 
		nextPutAll: self indentString;
		nextPutAll: 'code snippet selected: ';
		nextPutAll: aDSSendCodeSnippetAttachment isSelected asString;
		nextPutAll: ', enabled: ';
		nextPutAll: aDSSendCodeSnippetAttachment isEnabled asString;
		cr.
]

{ #category : #visiting }
DSAnonymousSenderCollector >> visitDSSendInformationItem: aDSSendInformationItem [ 
	stream 
		nextPutAll: self indentString;
		nextPutAll: 'information selected: ';
		nextPutAll: aDSSendInformationItem isSelected asString;
		nextPutAll: ', enabled: ';
		nextPutAll: aDSSendInformationItem isEnabled asString;
		cr.
	self increaseIndent.
	aDSSendInformationItem infos do: [ :eachInfo | | printedInfo |
		printedInfo := ((eachInfo name = 'Pharo') or: [ eachInfo name = 'OS' ])
			ifTrue: [ eachInfo printString ]
			ifFalse: [ 'Info: ', eachInfo name asString, ' value: ', eachInfo value hash asString ].
		stream 
			nextPutAll: self indentString;
			nextPutAll: printedInfo;
			nextPutAll: ', selected: ';
			nextPutAll: eachInfo isSelected asString;
			nextPutAll: ', enabled: ';
			nextPutAll: eachInfo isEnabled asString;
			cr ].
	self decreaseIndent.
]

{ #category : #visiting }
DSAnonymousSenderCollector >> visitDSSendPackagesAttachment: aDSSendPackagesAttachment [ 
	stream 
		nextPutAll: self indentString;
		nextPutAll: 'packages size: ';
		nextPutAll: aDSSendPackagesAttachment packages size asString;
		nextPutAll: ', selected: ';
		nextPutAll: aDSSendPackagesAttachment isSelected asString;
		nextPutAll: ', enabled: ';
		nextPutAll: aDSSendPackagesAttachment isEnabled asString;
		cr.
	self increaseIndent.
	aDSSendPackagesAttachment packages do: [ :eachPackage | 
		eachPackage accept: self ].
	self decreaseIndent.
]

{ #category : #visiting }
DSAnonymousSenderCollector >> visitDSSendRegistriesItem: aDSSendRegistriesItem [ 
	stream
		nextPutAll: self indentString;
		nextPutAll: 'number of registries: ';
		nextPutAll: aDSSendRegistriesItem registries size asString;
		cr.
	self increaseIndent.
	stream
		nextPutAll: self indentString;
		nextPutAll: 'selected registry: ';
		nextPutAll: aDSSendRegistriesItem selectedRegistry className;
		nextPutAll: ', instance hash: ';
		nextPutAll: aDSSendRegistriesItem selectedRegistry identityHash asString;
		cr.
	(aDSSendRegistriesItem selectedRegistry class = DSSingletonClientRegistry) 
		ifTrue: [  
			stream
				nextPutAll: self indentString;
				nextPutAll: 'selected channel type: ';
				nextPutAll: aDSSendRegistriesItem selectedRegistry selectedChannel className;
				cr;
				nextPutAll: self indentString;
				nextPutAll: 'user hash: ';
				nextPutAll: aDSSendRegistriesItem selectedRegistry client me id hash asString;
				cr ].
	self decreaseIndent.
]

{ #category : #visiting }
DSAnonymousSenderCollector >> visitDSSendScreenshotsAttachment: aDSSendScreenshotsAttachment [ 
	stream
		nextPutAll: self indentString;
		nextPutAll: 'number of screenshots: ';
		nextPutAll: aDSSendScreenshotsAttachment screenshots size asString;
		nextPutAll: ', is selected: ';
		nextPutAll: aDSSendScreenshotsAttachment isSelected asString;
		nextPutAll: ', enabled: ';
		nextPutAll: aDSSendScreenshotsAttachment isEnabled asString;
		cr.
	self increaseIndent.
	aDSSendScreenshotsAttachment screenshots do: [ :eachScreenshot | 
		eachScreenshot accept: self ].
	self decreaseIndent.
]

{ #category : #visiting }
DSAnonymousSenderCollector >> visitDSSendUserTextMessageItem: aDSSendUserTextMessageItem [ 
	stream 
		nextPutAll: self indentString;
		nextPutAll: 'user message size: ';
		nextPutAll: aDSSendUserTextMessageItem text size asString;
		cr.
	self increaseIndent.
	stream
		nextPutAll: self indentString;
		nextPutAll: 'user message includes code snippet: ';
		nextPutAll: (aDSSendUserTextMessageItem text includesSubstring: '```') asString;
		cr;
		nextPutAll: self indentString;
		nextPutAll: 'user message mentions a code: ';
		nextPutAll: (aDSSendUserTextMessageItem text includesSubstring: '`') asString;
		cr.
	self decreaseIndent.
]
