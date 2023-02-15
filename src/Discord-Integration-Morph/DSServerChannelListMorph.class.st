Class {
	#name : #DSServerChannelListMorph,
	#superclass : #DSPanelMorph,
	#instVars : [
		'registry'
	],
	#category : 'Discord-Integration-Morph'
}

{ #category : #examples }
DSServerChannelListMorph class >> empty [
	<gtExample>
	<label: 'A client without any server'>
	^ self basic
		registry: DSMockClient noServers asRegistry;
		yourself
]

{ #category : #examples }
DSServerChannelListMorph class >> initialExtent [
	^ 400 @ 200
]

{ #category : #examples }
DSServerChannelListMorph class >> oneServer [
	<gtExample>
	<label: 'A client with one server'>
	^ self basic
		registry: DSMockClient authenticated asRegistry;
		yourself
]

{ #category : #examples }
DSServerChannelListMorph class >> oneServerInWindow [
	<example>
	^ self oneServer openInWindow
]

{ #category : #accessing }
DSServerChannelListMorph >> channels [
	^ self registry channelsOfSelectedServer
]

{ #category : #initialization }
DSServerChannelListMorph >> initialize [
	super initialize.
	registry := DSNoRegistry uniqueInstance.
	self addMorphBack: self newServerList.
	self addMorphBack: self newChannelList.
]

{ #category : #testing }
DSServerChannelListMorph >> isAuthenticatedClientMorph [
	^ true
]

{ #category : #'instance creation' }
DSServerChannelListMorph >> newChannelList [
	^ (DropListMorph
			on: self
			list: #channels
			selected: #selectedChannel
			changeSelected: #selectedChannel:
			useIndex: false)
				wrapSelector: #name;
				hResizing: #spaceFill;
				vResizing: #shrinkWrap;
				yourself.
]

{ #category : #'instance creation' }
DSServerChannelListMorph >> newServerList [
	^ (DropListMorph
			on: self
			list: #servers
			selected: #selectedServer
			changeSelected: #selectedServer:
			useIndex: false)
				wrapSelector: #name;
				hResizing: #spaceFill;
				vResizing: #shrinkWrap;
				yourself.
]

{ #category : #accessing }
DSServerChannelListMorph >> registry [
	^ registry
]

{ #category : #accessing }
DSServerChannelListMorph >> registry: anObject [
	registry := anObject.
	self updateView.
]

{ #category : #'accessing - convenience' }
DSServerChannelListMorph >> selectedChannel [
	^ self registry selectedChannel
]

{ #category : #'accessing - convenience' }
DSServerChannelListMorph >> selectedChannel: aChannel [ 
	^ self registry selectedChannel: aChannel
]

{ #category : #'accessing - convenience' }
DSServerChannelListMorph >> selectedServer [
	^ self registry selectedServer
]

{ #category : #'accessing - convenience' }
DSServerChannelListMorph >> selectedServer: aGuild [ 
	self registry selectedServer: aGuild.
	self changed: #channels.
	self changed: #selectedChannel.
]

{ #category : #'accessing - convenience' }
DSServerChannelListMorph >> servers [
	^ self registry servers
]

{ #category : #userinterface }
DSServerChannelListMorph >> updateView [
	self changed: #servers.
	self changed: #selectedServer.
	self changed: #channels.
	self changed: #selectedChannel.
]
