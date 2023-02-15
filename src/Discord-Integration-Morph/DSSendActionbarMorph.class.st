"
I am a Morph.
I represent a action bar (area) with ""send"" and ""cancel"" buttons.
I announce #sendAction when a user clicks on the send button.
I announce #cancelAction wehn the user clicks on the cancel button.
I am used by DSScreenshotSendDialogMorph.
See examples on the class side.

"
Class {
	#name : #DSSendActionbarMorph,
	#superclass : #PanelMorph,
	#category : 'Discord-Integration-Morph'
}

{ #category : #examples }
DSSendActionbarMorph class >> basic [
	<gtExample>
	<label: 'A basic instance without any configuration'>
	^ self new
		extent: 400@100;
		yourself
]

{ #category : #examples }
DSSendActionbarMorph class >> basicInWindow [
	<example>
	^ self basic openInWindow
]

{ #category : #examples }
DSSendActionbarMorph class >> listenToClicks [
	<gtExample>
	<label: 'Display an information on button clicks'>
	^ self basic
		onCancelDo: [ :ann | self inform: ann ];
		onSendDo: [ :ann | self inform: ann ];
		yourself
]

{ #category : #examples }
DSSendActionbarMorph class >> listenToClicksInWindow [
	<example>
	^ self listenToClicks openInWindow
]

{ #category : #examples }
DSSendActionbarMorph class >> twoWebhooks [
	<gtExample>
	<label: 'Add two webhooks registry'>
	| ui |
	ui := self listenToClicks
		registries: DSRegistries twoWebhooks;
		yourself.
	"self assert: ui selection notNil."
	^ ui
]

{ #category : #examples }
DSSendActionbarMorph class >> twoWebhooksInWindow [
	<example>
	^ self twoWebhooks openInWindow
]

{ #category : #examples }
DSSendActionbarMorph class >> webhook [
	<gtExample>
	<label: 'Add one webhook registry'>
	^ self listenToClicks
		registries: DSRegistries webhook;
		yourself
]

{ #category : #examples }
DSSendActionbarMorph class >> webhookInWindow [
	<example>
	^ self webhook openInWindow
]

{ #category : #actions }
DSSendActionbarMorph >> cancel [
	self doAnnounce: #cancelAction. 
]

{ #category : #initialization }
DSSendActionbarMorph >> initialize [
	super initialize.
	self
		color: Color transparent;
		changeTableLayout;
		cellInset: 8;
		listDirection: #leftToRight;
		hResizing: #spaceFill;
		vResizing: #shrinkWrap;
		addMorphBack: self newRegistriesMorph;
		addMorphBack: self newCancelButtonMorph;
		addMorphBack: self newSendButtonMorph
]

{ #category : #testing }
DSSendActionbarMorph >> isCancelEnabled [
	^ true
]

{ #category : #testing }
DSSendActionbarMorph >> isSendEnabled [
	^ true
]

{ #category : #'instance creation' }
DSSendActionbarMorph >> newCancelButtonMorph [
	^ PluggableButtonMorph
		newButtonFor: self
		getState: nil
		action: #cancel
		arguments: nil
		getEnabled: #isCancelEnabled
		label: 'Cancel'
		help: 'Close the window'
]

{ #category : #'instance creation' }
DSSendActionbarMorph >> newHorizontalSpaceMorph [
	^ Morph new
		hResizing: #spaceFill;
		color: Color transparent;
		yourself.
]

{ #category : #'instance creation' }
DSSendActionbarMorph >> newRegistriesMorph [
	^ DSRegistriesMorph new
]

{ #category : #'instance creation' }
DSSendActionbarMorph >> newSendButtonMorph [
	^ PluggableButtonMorph
		newButtonFor: self
		getState: nil
		action: #send
		arguments: nil
		getEnabled: #isSendEnabled
		label: 'Send Message'
		help: 'Send Message to Discord'
]

{ #category : #'announcements-registration' }
DSSendActionbarMorph >> onCancelDo: oneArgBlock [
	"Register an action is performed on cancel button click.
	oneArgBlock receives announcement (symbol)."
	self onAnnouncement: #cancelAction do: oneArgBlock
]

{ #category : #'announcements-registration' }
DSSendActionbarMorph >> onCancelSend: aMessageSelector to: anObject [
	"Register an action is performed on cancel button click."
	self onAnnouncement: #cancelAction send: aMessageSelector to: anObject
]

{ #category : #'announcements-registration' }
DSSendActionbarMorph >> onSendDo: oneArgBlock [
	"Register an action is performed on send button click.
	oneArgBlock receives announcement (symbol)."
	self onAnnouncement: #sendAction do: oneArgBlock
]

{ #category : #'announcements-registration' }
DSSendActionbarMorph >> onSendSend: aMessageSelector to: anObject [
	"Register an action is performed on send button click."
	self onAnnouncement: #sendAction send: aMessageSelector to: anObject
]

{ #category : #accessing }
DSSendActionbarMorph >> registries [
	<return: #DSRegistries>
	^ self submorphs first registries
]

{ #category : #accessing }
DSSendActionbarMorph >> registries: aDSRegistries [
	self submorphs first registries: aDSRegistries
]

{ #category : #actions }
DSSendActionbarMorph >> send [
	self doAnnounce: #sendAction. 
]

{ #category : #'announcements-registration' }
DSSendActionbarMorph >> unsubscribeCancelAndSendActions: aSubscriber [ 
	"It actually unsubscribe from all subscriptions.
	It should not matter."
	self announcer unsubscribe: aSubscriber
]
