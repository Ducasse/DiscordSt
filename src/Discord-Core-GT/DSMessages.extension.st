Extension { #name : 'DSMessages' }

{ #category : '*Discord-Core-GT' }
DSMessages >> gtInspectorMessages: composite [
	<gtInspectorPresentationOrder: -2>
	^ composite fastTable 
		title: [ 'Messages' ];
		display: [ self ];
		when: [ self notEmpty ];
		beMultiple;
		sendOneOrMultipleAs: DSMessages;
		column: 'Time' 
			evaluated: [ :message | self printShortTime: message timestamp ]
			width: 80
			tags: { }
			sortedBy: [ :a :b | a timestamp > b timestamp ];
		column: 'Author'
			evaluated: [ :message | message author ifNotNil: #username ]
			width: 100;
		column: '#Attach'
			evaluated: [ :message | message numberOfAttachments ]
			width: 80
			tags: [  :message | Array streamContents: [ :aStream |
				message hasFuelAttachments ifTrue: [ 
					aStream nextPut: 'Fuel' ].
				message hasImageAttachments ifTrue: [ 
					aStream nextPut: 'Img' ] ]  ]
			sortedBy: [ :a :b | a numberOfAttachments > b numberOfAttachments ];
		column: '#Embeds'
			evaluated: [ :message | message numberOfEmbeds ]
			width: 90
			tags: [ :message | Array streamContents: [ :aStream |
"				message isFuelObject ifTrue: [ 
					aStream nextPut: 'Object' ].
				message isFuelStack ifTrue: [ 
					aStream nextPut: 'Stack' ].
				message isFuelPlayground ifTrue: [ 
					aStream nextPut: 'Playground' ]."
				message hasEmbedImages ifTrue: [ 
					aStream nextPut: 'Img' ] ] ]
			sortedBy: [ :a :b | a numberOfEmbeds > b numberOfEmbeds ];
		column: 'Content'
			evaluated: [ :message | message printFullMessage ];
		yourself
]

{ #category : '*Discord-Core-GT' }
DSMessages >> gtMessagesFor: aView [
	<gtView>
	^ aView columnedList 
		title: 'Messages';
		items: [ self ];
		priority: 1;
		column: 'Time' 
			item: [ :aMessage | aMessage timestamp ] 
			format: [ :aTimestamp | self printShortTime: aTimestamp ]
			width: 80;
		column: 'Author'
			item: [ :aMessage | aMessage username ]
			width: 80;
		column: '#Attach'
			item: [ :aMessage | aMessage numberOfAttachments ]
			width: 80;
		column: '#Embeds'
			item: [ :message | message numberOfEmbeds ]
			width: 80;
		column: 'Content'
			evaluated: [ :message | message printFullMessage asString ];
		yourself
]
