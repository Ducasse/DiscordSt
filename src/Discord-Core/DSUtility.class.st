"
I keep a useful methods that can be used by different objects (classes).
"
Class {
	#name : 'DSUtility',
	#superclass : 'Object',
	#category : 'Discord-Core-Utility',
	#package : 'Discord-Core',
	#tag : 'Utility'
}

{ #category : 'ui - http progress' }
DSUtility class >> displayHTTPProgress: labelString during: aBlock [
	"Display a progress bar with a label while executing a block.
	It returns a result of the block."
	| result |
	UIManager default
		informUserDuring: [ :bar | 
			bar label: labelString asString.
			[ result := aBlock value ]
				on: HTTPProgress
				do: [ :progress | 
					progress isEmpty
						ifFalse: [ bar current: progress percentage.
							progress total
								ifNotNil: [ :aTotalNumber | 
									| humanReadable |
									humanReadable := self printHumanReadableBytes: aTotalNumber.
									bar label: labelString asString , ' (' , humanReadable , ')' ] ].
					progress resume ] ].
	^ result
]

{ #category : 'markdown' }
DSUtility class >> markdownOf: aString [
	"Return Markdown representation of a string."
	<return: #String>
	^ String streamContents: [ :aStream | 
			aStream 
				nextPutAll: '```'; cr; 
				nextPutAll: aString trimBoth; cr;
				nextPutAll: '```'; cr ].
]

{ #category : 'fuel' }
DSUtility class >> materializeFromByteArray: byteArray [
	"Materialize objects using Fuel."
	^(FLMaterializer newDefault 
		showProgress;
		materializeFrom: byteArray readStream) root
]

{ #category : 'instance creation' }
DSUtility class >> newZnClient [
	^ ZnClient new
]

{ #category : 'instance creation' }
DSUtility class >> newZnClientWithUserAgent [
	"Return new object with correct User Agent.
	See https://discordapp.com/developers/docs/reference#user-agent"
	^ self newZnClient
		headerAt: 'User-Agent' put: DSConstants userAgent;
		yourself
]

{ #category : 'printing' }
DSUtility class >> printHumanReadableBytes: aTotalNumber [
	"Print in a readable form size, e.g., 1KB, 12MB, etc."
	^ String streamContents: [ :aStream |
		self printHumanReadableBytes: aTotalNumber on: aStream ]
]

{ #category : 'printing' }
DSUtility class >> printHumanReadableBytes: aTotalNumber on: aStream [ 
	"Print in a readable form size, e.g., 1KB, 12MB, etc."
	aTotalNumber < 1024 ifTrue: [ 
		aTotalNumber printOn: aStream.
		^ aStream << ' bytes' ].
	aTotalNumber < 1048576 ifTrue: [ 
		(aTotalNumber / 1024) rounded printOn: aStream.
		^ aStream << ' KB' ].
	aTotalNumber <  1073741824 ifTrue: [ 
		(aTotalNumber / 1048576) rounded printOn:aStream.
		^ aStream << ' MB' ].
	aTotalNumber < 1099511627776 ifTrue: [
		(aTotalNumber / 1073741824) rounded printOn: aStream.
		^ aStream << ' GB' ].
	(aTotalNumber / 1099511627776) rounded printOn: aStream.
	aStream << ' TB'
]

{ #category : 'fuel' }
DSUtility class >> safeFileName: anObject [
	"Return a safe string representation that can be used as a basename for a filename.
	It returns a basename without an extension, e.g., .png."

	^ String
		streamContents: [ :aStream | 
			| previousCharacter aString |
			previousCharacter := nil.
			aString := anObject
				printStringLimitedTo: DSConstants maxFileNameLenght + 9 "take into the account ...etc... tail".
			aString := aString first: (aString size min: DSConstants maxFileNameLenght). "and remove the ...etc... tail"
			aString := aString trimBoth: [ :char | char isAlphaNumeric not ].
			aString
				do: [ :char | 
					| nextCharacter |
					nextCharacter := char isSafeForHTTP
						ifTrue: [ char ]
						ifFalse: [ $- ].
					nextCharacter = $.
						ifTrue: [ nextCharacter := $- ].
					previousCharacter = nextCharacter
						ifFalse: [ aStream nextPut: nextCharacter ]
						ifTrue: [ nextCharacter isAlphaNumeric
								ifTrue: [ aStream nextPut: nextCharacter ] ].
					previousCharacter := nextCharacter ] ]
]

{ #category : 'fuel' }
DSUtility class >> serializeToByteArray: anObject [
	"Serialize an object as a byte array using FUEL.
	It returns bytes representing the serialized object."
	| stream serializer |
	stream := ByteArray new writeStream.
	serializer := FLSerializer newDefault.		
	serializer
		showProgress;
		serialize: anObject
		on: stream.
	^ stream contents.
]

{ #category : 'markdown' }
DSUtility class >> smalltalkInlinedMarkdownOf: aString [
	"Return inlined Markdown representation of a string. 
	The string is supposed to be a one-line Smalltalk code snippet."
	<return: #String>
	^ String streamContents: [ :aStream | 
			aStream 
				nextPutAll: '`'; 
				nextPutAll: aString trimBoth;
				nextPutAll: '`' ].
]

{ #category : 'markdown' }
DSUtility class >> smalltalkMarkdownOf: aString [
	"Return Markdown representation of a string. 
	The string is supposed to be a Smalltalk code snippet."
	<return: #String>
	^ String streamContents: [ :aStream | 
			aStream 
				nextPutAll: '```Smalltalk'; cr; 
				nextPutAll: aString trimBoth; cr;
				nextPutAll: '```'; cr ].
]
