"
A DSDisplaySharedPlaygroundTest is a test class for testing the behavior of DSDisplaySharedPlayground
"
Class {
	#name : #DSDisplaySharedPlaygroundTest,
	#superclass : #DSCommandTest,
	#instVars : [
		'window'
	],
	#category : 'Discord-Downloader-Tests'
}

{ #category : #running }
DSDisplaySharedPlaygroundTest >> classToTest [
	^ DSDisplaySharedPlayground
]

{ #category : #accessing }
DSDisplaySharedPlaygroundTest >> codeSnippetContents [
	"self codeSnippetContents utf8Decoded"
	^ #[13 13 100 101 109 111 32 58 61 32 77 121 68 101 109 111 32 110 101 119 46 13 100 101 109 111 32 114 111 119 115 58 32 50 48 59 32 99 111 108 117 109 110 115 58 32 52 48 46 13 100 101 109 111 32 100 114 97 119 46 13]
]

{ #category : #running }
DSDisplaySharedPlaygroundTest >> tearDown [
	window ifNotNil: #delete.
	super tearDown

]

{ #category : #tests }
DSDisplaySharedPlaygroundTest >> testCodeSnippet [
	| arrayOfData data |
	data := DSSharedData newCodeSnippet.
	data
		url: 'https://example.com/snippet.txt';
		contents: self codeSnippetContents.
	arrayOfData := Array with: data yourself.
	command := self classToTest new.
	command sharedData: arrayOfData.
	window := command execute; window.
	self
		assert: command playground entity content
		equals: '

demo := MyDemo new.
demo rows: 20; columns: 40.
demo draw.
'

]

{ #category : #tests }
DSDisplaySharedPlaygroundTest >> testTonel [
	| arrayOfData data port |
	command := self classToTest new.
	data := DSSharedData newTonel.
	data
		url: 'https://example.com/tonel.zip';
		contents: self tonelContents.
	arrayOfData := Array with: data yourself.
	command sharedData: arrayOfData.
	window := command execute; window.
	self
		assert: command playground entity content
		equals: ''.
	port := command playground monticelloPort.
	self assert: port notNil.
	self assert: port value equals: data.
	self assert: command otherWindows size equals: 1.
	command otherWindows do: #delete.
]

{ #category : #tests }
DSDisplaySharedPlaygroundTest >> testWindow [
	command := self classToTest new.
	window := command execute; window.
	self assert: window notNil.
	self assert: window isSystemWindow.
	self assert: command playground entity content isEmpty.
]

{ #category : #accessing }
DSDisplaySharedPlaygroundTest >> tonelContents [
	^ 'UEsDBBQAAAAIAFNhIkwJZB6bMAEAALICAAAWAAAATXlEZW1vL015RGVtby5jbGFzcy5zdJVR
wWrDMAw9x18h6MHQlkHWnQzrpbuOjQ12KRl4jhoyErvYDllo+u+zlWRZYYf1YqSn955kaVdJ
5+DEkoWWNYKAxWP3gLVZB8Q1R7SqioSAP318ovIRL7Xzb9JGdM+ShFvTOr6OkTJVU2vHWZJF
opIeC2O72ZadGTvBRUEqhc6VuoAzG0iw3cLoFBu8TwnLrhMLkLZIo8XkJu4J+sOISwcdemg0
fbg8lJjzC9PcynYY59Xb0DH8V2MrwGF1gLgCWA7x1Gw1lwLXeYuy3hntUfsw2h4ETddDKCY9
+PqYxmcDfQQoDeP+WNxENDCMGKi5IY8Q344eCaknzTgFyWbd5pfuLuhoBI1f/rnxAjgsFysO
0r9InZsaskFNJGXHNIXs34egtdDOaAvXyObjkcl8uW9QSwMEFAAAAAgAU2EiTPNytpFDAAAA
TgAAABsAAABNeURlbW8vTXlFeHRyYURlbW8uY2xhc3Muc3RzzkksLlao5uJUzkvMTVWwUlD2
rXStKClKdEnNzdcBCheXFqQWJeeAVAEl/ZOyUpNLQOLJiSWp6flFlRAtINVctVwAUEsDBBQA
AAAIAFNhIkztC5e/HgAAABwAAAARAAAATXlEZW1vL3BhY2thZ2Uuc3QLSEzOTkxPVahWUM5L
zE1VsFJQ9q10Sc3NV6jlAgBQSwECFAMUAAAACABTYSJMCWQemzABAACyAgAAFgAAAAAAAAAA
AAAAtoEAAAAATXlEZW1vL015RGVtby5jbGFzcy5zdFBLAQIUAxQAAAAIAFNhIkzzcraRQwAA
AE4AAAAbAAAAAAAAAAAAAAC2gWQBAABNeURlbW8vTXlFeHRyYURlbW8uY2xhc3Muc3RQSwEC
FAMUAAAACABTYSJM7QuXvx4AAAAcAAAAEQAAAAAAAAAAAAAAtoHgAQAATXlEZW1vL3BhY2th
Z2Uuc3RQSwUGAAAAAAMAAwDMAAAALQIAAAAA' base64Decoded asByteArray
]
