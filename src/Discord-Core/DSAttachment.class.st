"
I represent a Discord Attachment Object.
Attachment is a part of a message (DSMessage).

See https://discordapp.com/developers/docs/resources/channel#attachment-object
"
Class {
	#name : 'DSAttachment',
	#superclass : 'DSObject',
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
	#category : 'Discord-Core-Model',
	#package : 'Discord-Core',
	#tag : 'Model'
}

{ #category : 'converting' }
DSAttachment >> asForm [
	"Download data if necessary and convert to Form object."
	| aStream |
	aStream := self data ifNotNil: #readStream ifNil: [ ^ Form extent: 50 @ 50 ].
	^ ImageReadWriter formFromStream: aStream 
]

{ #category : 'public' }
DSAttachment >> data [
	"Get the downloaded data"
	^ data
		ifNil: [ data := DSDownloadCommand new 
				url: self url;
				execute;
				contents ]
]

{ #category : 'accessing' }
DSAttachment >> data: anObject [
	data := anObject
]

{ #category : 'accessing' }
DSAttachment >> fileSize [
	^ fileSize
]

{ #category : 'accessing' }
DSAttachment >> fileSize: anObject [
	fileSize := anObject
]

{ #category : 'accessing' }
DSAttachment >> filename [
	^ filename
]

{ #category : 'accessing' }
DSAttachment >> filename: anObject [
	filename := anObject
]

{ #category : 'testing' }
DSAttachment >> hasData [
	"Return true if the data are downloaded."
	^ data notNil
]

{ #category : 'accessing' }
DSAttachment >> height [
	^ height
]

{ #category : 'accessing' }
DSAttachment >> height: anObject [
	height := anObject
]

{ #category : 'accessing' }
DSAttachment >> id [
	^ id
]

{ #category : 'accessing' }
DSAttachment >> id: anObject [
	id := anObject
]

{ #category : 'testing' }
DSAttachment >> isAttachment [
	^ true
]

{ #category : 'testing' }
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

{ #category : 'testing' }
DSAttachment >> isImage [
	"If width and height are defined, it is an image."
	^ self width notNil and: [ self height notNil ]
]

{ #category : 'testing' }
DSAttachment >> isZipArchive [
	"Return true if the data are downloaded and is a ZIP archive."
	^ self hasData and: [ ZipArchive isZipArchive: self data readStream ]
]

{ #category : 'public' }
DSAttachment >> materialize [
	"Materialize the attachment data. 
	It is supposed that #data return a ByteArray object."
	^ DSUtility materializeFromByteArray: self data
]

{ #category : 'printing' }
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

{ #category : 'accessing' }
DSAttachment >> proxyUrl [
	^ proxyUrl
]

{ #category : 'accessing' }
DSAttachment >> proxyUrl: anObject [
	proxyUrl := anObject
]

{ #category : 'accessing' }
DSAttachment >> url [
	^ url
]

{ #category : 'accessing' }
DSAttachment >> url: anObject [
	url := anObject
]

{ #category : 'accessing' }
DSAttachment >> width [
	^ width
]

{ #category : 'accessing' }
DSAttachment >> width: anObject [
	width := anObject
]
