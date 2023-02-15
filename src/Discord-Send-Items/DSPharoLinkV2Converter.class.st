Class {
	#name : #DSPharoLinkV2Converter,
	#superclass : #Object,
	#instVars : [
		'data',
		'url'
	],
	#category : 'Discord-Send-Items'
}

{ #category : #defaults }
DSPharoLinkV2Converter class >> dataLineSeparator [
	"Return a String that separates information in a data field.
	See #encodedData method on the instance side."
	^ String crlf
]

{ #category : #defaults }
DSPharoLinkV2Converter class >> dataQuery [
	^ 'data'
]

{ #category : #defaults }
DSPharoLinkV2Converter class >> defaultUrl [
	"Return a default URL to a server that serve scripts to download data to Pharo."
	^ 'https://pharo-link.herokuapp.com/v2/' asZnUrl
]

{ #category : #defaults }
DSPharoLinkV2Converter class >> typeSeparator [
	"Return a Character that separates information in data.
	See #encodedData method on the instance side."
	^ $+
]

{ #category : #defaults }
DSPharoLinkV2Converter class >> urlPrefix [
	"Return a default Markdown prefix used to construct a HTML link."
	^ '[Load in Pharo]('
]

{ #category : #defaults }
DSPharoLinkV2Converter class >> urlSuffix [
	"Return a default Markdown suffix used to construct a HTML link."
	^ ')'
]

{ #category : #accessing }
DSPharoLinkV2Converter >> data [
	^ data
]

{ #category : #accessing }
DSPharoLinkV2Converter >> data: anObject [
	data := anObject
]

{ #category : #'accessing - computed' }
DSPharoLinkV2Converter >> decodedData [
	<return: #Array of: #DSSharedData>
	| mimeStream gzstream content |
	self assert: [ self data isString ] description: 'Data should include Base64 encoded data'.
	mimeStream := Base64MimeConverter mimeDecodeToChars: self data readStream.
	gzstream := GZipReadStream on: mimeStream.
	content := gzstream upToEnd.
	gzstream close.
	^ (self class dataLineSeparator split: content) 
		collect: [ :eachLine | | index |
			index := eachLine findFirst: [ :eachChar | eachChar = $+ ].
			(DSSharedData ofType: (eachLine first: index - 1))
				url: (eachLine last: eachLine size - index);
				yourself.
		 ] as: Array

]

{ #category : #'accessing - computed' }
DSPharoLinkV2Converter >> encodedData [
	"Return types and URLs enconded in one Base64 string."
	<return: #String>
	| string |
	self assert: [ self data notNil ] description: 'You have to set the collection of shared data'.
	self assert: [ self data isCollection ] description: 'Data should includes an array of DSSharedData objects'.
	string := (String streamContents: [ :aStream | | gzstream |
			gzstream := GZipWriteStream on: aStream.
			self data
				do: [ :eachSharedData | 
					gzstream 
						nextPutAll: eachSharedData type asString;
						nextPut: self class typeSeparator;
						nextPutAll: eachSharedData url asString ]
				separatedBy: [ gzstream nextPutAll: self class dataLineSeparator ].
			gzstream close. ]).
	^ (Base64MimeConverter mimeEncode: string readStream multiLine: false) contents.
]

{ #category : #'accessing - computed' }
DSPharoLinkV2Converter >> encodedUrl [
	"Generate and return a complete URL value, that includes link to download data to Pharo."
	^ self url asZnUrl 
		? (self class dataQuery -> self encodedData)
]

{ #category : #initialization }
DSPharoLinkV2Converter >> initialize [
	super initialize.
	url := self class defaultUrl.
]

{ #category : #'accessing - computed' }
DSPharoLinkV2Converter >> markdown [
	"Generate and return a complete Markdown URL, that includes link to download data to Pharo."
	^ self class urlPrefix, self encodedUrl asString, self class urlSuffix 
]

{ #category : #accessing }
DSPharoLinkV2Converter >> url [
	^ url ifNil: [ url := self class defaultUrl ]
]
