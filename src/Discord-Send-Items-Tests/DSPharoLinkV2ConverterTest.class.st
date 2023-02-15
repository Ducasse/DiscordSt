"
A DSPharoLinkV2GeneratorTest is a test class for testing the behavior of DSPharoLinkV2Generator
"
Class {
	#name : #DSPharoLinkV2ConverterTest,
	#superclass : #TestCase,
	#instVars : [
		'builder'
	],
	#category : 'Discord-Send-Items-Tests'
}

{ #category : #running }
DSPharoLinkV2ConverterTest >> classToTest [
	^ DSPharoLinkV2Converter
]

{ #category : #'tests-accessing' }
DSPharoLinkV2ConverterTest >> encodedDataString [
	"Return encoded data that are composed of three URLs. Each one per line separated by String crlf."
	^ 'H4sIAAAAAAAAANWObQrCMAyG/wseZWvztklbT+ENwtiUCe4DV+9vnEcQBAPhCW8SeMZa1+3kXD/M7XDb+uUxdOva9svkulq7fpwuc91cQBEfIZSIAsUSeY/Ik085IAmCZHfuHrWhJih8VjArsVcCq0SFclADglIyRtGUNBdFVhJYaESxVso2sm32byUlo92TTWivz8v9ePjam0oWATzH+PHGf3hDCvvo3/XxDj/wfgEOm3evJgIAAA=='
]

{ #category : #'tests-accessing' }
DSPharoLinkV2ConverterTest >> testDecodedData [
	| data result |
	data := 'H4sIAAAAAAAAACvJz0vN0c4oKSkottLXT61IzC3ISdVLzs/VB8voVWUW8HIl56ekBudlFhSklmBVCpLXLYYo0CsuAQCrPc3fVAAAAA=='.
	builder := self classToTest new.
	builder data: data.
	result := builder decodedData.
	self assert: result isCollection.
	self assert: result size equals: 2.
	self assert: result first type equals: DSSharedData newTonel type.
	self assert: result first url equals: 'https://example.com/tonel.zip'.
	self assert: result second type equals: DSSharedData newCodeSnippet type.
	self assert: result second url equals: 'https://example.com/code-snippet.st'.
]

{ #category : #'tests-accessing' }
DSPharoLinkV2ConverterTest >> testEncodedData [
	| data result |
	data := Array 
		with: (DSSharedData newTonel url: 'https://example.com/tonel.zip'; yourself)
		with: (DSSharedData newCodeSnippet url: 'https://example.com/code-snippet.st'; yourself).
	builder := self classToTest new.
	builder data: data.
	result := builder encodedData.
	self 
		assert: result 
		equals: 'H4sIAAAAAAAAACvJz0vN0c4oKSkottLXT61IzC3ISdVLzs/VB8voVWUW8HIl56ekBudlFhSklmBVCpLXLYYo0CsuAQCrPc3fVAAAAA=='.
]

{ #category : #'tests-accessing' }
DSPharoLinkV2ConverterTest >> testEncodedUrl [
	| data result |
	data := Array 
		with: (DSSharedData newTonel url: 'https://example.com/tonel.zip'; yourself)
		with: (DSSharedData newCodeSnippet url: 'https://example.com/code-snippet.st'; yourself).
	builder := self classToTest new.
	builder data: data.
	result := builder encodedUrl.
	self 
		assert: result 
		equals: 'https://pharo-link.herokuapp.com/v2/?data=H4sIAAAAAAAAACvJz0vN0c4oKSkottLXT61IzC3ISdVLzs/VB8voVWUW8HIl56ekBudlFhSklmBVCpLXLYYo0CsuAQCrPc3fVAAAAA%3D%3D' asZnUrl.
]

{ #category : #'tests-accessing' }
DSPharoLinkV2ConverterTest >> testMarkdown [
	| data result |
	data := Array 
		with: (DSSharedData newTonel url: 'https://example.com/tonel.zip'; yourself)
		with: (DSSharedData newCodeSnippet url: 'https://example.com/code-snippet.st'; yourself).
	builder := self classToTest new.
	builder data: data.
	result := builder markdown.
	self 
		assert: result 
		equals: '[Load in Pharo](https://pharo-link.herokuapp.com/v2/?data=H4sIAAAAAAAAACvJz0vN0c4oKSkottLXT61IzC3ISdVLzs/VB8voVWUW8HIl56ekBudlFhSklmBVCpLXLYYo0CsuAQCrPc3fVAAAAA%3D%3D)'.
]
