Class {
	#name : #DSSendCodeSnippetAttachment,
	#superclass : #DSSendAttachment,
	#instVars : [
		'codeSnippet'
	],
	#category : 'Discord-Send-Items'
}

{ #category : #examples }
DSSendCodeSnippetAttachment class >> loremIpsum [
	<gtExample>
	<label: 'Basic example with Lorem Ipsum content.'>
	^ self new 
		codeSnippet: (String loremIpsum: 200);
		yourself
]

{ #category : #visiting }
DSSendCodeSnippetAttachment >> accept: aVisitor [
	^ aVisitor visitDSSendCodeSnippetAttachment: self
]

{ #category : #accessing }
DSSendCodeSnippetAttachment >> children [
	^ #()
]

{ #category : #accessing }
DSSendCodeSnippetAttachment >> codeSnippet [
	^ codeSnippet
]

{ #category : #accessing }
DSSendCodeSnippetAttachment >> codeSnippet: anObject [
	codeSnippet := anObject
]

{ #category : #'gt-inspector-extension' }
DSSendCodeSnippetAttachment >> gtInspectorCodeSnippetIn: composite [
	<gtInspectorPresentationOrder: 1>
	^ composite text
		title: [ 'Code Snippet' translated ];
		display: [ self codeSnippet ];
		withGhostText: 'Empty code snippet message...';
		yourself
]
