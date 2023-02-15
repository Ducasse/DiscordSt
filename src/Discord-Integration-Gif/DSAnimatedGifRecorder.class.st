Class {
	#name : #DSAnimatedGifRecorder,
	#superclass : #Object,
	#instVars : [
		'announcer',
		'rectangle',
		'writer',
		'bytes',
		'continue',
		'isRectangleRequested',
		'isRecording',
		'writeStream'
	],
	#category : 'Discord-Integration-Gif'
}

{ #category : #examples }
DSAnimatedGifRecorder class >> recordForFiveSeconds [
	<gtExample>
	<label: 'Record a user defined screen part for five seconds'>
	^ self new
		whenRectangleRequestedDo: [ :announcement | 
			announcement rectangle: World bounds ];
		whenRecordingFinishedDo: [ :announcement |
			self inform: 'Recording finished' ];
		whenRecordingInitiatedDo: [ :announcement | 
			[ 	
				self inform: 'Recording now...'.
				5 seconds wait. 
				announcement recorder stop 
			] forkAt: Processor userSchedulingPriority + 1 named: 'Screen recording example' ];
		start.
]

{ #category : #announcing }
DSAnimatedGifRecorder >> announceRecordingCanceled [
	self announcer announce: (DSGifRecordingCanceledAnnouncement recorder: self)
]

{ #category : #announcing }
DSAnimatedGifRecorder >> announceRecordingFinished [
	self announcer announce: (DSGifRecordingFinishedAnnouncement recorder: self)
]

{ #category : #announcing }
DSAnimatedGifRecorder >> announceRecordingInitiated [
	self announcer announce: (DSGifRecordingInitiatedAnnouncement recorder: self)
]

{ #category : #announcing }
DSAnimatedGifRecorder >> announceRectangleRequest [
	| announcement |
	announcement := DSGifRectangleRequestAnnouncement recorder: self.
	self announcer announce: announcement.
	rectangle := announcement rectangle.
]

{ #category : #accessing }
DSAnimatedGifRecorder >> announcer [
	^ announcer
]

{ #category : #accessing }
DSAnimatedGifRecorder >> bytes [
	"Return bytes representing a recorded animated GIF"
	^ bytes
]

{ #category : #private }
DSAnimatedGifRecorder >> defineRectangle [
	isRectangleRequested := true.
	self announceRectangleRequest.
	rectangle ifNil: [ 
		self inform: 'Define recording area...'.
		rectangle := Rectangle fromUser ].
	isRectangleRequested := false.

]

{ #category : #private }
DSAnimatedGifRecorder >> doOneRecord [
	| form frame |
	continue ifFalse: [ ^ self ].
	form := Form fromDisplay: rectangle.
	frame := AnimatedImageFrame new.
	frame
		form: form;
		delay: 20.
	writer nextPutFrame: frame.
]

{ #category : #private }
DSAnimatedGifRecorder >> doStart [
	bytes := nil.
	writeStream := ByteArray new writeStream.
	writer := GIFReadWriter on: writeStream.
	writer loopCount: -1. "Ensures infinite loop"
	isRecording := true.
	self announceRecordingInitiated.
	World 
		startStepping: self 
		at: Time millisecondClockValue 
		selector: #doOneRecord 
		arguments: {} 
		stepTime: 20.
]

{ #category : #accessing }
DSAnimatedGifRecorder >> gifReader [
	| reader |
	bytes ifNil: [ ^ nil ].
	self isRecording ifTrue: [ ^ nil ].
	reader := GIFReadWriter on: self bytes readStream.
	Cursor wait showWhile: [
		reader
			readHeader;
			readBody ].
	^ reader
]

{ #category : #initialization }
DSAnimatedGifRecorder >> initialize [
	super initialize.
	announcer := self newAnnouncer.
	continue := true.
	rectangle := nil.
	isRectangleRequested := false.
	writer := nil.
	isRecording := false.
]

{ #category : #testing }
DSAnimatedGifRecorder >> isRecording [
	^ isRecording
]

{ #category : #testing }
DSAnimatedGifRecorder >> isRectangleRequested [
	^ isRectangleRequested
]

{ #category : #'instance creation' }
DSAnimatedGifRecorder >> newAnnouncer [
	^ Announcer new
]

{ #category : #actions }
DSAnimatedGifRecorder >> nextAction [
	bytes ifNotNil: [ 
		self isRecording ifFalse: [ ^ self show ] ].
	self isRecording ifFalse: [ ^ self start ] ifTrue: [ ^ self stop ].
]

{ #category : #'wiw support' }
DSAnimatedGifRecorder >> shouldGetStepsFrom: aWorldMorph [ 
	^ World = aWorldMorph
]

{ #category : #actions }
DSAnimatedGifRecorder >> show [
	^ (AnimatedImageMorph fromGIFReader: self gifReader) openInWindow.
]

{ #category : #actions }
DSAnimatedGifRecorder >> start [
	self stop.
	self defineRectangle.
	rectangle ifNil: [ ^ self announceRecordingCanceled ].
	rectangle extent isZero ifTrue: [ ^ self announceRecordingCanceled ].
	self doStart.
]

{ #category : #actions }
DSAnimatedGifRecorder >> stop [
	isRecording ifFalse: [ ^ self ].
	continue := false.
	World stopStepping: self selector: #doOneRecord.
	writer close.
	writeStream close.
	bytes := writeStream contents.
	isRecording := false.
	self announceRecordingFinished.
]

{ #category : #subscription }
DSAnimatedGifRecorder >> whenRecordingCanceledDo: aBlockClosure [ 
	self announcer 
		subscribe: DSGifRecordingCanceledAnnouncement 
		do: aBlockClosure
]

{ #category : #subscription }
DSAnimatedGifRecorder >> whenRecordingFinishedDo: aBlockClosure [ 
	self announcer 
		subscribe: DSGifRecordingFinishedAnnouncement 
		do: aBlockClosure
]

{ #category : #subscription }
DSAnimatedGifRecorder >> whenRecordingInitiatedDo: aBlockClosure [ 
	self announcer 
		subscribe: DSGifRecordingInitiatedAnnouncement 
		do: aBlockClosure
]

{ #category : #subscription }
DSAnimatedGifRecorder >> whenRectangleRequestedDo: aBlockClosure [ 
	self announcer 
		subscribe: DSGifRectangleRequestAnnouncement 
		do: aBlockClosure
]
