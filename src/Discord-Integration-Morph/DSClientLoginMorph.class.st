Class {
	#name : #DSClientLoginMorph,
	#superclass : #DSPanelMorph,
	#instVars : [
		'onLoginRequest',
		'emailModel',
		'passwordModel'
	],
	#category : 'Discord-Integration-Morph'
}

{ #category : #examples }
DSClientLoginMorph class >> empty [
	<gtExample>
	<label: 'Basic Example'>
	^ self new 
			extent: 400@50;
			yourself.
]

{ #category : #examples }
DSClientLoginMorph class >> emptyInWindow [
	<example>
	^ self empty openInWindow
]

{ #category : #examples }
DSClientLoginMorph class >> filled [
	<gtExample>
	<label: 'Fill email and password with a value'>
	^ self empty
			email: 'contact@example.com';
			password: 'secret password';
			yourself.
]

{ #category : #examples }
DSClientLoginMorph class >> filledInWindow [
	<example>
	^ self filled openInWindow
]

{ #category : #examples }
DSClientLoginMorph class >> registeredEvents [
	<gtExample>
	<label: 'Register email and password auto accept events and login request event'>
	^ self empty
			onEmailUpdateDo: [ :email | self inform: 'Email: ', email asString];
			onPasswordUpdateDo: [ :password | self inform: 'Password: ', password asString];
			onLoginRequestDo: [ :email :password | 
				self inform: 'Login as ', email asString, ' with ', password asString, ' password'  ];
			yourself.
]

{ #category : #examples }
DSClientLoginMorph class >> registeredEventsInWindow [
	<example>
	^ self registeredEvents openInWindow
]

{ #category : #examples }
DSClientLoginMorph class >> registeredLoginAction [
	<gtExample>
	<label: 'Register login request event'>
	^ self filled
			onLoginRequestDo: [ :email :password | 
				self inform: 'Login as ', email asString, ' with ', password asString, ' password'  ];
			yourself.
]

{ #category : #examples }
DSClientLoginMorph class >> registeredLoginActionInWindow [
	<example>
	^ self registeredLoginAction openInWindow
]

{ #category : #accessing }
DSClientLoginMorph >> email [
	^ emailModel getString
]

{ #category : #accessing }
DSClientLoginMorph >> email: aString [
	emailModel setText: aString
]

{ #category : #'private - handling - login' }
DSClientLoginMorph >> getLoginButtonEnabled [
	^ true
]

{ #category : #'private - handling - login' }
DSClientLoginMorph >> handleEnterKey [
	emailModel getString isEmpty ifTrue: [ ^ self ].
	passwordModel getString isEmpty ifTrue: [ ^ self ].
	self loginAction
]

{ #category : #initialization }
DSClientLoginMorph >> initialize [
	super initialize.
	emailModel := RubScrolledTextModel new.
	emailModel interactionModel: self.
	passwordModel := RubScrolledTextModel new.
	passwordModel interactionModel: self.
	onLoginRequest := [ :email :password |  ].
	self cellPositioning: #topLeft.
	self addMorphBack: self newEmailFieldMorph.
	self addMorphBack: self newPasswordFieldMorph.
	self addMorphBack: self newLoginButtonMorph.
	self submorphs first takeKeyboardFocus.
	self initializeTabKeyCombination.
	self initializeEnterKeyCombination.
]

{ #category : #initialization }
DSClientLoginMorph >> initializeEnterKeyCombination [
	self submorphs first
		bindKeyCombination: Character cr asKeyCombination
		toAction: [ self handleEnterKey ].
	self submorphs second
		bindKeyCombination: Character cr asKeyCombination
		toAction: [ self handleEnterKey ].

]

{ #category : #initialization }
DSClientLoginMorph >> initializeTabKeyCombination [
	self submorphs first
		bindKeyCombination: Character tab asKeyCombination
		toAction: [ self submorphs second takeKeyboardFocus ].
	self submorphs first
		bindKeyCombination: Character tab shift asKeyCombination
		toAction: [ self submorphs third takeKeyboardFocus ].
	self submorphs second
		bindKeyCombination: Character tab asKeyCombination
		toAction: [ self submorphs third takeKeyboardFocus ].
	self submorphs second
		bindKeyCombination: Character tab shift asKeyCombination
		toAction: [ self submorphs first takeKeyboardFocus ]
]

{ #category : #testing }
DSClientLoginMorph >> isClientLoginMorph [
	^ true
]

{ #category : #'private - handling - login' }
DSClientLoginMorph >> loginAction [
	onLoginRequest
		cull: emailModel getString
		cull: passwordModel getString
]

{ #category : #'instance creation' }
DSClientLoginMorph >> newEmailFieldMorph [
	^ emailModel newTextField
		takeKeyboardFocus;
		autoAccept: true;
		withGhostText: 'email@example.com';
		hResizing: #spaceFill;
		yourself.
]

{ #category : #'instance creation' }
DSClientLoginMorph >> newLoginButtonMorph [
	^ (PluggableButtonMorph
		newButtonFor: self
		getState: nil
		action: #loginAction
		arguments: nil
		getEnabled: #getLoginButtonEnabled
		label: 'Login'
		help: 'Login to Discord server')
			hResizing: #shrinkWrap;
			vResizing: #shrinkWrap;
			yourself.
]

{ #category : #'instance creation' }
DSClientLoginMorph >> newPasswordFieldMorph [
	^ passwordModel newTextField
		font: (StrikeFont passwordFontSize: self theme textFont pointSize);
		autoAccept: true;
		withGhostText: 'secret password';
		hResizing: #spaceFill;
		yourself.
]

{ #category : #accessing }
DSClientLoginMorph >> onEmailUpdateDo: aBlock [
	"One argument block receives updated email."

	^ emailModel announcer
		when: RubTextUpdatedInModel
		do: [ :ann | aBlock cull: emailModel getString ]
]

{ #category : #accessing }
DSClientLoginMorph >> onLoginRequestDo: aBlock [
	"An action that is expected to do after click on the 'Login' button.
	The block optionaly receives two arguments, email and password."
	onLoginRequest := aBlock
]

{ #category : #accessing }
DSClientLoginMorph >> onPasswordUpdateDo: aBlock [
	^ passwordModel announcer
		when: RubTextUpdatedInModel
		do: [ :ann | aBlock cull: passwordModel getString ]
]

{ #category : #accessing }
DSClientLoginMorph >> password [
	^ passwordModel getString
]

{ #category : #accessing }
DSClientLoginMorph >> password: aString [
	passwordModel setText: aString
]
