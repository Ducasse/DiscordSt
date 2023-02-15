"
A DSMarkdownBuilderTest is a test class for testing the behavior of DSMarkdownBuilder
"
Class {
	#name : #DSMarkdownBuilderTest,
	#superclass : #TestCase,
	#instVars : [
		'builder'
	],
	#category : 'Discord-Core-Tests-Utility'
}

{ #category : #running }
DSMarkdownBuilderTest >> classToTest [
	^ DSMarkdownBuilder
]

{ #category : #tests }
DSMarkdownBuilderTest >> testAsString [
	| result |
	builder := self classToTest new.
	builder text: 'a text'.
	result := builder asString.
	self assert: result equals: 'a text'.
]

{ #category : #tests }
DSMarkdownBuilderTest >> testBold [
	| result |
	builder := self classToTest new.
	builder bold: 'bold'.
	result := builder build.
	self assert: result equals: '**bold**'.
]

{ #category : #tests }
DSMarkdownBuilderTest >> testBoldItalic [
	| result |
	builder := self classToTest new.
	builder boldItalic: 'bold and italic'.
	result := builder build.
	self assert: result equals: '**_bold and italic_**'.
]

{ #category : #tests }
DSMarkdownBuilderTest >> testBuild [
	| result |
	builder := self classToTest new.
	result := builder build.
	self assert: result equals: ''.
]

{ #category : #tests }
DSMarkdownBuilderTest >> testBuildTwice [
	| result |
	builder := self classToTest new.
	builder text: 'a text'.
	result := builder build.
	result := builder build.
	self assert: result equals: ''.
]

{ #category : #tests }
DSMarkdownBuilderTest >> testCr [
	| result |
	builder := self classToTest new.
	builder cr.
	result := builder build.
	self assert: result equals: String cr.
]

{ #category : #tests }
DSMarkdownBuilderTest >> testInlineScript [
	| result |
	builder := self classToTest new.
	builder inlineScript: 'Behavior new'.
	result := builder build.
	self assert: result equals: '`Behavior new`'.
]

{ #category : #tests }
DSMarkdownBuilderTest >> testItalic [
	| result |
	builder := self classToTest new.
	builder italic: 'italic'.
	result := builder build.
	self assert: result equals: '*italic*'.
]

{ #category : #tests }
DSMarkdownBuilderTest >> testLinkUrl [
	| result |
	builder := self classToTest new.
	builder link: 'Pharo' url: 'http://pharo.org'.
	result := builder build.
	self assert: result equals: '[Pharo](http://pharo.org)'.
]

{ #category : #tests }
DSMarkdownBuilderTest >> testPharoScript [
	| result |
	builder := self classToTest new.
	builder pharoScript: 'Smalltalk os version.'.
	result := builder build.
	self 
		assert: result 
		equals: (String cr join: #( '```Smalltalk' 'Smalltalk os version.' '```' '')).
]

{ #category : #tests }
DSMarkdownBuilderTest >> testScriptLanguage [
	| result |
	builder := self classToTest new.
	builder script: 'document open;' language: 'JavaScript'.
	result := builder build.
	self 
		assert: result 
		equals: (String cr join: #( '```JavaScript' 'document open;' '```' '')).
]

{ #category : #tests }
DSMarkdownBuilderTest >> testSpace [
	| result |
	builder := self classToTest new.
	builder space.
	result := builder build.
	self assert: result equals: String space.
]

{ #category : #tests }
DSMarkdownBuilderTest >> testStrikethrough [
	| result |
	builder := self classToTest new.
	builder strikeThrough: 'strikethrough'.
	result := builder build.
	self assert: result equals: '~~strikethrough~~'.
]

{ #category : #tests }
DSMarkdownBuilderTest >> testText [
	| result |
	builder := self classToTest new.
	builder text: 'a text'.
	result := builder build.
	self assert: result equals: 'a text'.
]
