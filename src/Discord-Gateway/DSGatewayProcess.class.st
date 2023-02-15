Class {
	#name : #DSGatewayProcess,
	#superclass : #Object,
	#instVars : [
		'mutex',
		'process',
		'canDoNextCycle',
		'websocket'
	],
	#category : 'Discord-Gateway-API'
}

{ #category : #testing }
DSGatewayProcess >> canDoNextCycle [
	"Heartbeat is allowed if there is a connected WebSocket
	and it is explicitly allowed."
	^ canDoNextCycle and: [ self isConnected ]
]

{ #category : #private }
DSGatewayProcess >> disableNextCycle [
	"Explicitly disable sending heartbeat messages.
	Useful, if you want to close the Discord Gateway connection."
	canDoNextCycle := false.
]

{ #category : #private }
DSGatewayProcess >> doCycle [
	self subclassResponsibility
]

{ #category : #private }
DSGatewayProcess >> enableNextCycle [
	"Explicitly enable sending heartbeat messages.
	Useful, if you want to close the Discord Gateway connection."
	canDoNextCycle := true.
]

{ #category : #initialization }
DSGatewayProcess >> initialize [
	super initialize.
	mutex := Mutex new.
	canDoNextCycle := true.
]

{ #category : #initialization }
DSGatewayProcess >> initializeProcess [
	process := [ [ self canDoNextCycle ] whileTrue: [ self doCycle ] ]
		forkAt: Processor userBackgroundPriority
		named: self printProcessName
]

{ #category : #testing }
DSGatewayProcess >> isActive [
	^ self isInactive not
]

{ #category : #testing }
DSGatewayProcess >> isConnected [
	"Return true if there is a connected websocket."
	^ self websocket
		ifNotNil: #isConnected
		ifNil: false
]

{ #category : #testing }
DSGatewayProcess >> isInactive [
	^ mutex critical: [ 
		process isNil or: [
			process isTerminated or: [
				process isTerminating ] ] ]
]

{ #category : #printing }
DSGatewayProcess >> printProcessName [
	^ String streamContents: [ :aStream |
		self printProcessNameOn: aStream ]
]

{ #category : #printing }
DSGatewayProcess >> printProcessNameOn: aStream [
	self subclassResponsibility 
]

{ #category : #public }
DSGatewayProcess >> start [
	"Start a process if not active yet."
	^ mutex critical: [ 
		self enableNextCycle.
		self isInactive ifTrue: [ self initializeProcess ].
		process ]
]

{ #category : #public }
DSGatewayProcess >> stop [
	"Stop a process if not active yet."
	^ mutex critical: [ 
		self disableNextCycle.
		"Stop process if possible."
		self stopProcess.
		process ]
]

{ #category : #private }
DSGatewayProcess >> stopProcess [
	"Stop (terminate) process if possible.
	Subclasses can overwrite me."
]

{ #category : #accessing }
DSGatewayProcess >> websocket [
	<return: #DSGatewayWebSocket>
	^ websocket
]

{ #category : #accessing }
DSGatewayProcess >> websocket: aDSGatewayWebSocket [
	websocket := aDSGatewayWebSocket
]
