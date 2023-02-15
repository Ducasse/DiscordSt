"
I represent Discord Embed Image object that can be send as JSON to a Discord  API.

See documentation at https://discordapp.com/developers/docs/resources/channel#embed-image-structure

{{{
DSEmbedImage new 
	url: 'http://example.com/icon.png';
	height: 512;
	width: 512;
	yourself
}}}

or as a part of DSEmbed object

{{{
DSEmbed new 
	imageUrl: 'http://example.com/icon.png';
	imageHeight: 512;
	imageWidth: 512;
	yourself
}}}

"
Class {
	#name : #DSEmbedImage,
	#superclass : #DSObject,
	#instVars : [
		'url',
		'proxyUrl',
		'height',
		'width',
		'data'
	],
	#category : 'Discord-Core-Model'
}

{ #category : #examples }
DSEmbedImage class >> screenshot [
	<gtExample>
	^ self new
		proxyUrl: 'https://github.com/JurajKubelka/DiscordSt/raw/master/assets/img/morph-screenshot.png';
		url: 'https://github.com/JurajKubelka/DiscordSt/raw/master/assets/img/morph-screenshot.png';
		height: 299;
		width: 528;
		yourself
]

{ #category : #converting }
DSEmbedImage >> asForm [
	"Download data if necessary and convert to Form object."
	| aStream |
	aStream := self data ifNotNil: #readStream ifNil: [ ^ nil ].
	^ ImageReadWriter formFromStream: aStream 
]

{ #category : #'accessing - convenience' }
DSEmbedImage >> data [
	"Get the downloaded data"
	^ data
		ifNil: [ data := DSDownloadCommand new 
				url: self url;
				execute;
				contents ]
]

{ #category : #'accessing - convenience' }
DSEmbedImage >> extent [
	<return: #Point>
	^ self width @ self height
]

{ #category : #'gt-inspector-extension' }
DSEmbedImage >> gtInspectorActionDownloadData [
	<gtInspectorAction>
	^ GLMGenericAction new
		action: [ :presentation | self data. presentation update ];
		icon: (self iconNamed: #bottom);
		condition: [ self hasData not ];
		title: 'Download data'
]

{ #category : #'gt-inspector-extension' }
DSEmbedImage >> gtInspectorImage: composite [
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

{ #category : #testing }
DSEmbedImage >> hasData [
	"Return true if the data are downloaded."
	^ data notNil
]

{ #category : #testing }
DSEmbedImage >> hasKnownScheme [
	<return: #Boolean>
	^ [ self url asZnUrl enforceKnownScheme. true ]
		on: ZnUnknownScheme do: [ :exception | false ]
]

{ #category : #accessing }
DSEmbedImage >> height [
	^ height
]

{ #category : #accessing }
DSEmbedImage >> height: anObject [
	height := anObject
]

{ #category : #accessing }
DSEmbedImage >> proxyUrl [
	^ proxyUrl
]

{ #category : #accessing }
DSEmbedImage >> proxyUrl: anObject [
	proxyUrl := anObject
]

{ #category : #accessing }
DSEmbedImage >> url [
	^ url
]

{ #category : #accessing }
DSEmbedImage >> url: anObject [
	url := anObject
]

{ #category : #accessing }
DSEmbedImage >> width [
	^ width
]

{ #category : #accessing }
DSEmbedImage >> width: anObject [
	width := anObject
]
