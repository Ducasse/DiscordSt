"
I am a minimal Markdown builder.
I am useful for writing description that includes URL links, Smalltalk code, etc.
I can be used several times if necessary as the private stream is initialized on every build.
I am used by DSClientPostBuilder.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	stream:		<WriteStream>

"
Class {
	#name : #DSMarkdownBuilder,
	#superclass : #Object,
	#instVars : [
		'stream'
	],
	#category : 'Discord-Core-Utility'
}

{ #category : #converting }
DSMarkdownBuilder >> asString [
	^ self build
]

{ #category : #accessing }
DSMarkdownBuilder >> bold: aString [ 
	"Add a bold script"
	stream 
		nextPutAll: '**';
		nextPutAll: aString asString;
		nextPutAll: '**'
]

{ #category : #accessing }
DSMarkdownBuilder >> boldItalic: aString [ 
	"Add a bold script"
	stream 
		nextPutAll: '**_';
		nextPutAll: aString asString;
		nextPutAll: '_**'
]

{ #category : #building }
DSMarkdownBuilder >> build [
	"Close the stream and return contents"
	<return: #String>
	| contents |
	contents := stream close; contents.
	self initializeStream.
	^ contents
]

{ #category : #accessing }
DSMarkdownBuilder >> cr [
	"Add a carriage return"
	stream nextPut: Character cr
]

{ #category : #initialization }
DSMarkdownBuilder >> initialize [
	super initialize.
	self initializeStream.
]

{ #category : #initialization }
DSMarkdownBuilder >> initializeStream [
	stream := WriteStream on: String new.
]

{ #category : #accessing }
DSMarkdownBuilder >> inlineScript: aString [ 
	"Add a inlined script"
	stream 
		nextPut: $`;
		nextPutAll: aString asString;
		nextPut: $`
]

{ #category : #accessing }
DSMarkdownBuilder >> italic: aString [ 
	"Add a italic script"
	stream 
		nextPut: $*;
		nextPutAll: aString asString;
		nextPut: $*
]

{ #category : #accessing }
DSMarkdownBuilder >> link: linkName url: linkUrl [
	"Add a URL link"
	stream 
		nextPut: $[;
		nextPutAll: linkName asString;
		nextPutAll: '](';
		nextPutAll: linkUrl asString;
		nextPut: $)
]

{ #category : #accessing }
DSMarkdownBuilder >> pharoScript: scriptString [
	"Add a Smalltalk script"
	self script: scriptString language: 'Smalltalk'
]

{ #category : #accessing }
DSMarkdownBuilder >> script: scriptString language: typeString [
	"Add a script of a given language"
	stream 
		nextPutAll: '```';
		nextPutAll: typeString asString;
		cr;
		nextPutAll: scriptString asString;
		cr;
		nextPutAll: '```';
		cr

]

{ #category : #accessing }
DSMarkdownBuilder >> space [
	"Add a space"
	stream nextPut: Character space
]

{ #category : #accessing }
DSMarkdownBuilder >> strikeThrough: aString [ 
	"Add a bold script"
	stream 
		nextPutAll: '~~';
		nextPutAll: aString asString;
		nextPutAll: '~~'
]

{ #category : #accessing }
DSMarkdownBuilder >> text: aString [ 
	"Add a text"
	stream nextPutAll: aString asString
]
