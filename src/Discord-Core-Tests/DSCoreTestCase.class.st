"
A DSCoreTestCase is an abstract test class for testing the behavior of the Discord core.
"
Class {
	#name : 'DSCoreTestCase',
	#superclass : 'TestCase',
	#instVars : [
		'server',
		'fields',
		'serverSemaphoreTimeout'
	],
	#category : 'Discord-Core-Tests-Support',
	#package : 'Discord-Core-Tests',
	#tag : 'Support'
}

{ #category : 'testing' }
DSCoreTestCase class >> isAbstract [
	^ self = DSCoreTestCase
]

{ #category : 'defaults' }
DSCoreTestCase >> anyString [
	^ 'any string'
]

{ #category : 'defaults' }
DSCoreTestCase >> anyStringTwo [
	^ 'any string two'
]

{ #category : 'mock' }
DSCoreTestCase >> apiUrl [
	"Return the server URL.
	See the startZnServer method."
	^ server apiUrl
]

{ #category : 'accessing' }
DSCoreTestCase >> appveyorMessageString [
	"Message sent to a Discord channel from Appveyor.com"
	^ Smalltalk os environment
		at: 'APPVEYOR' 
		ifPresent: [ :string | | jobId accountName repoSlug |
			jobId := Smalltalk os environment at: 'APPVEYOR_BUILD_VERSION' ifAbsent: [ '<unknown job id>' ].
			accountName := Smalltalk os environment at: 'APPVEYOR_ACCOUNT_NAME' ifAbsent: [ 'JurajKubelka/DiscordSt' ].
			repoSlug := Smalltalk os environment at: 'APPVEYOR_PROJECT_SLUG' ifAbsent: [ 'JurajKubelka/DiscordSt' ].
			String streamContents: [ :stream |
				stream 
					<< '[Appveyor.com](https://ci.appveyor.com/project/JurajKubelka/discordst) message'
					<< 	', [job ' << jobId asString << '](https://ci.appveyor.com/project/'
					<< accountName asString << '/' << repoSlug asString
					<< '/build/' << jobId asString << '). '
					<< self classAndTestSelectorMessageString ] ]
		ifAbsent: nil.
]

{ #category : 'mock' }
DSCoreTestCase >> assertServerSemaphore [
	"Assert that semaphore is signalized in a specified time.
	See the startZnServer method."
	self 
		deny: (server semaphore waitTimeoutMSecs: self serverSemaphoreTimeout)
		description: 'The server semaphore was not signalized in time'
]

{ #category : 'defaults' }
DSCoreTestCase >> avatarUrl [
	^ 'http://files.pharo.org/media/logo/Pharo%20Logo%20SVG/Pharo_Icon_v3.0.svg'
]

{ #category : 'accessing' }
DSCoreTestCase >> bigNumber [
	"Return a 'big' integer"
	^ 411802679586802688
]

{ #category : 'accessing' }
DSCoreTestCase >> bigNumberTwo [
	"Return a 'big' integer"
	^ 4118026795868026882343243
]

{ #category : 'defaults' }
DSCoreTestCase >> bytes [
	^ #[ 1 2 3 4 ]
]

{ #category : 'defaults' }
DSCoreTestCase >> bytesTwo [
	^ #[ 9 8 7 6 5 ]
]

{ #category : 'accessing' }
DSCoreTestCase >> classAndTestSelectorMessageString [
	"Return a message string that is easily to identify on Discord."
	^ String streamContents: [ :aStream |
		aStream 
			<< 'Message sent from the test case '
			<< self className	
			<< '>>#'
			<< self selector
			<< ' at '.
		DateAndTime now printOn: aStream ]
]

{ #category : 'coverage' }
DSCoreTestCase >> classToTest [
	^ self subclassResponsibility
]

{ #category : 'defaults' }
DSCoreTestCase >> color [
	^ Color green
]

{ #category : 'defaults' }
DSCoreTestCase >> contentLongString [
	^ String new: DSConstants maxMessageLenght + 1
]

{ #category : 'defaults' }
DSCoreTestCase >> contentString [
	^ 'message one'
]

{ #category : 'accessing' }
DSCoreTestCase >> continuousIntegrationMessageString [
	"A message that is sent to a Discord test case channel"
	^ self travisMessageString ifNil: [ 
		self appveyorMessageString ifNil: [ 
			self classAndTestSelectorMessageString ] ]
]

{ #category : 'accessing' }
DSCoreTestCase >> coreModelJsonMapping [
	^ DSModelJsonMapping
]

{ #category : 'mock' }
DSCoreTestCase >> defaultConnectionTimeoutDuring: aBlock [
	"Set connection timeout during aBlock execution"
	ZnConnectionTimeout value: 1 during: aBlock
]

{ #category : 'defaults' }
DSCoreTestCase >> emailString [
	^ 'email@example.com'
]

{ #category : 'accessing - fields' }
DSCoreTestCase >> fields [
	^ fields ifNil: [ fields := SmallDictionary new ]
]

{ #category : 'accessing - fields' }
DSCoreTestCase >> fieldsAt: key [
	^ self fields at: key
]

{ #category : 'accessing - fields' }
DSCoreTestCase >> fieldsAt: key ifPresent: presentBlock ifAbsent: absentBlock [
	^ self fields at: key ifPresent: presentBlock ifAbsent: absentBlock
]

{ #category : 'accessing - fields' }
DSCoreTestCase >> fieldsAt: key put: object [
	^ self fields at: key put: object
]

{ #category : 'mock' }
DSCoreTestCase >> gatewayUrl [
	"Return the Gateway Discord server URL.
	See the startZnServer method."
	^ server gatewayUrl
]

{ #category : 'mock' }
DSCoreTestCase >> gatewayUrlMessage [
	"Return Discord Server response that answers Gateway URL."
	^ '{"url": "', self gatewayUrl asString, '"}'
]

{ #category : 'accessing' }
DSCoreTestCase >> messageClass [
	^ DSMessage
]

{ #category : 'accessing - objects' }
DSCoreTestCase >> messageObjectString [
	^ '{"type":0,"tts":false,"timestamp":"2017-06-12T15:36:23.719000+00:00","pinned":false,"nonce":"80750336","mentions":[],"mention_roles":[],"mention_everyone":false,"id":"36576","embeds":[],"edited_timestamp":null,"content":"ciao","channel_id":"5930","author":{"username":"user one","id":"08480","discriminator":"42","avatar":"be02f464a3f4ead"},"attachments":[]}'
]

{ #category : 'accessing - objects' }
DSCoreTestCase >> messageObjectWithAttachmentString [
	^ '{"mention_roles":[],"channel_id":"45930","author":{"avatar":"a3f4ead","id":"8480","username":"user one","discriminator":"42"},"edited_timestamp":null,"mention_everyone":false,"pinned":false,"nonce":null,"id":"84266","timestamp":"2017-06-13T12:38:51.053000+00:00","embeds":[],"attachments":[{"width":967,"filename":"Captura_de_pantalla_2017-06-13_a_las_14.38.04.png","url":"https://cdn.discordapp.com/attachments/54545930/8460673/Captura_de_pantalla_2017-06-13_a_las_14.38.04.png","height":475,"proxy_url":"https://images.discordapp.net/attachments/545930/460673/Captura_de_pantalla_2017-06-13_a_las_14.38.04.png","id":"60673","size":194200}],"type":0,"content":"Transcript screenshot 😄","tts":false,"mentions":[]}'

]

{ #category : 'accessing - objects' }
DSCoreTestCase >> messageObjectWithEmbedsObject: aRestApi [
	| message |
	message := DSModelJsonMapping 
		read: DSMessage withMapping: #messageMappingFor: on: self messageObjectWithEmbedsString readStream.
	^ message 
		restApi: aRestApi; 
		yourself
]

{ #category : 'accessing - objects' }
DSCoreTestCase >> messageObjectWithEmbedsString [
	^ '{"mention_roles":[],"channel_id":"45930","author":{"avatar":"a3f4ead","id":"8480","username":"user one","discriminator":"42"},"edited_timestamp":null,"mention_everyone":false,"pinned":false,"nonce":null,"id":"84266","timestamp":"2017-06-13T12:38:51.053000+00:00","embeds":[{"description":"Hello! I am a message :-)","url":"http://pharo.org","color":65280,"title":"Discord Message Title","type":"rich","footer":{"text":"Footer message","proxy_icon_url":"https://images-ext-2.discordapp.net/external/8ShKdo/http/lorempixel.com/32/32/abstract/","icon_url":"http://lorempixel.com/32/32/abstract/"}}],"attachments":[{"width":967,"filename":"Captura_de_pantalla_2017-06-13_a_las_14.38.04.png","url":"https://cdn.discordapp.com/attachments/54545930/8460673/Captura_de_pantalla_2017-06-13_a_las_14.38.04.png","height":475,"proxy_url":"https://images.discordapp.net/attachments/545930/460673/Captura_de_pantalla_2017-06-13_a_las_14.38.04.png","id":"60673","size":194200}],"type":0,"content":"Transcript screenshot 😄","tts":false,"mentions":[]}'

]

{ #category : 'instance creation' }
DSCoreTestCase >> newAnnouncer [
	^ Announcer new
]

{ #category : 'instance creation' }
DSCoreTestCase >> newAttachment [
	^ DSAttachment new
]

{ #category : 'instance creation' }
DSCoreTestCase >> newCategoryChannel [
	^ DSCategoryChannel new
]

{ #category : 'instance creation' }
DSCoreTestCase >> newContentObject [
	^ Object new
]

{ #category : 'instance creation' }
DSCoreTestCase >> newDateAndTime [
	^ DateAndTime fromString: '2017-05-08T15:56:48.149000+00:00'
]

{ #category : 'instance creation' }
DSCoreTestCase >> newEmbedFooterObject [
	^ DSEmbedFooter new
]

{ #category : 'instance creation' }
DSCoreTestCase >> newEmbedObject [
	^ DSEmbed new
]

{ #category : 'instance creation' }
DSCoreTestCase >> newEmptyArray [
	^ Array new
]

{ #category : 'instance creation' }
DSCoreTestCase >> newInstanceToBeTested [
	^ self classToTest new
]

{ #category : 'instance creation' }
DSCoreTestCase >> newMessage [
	^ DSMessage new
]

{ #category : 'instance creation' }
DSCoreTestCase >> newObjectToTest [
	"Return an object that correspond to the testing class"
	^ self classToTest new
]

{ #category : 'instance creation' }
DSCoreTestCase >> newRestApi [
	^ DSRestApi defaultClass new
]

{ #category : 'instance creation' }
DSCoreTestCase >> newSession [
	^ DSSession new
]

{ #category : 'instance creation' }
DSCoreTestCase >> newTextChannel [
	^ DSGuildTextChannel new
]

{ #category : 'instance creation' }
DSCoreTestCase >> newUser [
	^ DSUser new
]

{ #category : 'instance creation' }
DSCoreTestCase >> newUserGuild [
	^ DSGuild new
]

{ #category : 'defaults' }
DSCoreTestCase >> passwordString [
	^ 'secret password'
]

{ #category : 'mock' }
DSCoreTestCase >> serverDelegate [
	"Return the server delegate object.
	See the startZnServer method."
	^ server delegate
]

{ #category : 'mock' }
DSCoreTestCase >> serverDelegate: aDelegate [
	"Set the server delegate object.
	See the startZnServer method."
	^ server delegate: aDelegate
]

{ #category : 'mock' }
DSCoreTestCase >> serverRequests [
	"Return the server collection used for testing.
	See the startZnServer method."
	^ server collection
]

{ #category : 'mock' }
DSCoreTestCase >> serverSemaphoreTimeout [
	"Get the default server semaphore timeout in milliseconds"
	^ serverSemaphoreTimeout ifNil: 200
]

{ #category : 'mock' }
DSCoreTestCase >> serverSemaphoreTimeout: integer [
	"Set the default server semaphore timeout in milliseconds"
	^ serverSemaphoreTimeout := integer
]

{ #category : 'mock' }
DSCoreTestCase >> serverUrl [
	"Return the server URL.
	See the startZnServer method."
	^ server url
]

{ #category : 'mock' }
DSCoreTestCase >> signalServerSemaphore [
	"Signal the server semaphore.
	See the startZnServer method."
	server semaphore signal
]

{ #category : 'mock' }
DSCoreTestCase >> startZnServer [
	"Start a ZnServer that simulates the Discord server."
	server := DSMockServer new.
	server start.
]

{ #category : 'running' }
DSCoreTestCase >> tearDown [
	server ifNotNil: #stop.
	super tearDown.
]

{ #category : 'defaults' }
DSCoreTestCase >> titleString [
	^ 'title message'
]

{ #category : 'defaults' }
DSCoreTestCase >> token [
	^ 'secret-token'
]

{ #category : 'defaults' }
DSCoreTestCase >> tokenString [
	^ 'secret-token'
]

{ #category : 'accessing' }
DSCoreTestCase >> travisMessageString [
	"Message sent to a Discord channel from Travis-CI.org"
	^ Smalltalk os environment
		at: 'TRAVIS' 
		ifPresent: [ :string | | jobNumber osName jobId repoSlug |
			osName := Smalltalk os environment at: 'TRAVIS_OS_NAME' ifAbsent: [ '<unknown os name>' ].
			jobNumber := Smalltalk os environment at: 'TRAVIS_JOB_NUMBER' ifAbsent: [ '<unknown job number>' ].
			jobId := Smalltalk os environment at: 'TRAVIS_JOB_ID' ifAbsent: [ '<unknown job id>' ].
			repoSlug := Smalltalk os environment at: 'TRAVIS_REPO_SLUG' ifAbsent: [ 'JurajKubelka/DiscordSt' ].
			String streamContents: [ :stream |
				stream 
					<< '[Travis-CI.org](https://travis-ci.org/JurajKubelka/DiscordSt) message on '
					<< osName asString <<	', [job ' << jobNumber asString << '](https://travis-ci.org/'
					<< repoSlug asString << '/jobs/' << jobId asString << '). '
					<< self classAndTestSelectorMessageString ] ]
		ifAbsent: nil.
]

{ #category : 'defaults' }
DSCoreTestCase >> username [
	^ 'user one'
]
