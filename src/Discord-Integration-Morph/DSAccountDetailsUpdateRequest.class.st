Class {
	#name : #DSAccountDetailsUpdateRequest,
	#superclass : #DSAccountDetailsRequest,
	#category : 'Discord-Integration-Morph'
}

{ #category : #private }
DSAccountDetailsUpdateRequest >> informAboutLoginException: exception [
	| contentMorph dialog textModel |
	textModel := RubScrolledTextModel new.
	textModel setText: exception asString.
	contentMorph := textModel newScrolledText
		beWrapped;
		beReadOnly;
		extent: 200 @ 200;
		yourself.
	dialog := Smalltalk ui theme
		newPluggableDialogWindowIn: World
		title: 'Login Error'
		for: contentMorph.
	dialog useDefaultOKButton.
	^ dialog open
]

{ #category : #private }
DSAccountDetailsUpdateRequest >> loginTo: aDSClientRegistry email: emailString password: passwordString [
	[ [ aDSClientRegistry
		email: emailString;
		password: passwordString;
		login ]
		on: DSTwoFactorNotificationRequiered
		do: [ :exception | self provideTwoFactorCode: exception ] ]
		on: Error
		do:
			[ :exception | self informAboutLoginException: exception ]
]

{ #category : #private }
DSAccountDetailsUpdateRequest >> provideTwoFactorCode: aDSTwoFactorNotificationRequiered [ 
	| codeOrNil |
	codeOrNil := UIManager default 
		request: 'Provide Discord Two-Factor-Authentication code' 
		initialAnswer: '' 
		title: 'Discord Two-Factor-Authentication'.
	codeOrNil ifNil: [ aDSTwoFactorNotificationRequiered pass ].
	(codeOrNil isString and: [ codeOrNil notEmpty ]) ifFalse: [ aDSTwoFactorNotificationRequiered pass ].
	aDSTwoFactorNotificationRequiered code: codeOrNil.
	aDSTwoFactorNotificationRequiered resume.
]

{ #category : #private }
DSAccountDetailsUpdateRequest >> updateAuthenticatedClientRegistry: aDSClientRegistry [ 
	| clientMorph |
	clientMorph := self morph ensureAuthenticatedClientMorph.
	clientMorph registry: aDSClientRegistry.
]

{ #category : #private }
DSAccountDetailsUpdateRequest >> updateUnauthenticatedClientRegistry: aDSClientRegistry [ 
	"Display a server and channel list on an authenticated Discord client."
	| loginMorph |
	loginMorph := self morph ensureClientLoginMorph.
	loginMorph onLoginRequestDo: [ :email :password | 
		self loginTo: aDSClientRegistry email: email password: password ].
]

{ #category : #visiting }
DSAccountDetailsUpdateRequest >> visitDSClientRegistry: aDSClientRegistry [ 
	aDSClientRegistry isAuthenticated 
		ifTrue: [ self updateAuthenticatedClientRegistry: aDSClientRegistry ]
		ifFalse: [ self updateUnauthenticatedClientRegistry: aDSClientRegistry ]
]

{ #category : #visiting }
DSAccountDetailsUpdateRequest >> visitDSWebhookRegistry: aDSWebhookRegistry [ 
	self morph ensureWebhookRegistry.
	
]
