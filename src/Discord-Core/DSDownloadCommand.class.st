"
I download a content from a given URL.
I let pass any exception raised by ZnClient.

Public API and Key Messages

- url: 		a URL where to download a data from
- contents	a received contents (data)	

Internal Representation and Key Implementation Points.

    Instance Variables
	contents:		<ByteArray>
	url:				<ZnUrl>

"
Class {
	#name : #DSDownloadCommand,
	#superclass : #DSCommand,
	#instVars : [
		'url',
		'contents'
	],
	#category : 'Discord-Core-Commands'
}

{ #category : #accessing }
DSDownloadCommand >> contents [
	^ contents
]

{ #category : #accessing }
DSDownloadCommand >> contents: anObject [
	contents := anObject
]

{ #category : #execute }
DSDownloadCommand >> execute [
	| response |
	response := DSUtility newZnClientWithUserAgent
		url: self url;
		accept: ZnMimeType any;
		get;
		response.
	response isSuccess 
		ifTrue: [ self contents: response contents ]
		ifFalse: [ DSCannotDownloadError new 
			response: response;
			signal: ((response contents) ifNil: [ String streamContents: [ :out | response statusLine writeOn: out ] ]) ]
]

{ #category : #accessing }
DSDownloadCommand >> url [
	^ url
]

{ #category : #accessing }
DSDownloadCommand >> url: anObject [
	url := anObject
]
