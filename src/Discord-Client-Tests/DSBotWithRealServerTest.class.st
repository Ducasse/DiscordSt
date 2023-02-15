"
A DSClientWithResourceTest is a test class for testing the behavior of DSClient, sharing login for all test cases.
"
Class {
	#name : #DSBotWithRealServerTest,
	#superclass : #DSClientTestCase,
	#instVars : [
		'bot'
	],
	#category : 'Discord-Client-Tests'
}

{ #category : #accessing }
DSBotWithRealServerTest class >> delayBetweenTests [
	"Return a duration object that says how much time de we want to wait between two test cases.
	The reason is that the Discord server may answer 'You are being rate limited' for too intensive communication."
	^ 600 milliSeconds
]

{ #category : #testing }
DSBotWithRealServerTest class >> isAbstract [
	^ true
]

{ #category : #accessing }
DSBotWithRealServerTest >> bot [
	^ bot ifNil: [ bot := self classToTest new
		token: self externalBotToken;
		yourself ]
]

{ #category : #accessing }
DSBotWithRealServerTest >> channelName [
	^ 'test-cases'
]

{ #category : #running }
DSBotWithRealServerTest >> classToTest [
	^ DSBot
]

{ #category : #accessing }
DSBotWithRealServerTest >> client [
	^ self bot
]

{ #category : #accessing }
DSBotWithRealServerTest >> externalBotToken [
	"Return Discord email login used for real testing.
	The value is secret, for that reason, we recomend you to set it in your environment.
	For example, if you use Travir-CI.org, you can set environments in settings."
	^ Smalltalk os environment at: 'DISCORD_ST_TEST_CASE_BOT_TOKEN' ifAbsent: nil.
]

{ #category : #accessing }
DSBotWithRealServerTest >> osFieldValue [
	^ '[', Smalltalk os name asString, ' - ', Smalltalk os version asString,
		'](https://en.wikipedia.org/wiki/Operating_system)'
]

{ #category : #accessing }
DSBotWithRealServerTest >> pharoFieldValue [
	^ SystemVersion current version asString, 
		' [', Smalltalk lastUpdateString asString, 
		' (', (Smalltalk wordSize = 4 ifTrue: [ '32' ] ifFalse: [ '64' ]), 'bits)]'
]

{ #category : #accessing }
DSBotWithRealServerTest >> serverName [
	^ 'Cesta'
]

{ #category : #running }
DSBotWithRealServerTest >> setUp [
	super setUp.
	"Let's wait a bit between two test cases, otherwise the Discord server may answer
	'You are being rate limited'"
	self skipIfNotAuthenticated.
	self class delayBetweenTests wait.
]

{ #category : #asserting }
DSBotWithRealServerTest >> skipIfNotAuthenticated [
	self client isAuthenticated ifFalse: [ self skip ]
]

{ #category : #tests }
DSBotWithRealServerTest >> testSendEmbedObject [
	| response content |
	content := self classAndTestSelectorMessageString.
	response := self client message
		embedTitle: 'Embed Title';
		embedDescription: content;
		embedUrl: 'http://pharo.org';
		embedColor: Color random;
		embedFooterText: 'Pharo Project';
		embedFooterIconUrl: 'attachment://footer.png';
		embedThumbnailUrl: 'attachment://thumbnail.png';
		embedImageUrl: 'attachment://screenshot.png';
		embedInlineFieldName: 'Pharo' value: self pharoFieldValue;
		embedInlineFieldName: 'OS' value: self osFieldValue;
		fileName: 'screenshot.png' morph: World submorphs atRandom;
		fileName: 'thumbnail.png' form: #help asIcon;
		fileName: 'footer.png' form: #pharo asIcon;
		fileName: 'random-image.jpg' 
			bytes: PolymorphSystemSettings pharoLogoContents base64Decoded asByteArray;
		sendToServer: self serverName channel: self channelName.
	self assert: response class equals: DSMessage.
	#( 'random-image.jpg' ) do: [ :eachFileName |
		self 
			assert: (response attachments anySatisfy: [ :attachment | 
				attachment filename = eachFileName ])
			description: eachFileName asString, ' not found as an attachment' ]
]
