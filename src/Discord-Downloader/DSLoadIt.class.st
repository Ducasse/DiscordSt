Class {
	#name : #DSLoadIt,
	#superclass : #DSCommand,
	#instVars : [
		'data'
	],
	#category : 'Discord-Downloader'
}

{ #category : #protocol }
DSLoadIt class >> data: base64String [
	"Download and materialize data attached to a specific message, identified by idString.
	If base64String is present, then it download the data directly.
	Otherwise it requieres an authenticated Discord client in order to find corresponding messages."
	^ self new
		data: base64String;
		execute

]

{ #category : #accessing }
DSLoadIt >> data [
	^ data
]

{ #category : #accessing }
DSLoadIt >> data: anObject [
	data := anObject
]

{ #category : #'accessing - computed' }
DSLoadIt >> decodedData [
	^ DSPharoLinkV2Converter new
		data: self data;
		decodedData.

]

{ #category : #private }
DSLoadIt >> displayToUser: collectionOfSharedData [
	DSDisplaySharedPlayground new
		sharedData: collectionOfSharedData;
		execute
]

{ #category : #private }
DSLoadIt >> downloadContents: decodedData [ 
	decodedData do: [ :eachData | 
		DSUtility
			displayHTTPProgress: 'Downloading data (' , eachData type asString , ')'
			during: [ | response |
				response := ZnEasy client
					signalProgress: false;
					url: eachData url;
					get;
					response.
				eachData contents: response contents ] ].
]

{ #category : #execute }
DSLoadIt >> execute [
	| decodedData |
	self informAboutStartingLoading.
	decodedData := self decodedData.
	self downloadContents: decodedData.
	self displayToUser: decodedData.
	self informAboutFinishedLoading.
]
