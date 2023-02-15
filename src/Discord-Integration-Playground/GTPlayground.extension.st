Extension { #name : #GTPlayground }

{ #category : #'*Discord-Integration-Playground' }
GTPlayground >> discordMonticelloOfSharedPlaygroundAction [
	<pageAction>
	<pageActionOrder: 50>
	^ GLMGenericAction new
		action: [ :presentation | 
			DSOpenTonelArchiveCommand new
				bytes: self monticelloPort value bytes;
				execute ];
		icon: (self iconNamed: #glamorousOpen);
		title: 'Open Shared Source Code in Monticello' translated;
		condition: [ self monticelloPort value notNil ].
]

{ #category : #'*Discord-Integration-Playground' }
GTPlayground >> discordSharePlaygroundAction [
	<pageAction>
	<pageActionOrder: 45>
	^ GLMGenericAction new
		action: [ :presentation | 
			DSSharePlaygroundCommand new
				playground: self;
				executeAsync ];
		icon: DSIcons discord;
		title: 'Share Playground' translated
]

{ #category : #'*Discord-Integration-Playground' }
GTPlayground >> monticelloPort [
	<return: #GLMPort>
	^ self pane port: #monticello
]
