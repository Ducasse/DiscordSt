"
I keep some constants for the Discord library.
"
Class {
	#name : #DSConstants,
	#superclass : #Object,
	#category : 'Discord-Core-Utility'
}

{ #category : #'constants - url' }
DSConstants class >> defaultRestApiSixUrl [
	"Return root URL used for Discord communication."
	^ 'https://discordapp.com/api/v6' asZnUrl
]

{ #category : #'constants - identification' }
DSConstants class >> deviceVersion [
	^ SystemVersion current asString
]

{ #category : #'constants - limit' }
DSConstants class >> discordAttachmentLimit [
	"Return Discord limit for an attachment in bytes.
	Discord limit for each attachment is 8 MB."
	^ 8000000
]

{ #category : #constants }
DSConstants class >> emptyAuthorName [
	"Return a default author name."
	^ 'Userless Name'
]

{ #category : #'constants - limit' }
DSConstants class >> maxFileNameLenght [
	"Return a maximum file name lenght used for sending attachments.
	I do not know if there is a correct limit for ZnMimeType.
	It is thus author's decision."
	^ 20
]

{ #category : #'constants - limit' }
DSConstants class >> maxMessageLenght [
	"Return a maximum message lenght (content or embed description) to send to a Discord."
	^ 2000
]

{ #category : #'constants - identification' }
DSConstants class >> osFamily [
	^ Smalltalk os family asString
]

{ #category : #'constants - identification' }
DSConstants class >> pharoVersion [
	^ SystemVersion current highestUpdate asString
]

{ #category : #'constants - identification' }
DSConstants class >> userAgent [
	"Return a correct User Agent.
	See https://discordapp.com/developers/docs/reference#user-agent"
	^ 'DiscordSt (https://github.com/JurajKubelka/DiscordSt, ', 
		self version, '-', 
		self pharoVersion, ')'
]

{ #category : #'constants - identification' }
DSConstants class >> version [
	"Return version number of this Discord library implementation."
	^ '0.2.4'
]
