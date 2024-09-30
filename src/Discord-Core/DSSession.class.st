"
I keep email and password used to login into Discord, and token used to authorize Discord opperations, e.g., read and write messages. 

I am used by DSClient.

Public API and Key Messages

- email:password: - set email and login values
- token: - set token value

Internal Representation and Key Implementation Points.

    Instance Variables
	email:		<String>
	password:		<String>
	token:		<String>

"
Class {
	#name : 'DSSession',
	#superclass : 'Object',
	#instVars : [
		'email',
		'password',
		'token',
		'isBot'
	],
	#category : 'Discord-Core-REST-Api',
	#package : 'Discord-Core',
	#tag : 'REST-Api'
}

{ #category : 'accessing' }
DSSession >> email [
	"Get email or nil used to login into a Discord server."
	^ email
]

{ #category : 'accessing' }
DSSession >> email: aString [
	"Set email used to login into a Discord server."
	email := aString
]

{ #category : 'convenient' }
DSSession >> email: emailString password: passwordString [ 
	"Set email and password used to login into a Discord server."
	self 
		email: emailString;
		password: passwordString
]

{ #category : 'private' }
DSSession >> ensureVolatilePassword [
	| passwordValue |
	passwordValue := ''.
	"Migration code"
	password isString ifTrue: [ passwordValue := password. password := nil ].
	password ifNotNil: [ ^ self ].
	"Initialization"
	password := AutoReloadableVolatileTemporarySettingValue new.
	password string: passwordValue.
]

{ #category : 'private' }
DSSession >> ensureVolatileToken [
	| tokenValue |
	tokenValue := ''.
	"Migration code"
	token isString ifTrue: [ tokenValue := token. token := nil ].
	token ifNotNil: [ ^ self ].
	"Initialization"
	token := AutoReloadableVolatileTemporarySettingValue new.
	token string: tokenValue.
]

{ #category : 'testing' }
DSSession >> isAuthenticated [
	"Return true if token is not nil. It means that the client was previously authenticated successfully."
	^ self token isEmptyOrNil not
]

{ #category : 'accessing' }
DSSession >> password [
	"Get password used to login into a Discord server."
	self ensureVolatilePassword.
	^ password value
]

{ #category : 'accessing' }
DSSession >> password: aString [
	"Set password used to login into a Discord server."
	self ensureVolatilePassword.
	password string: aString
]

{ #category : 'printing' }
DSSession >> printOn: aStream [
	self isAuthenticated 
		ifFalse: [ aStream << 'Session: unauthenticated'.
			self email ifNotNil: [ :string |
				aStream << ' user ' << string ] ]
		ifTrue: [ aStream << 'Session: authenticated'.
			self email ifNotNil: [ :string |
				aStream << ' as ' << string ] ].
]

{ #category : 'public' }
DSSession >> resetToken [
	"Reset token (logout from Discord)."
	self token: ''
]

{ #category : 'accessing' }
DSSession >> token [
	"Get token used to authorize Discord opperations."
	self ensureVolatileToken.
	^ token value
]

{ #category : 'accessing' }
DSSession >> token: aString [
	"Set token used to authorize Discord opperations."
	self ensureVolatileToken.
	token string: aString
]
