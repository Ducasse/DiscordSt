Extension { #name : #DSAttachment }

{ #category : #'*Discord-Integration-Core' }
DSAttachment >> gtInspectorActionOpenTonelArchive [
	<gtInspectorAction>
	^ GLMGenericAction new
		action: [ :presentation | 
				self openTonelArchive ];
		icon: (self iconNamed: #glamorousOpen);
		condition: [ self filename = 'tonel.zip' ];
		title: 'Open Tonel Archive'
]

{ #category : #'*Discord-Integration-Core' }
DSAttachment >> openTonelArchive [
	DSOpenTonelArchiveCommand new
		bytes: self data;
		execute
]
