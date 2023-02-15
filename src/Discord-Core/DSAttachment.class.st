"
I represent a Discord Attachment Object.
Attachment is a part of a message (DSMessage).

See https://discordapp.com/developers/docs/resources/channel#attachment-object
"
Class {
	#name : #DSAttachment,
	#superclass : #DSObject,
	#instVars : [
		'id',
		'filename',
		'fileSize',
		'url',
		'height',
		'width',
		'data',
		'proxyUrl'
	],
	#category : 'Discord-Core-Model'
}

{ #category : #converting }
DSAttachment >> asForm [
	"Download data if necessary and convert to Form object."
	| aStream |
	aStream := self data ifNotNil: #readStream ifNil: [ ^ Form extent: 50 @ 50 ].
	^ ImageReadWriter formFromStream: aStream 
]

{ #category : #public }
DSAttachment >> data [
	"Get the downloaded data"
	^ data
		ifNil: [ data := DSDownloadCommand new 
				url: self url;
				execute;
				contents ]
]

{ #category : #accessing }
DSAttachment >> data: anObject [
	data := anObject
]

{ #category : #accessing }
DSAttachment >> fileSize [
	^ fileSize
]

{ #category : #accessing }
DSAttachment >> fileSize: anObject [
	fileSize := anObject
]

{ #category : #accessing }
DSAttachment >> filename [
	^ filename
]

{ #category : #accessing }
DSAttachment >> filename: anObject [
	filename := anObject
]

{ #category : #'gt-inspector-extension' }
DSAttachment >> gtInspectorActionDownloadData [
	<gtInspectorAction>
	^ GLMGenericAction new
		action: [ :presentation | self data. presentation update ];
		icon: (self iconNamed: #bottom);
		condition: [ self hasData not ];
		title: 'Download data'
]

{ #category : #'gt-inspector-extension' }
DSAttachment >> gtInspectorActionMaterializeData [
	<gtInspectorAction>
	^ GLMGenericAction new
		action: [ :presentation | | result |
				result := self materialize.
				presentation update; selection: result ];
		icon: (self iconNamed: #glamorousAdd);
		condition: [ self isImage not ];
		title: 'Materialize'
]

{ #category : #'gt-inspector-extension' }
DSAttachment >> gtInspectorImage: composite [
	<gtInspectorPresentationOrder: 2>
	^ composite morph
		title: 'Image';
		display: [ | aStream |
				aStream := self data readStream.
				ImageReadWriter formFromStream: aStream ];
		when: [ self hasData and: [ 
					[ ImageReadWriter formFromStream: self data readStream.
					true ]
					on: Error do: [ :exception | exception return: false ] ] ];
		yourself			
]

{ #category : #'gt-inspector-extension' }
DSAttachment >> gtInspectorString: composite [
	<gtInspectorPresentationOrder: 2>
	^ composite text 
		title: 'String';
		display: [ self data truncateWithElipsisTo: 100000 ];
		when: [ self hasData and: [ self data isString ] ];
		yourself			
]

{ #category : #'gt-inspector-extension' }
DSAttachment >> gtInspectorZipItemsIn: composite [
	<gtInspectorPresentationOrder: 3>
	^ composite fastList
		title: 'ZIP';
		display: [ ZipArchive new 
						readFrom: self data readStream;
						members ];
		when: [ self isZipArchive ];
		format: [ :zipFileMember | zipFileMember fileName ];
		selectionPopulate: #selection 
			entitled: 'Inspect the ZIP member'
			with: [ :list | list rawSelection gtInspectorInterestingObject ];
		send: [ :zipFileMemberOrNil | 
			zipFileMemberOrNil ifNotNil: [ :member | member contents ] ]
]

{ #category : #testing }
DSAttachment >> hasData [
	"Return true if the data are downloaded."
	^ data notNil
]

{ #category : #accessing }
DSAttachment >> height [
	^ height
]

{ #category : #accessing }
DSAttachment >> height: anObject [
	height := anObject
]

{ #category : #accessing }
DSAttachment >> id [
	^ id
]

{ #category : #accessing }
DSAttachment >> id: anObject [
	id := anObject
]

{ #category : #testing }
DSAttachment >> isAttachment [
	^ true
]

{ #category : #testing }
DSAttachment >> isFuel [
	"Answer true, if the attachment includes FUEL data.
	We recognize it by checking the url extension."
	^ self url 
		ifNotNil: [ :string | 
			string asZnUrl lastPathSegment
				ifNotNil: [ :segment | segment asLowercase endsWith: '.fuel' ]
				ifNil: false ]
		ifNil: false
]

{ #category : #testing }
DSAttachment >> isImage [
	"If width and height are defined, it is an image."
	^ self width notNil and: [ self height notNil ]
]

{ #category : #testing }
DSAttachment >> isZipArchive [
	"Return true if the data are downloaded and is a ZIP archive."
	^ self hasData and: [ ZipArchive isZipArchive: self data readStream ]
]

{ #category : #public }
DSAttachment >> materialize [
	"Materialize the attachment data. 
	It is supposed that #data return a ByteArray object."
	^ DSUtility materializeFromByteArray: self data
]

{ #category : #printing }
DSAttachment >> printOn: aStream [
	aStream << 'Attachment'.
	self isImage ifTrue: [ aStream << ' (image)' ].
	self hasData ifTrue: [ aStream << ' (downloaded)' ].
	self fileSize ifNotNil: [ :integer | 
		aStream << '('.
		DSUtility printHumanReadableBytes: integer on: aStream.
		aStream << ')' ].
	aStream << ': '.
	self filename ifNotNil: [ :string | aStream << string ].
]

{ #category : #accessing }
DSAttachment >> proxyUrl [
	^ proxyUrl
]

{ #category : #accessing }
DSAttachment >> proxyUrl: anObject [
	proxyUrl := anObject
]

{ #category : #accessing }
DSAttachment >> url [
	^ url
]

{ #category : #accessing }
DSAttachment >> url: anObject [
	url := anObject
]

{ #category : #accessing }
DSAttachment >> width [
	^ width
]

{ #category : #accessing }
DSAttachment >> width: anObject [
	width := anObject
]
