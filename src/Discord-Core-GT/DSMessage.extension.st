Extension { #name : 'DSMessage' }

{ #category : '*Discord-Core-GT' }
DSMessage >> gtInspectorActionDownloadAllAttachments [
	<gtInspectorAction>
	^ GLMGenericAction new
		action: [ :presentation | self attachments do: #data. presentation update ];
		icon: (Smalltalk ui icons iconNamed: #bottom);
		condition: [ self hasAttachments and: [ 
				self attachments anySatisfy: [ :attachment | 
					attachment hasData not ] ] ];
		title: 'Download all attachments'
]

{ #category : '*Discord-Core-GT' }
DSMessage >> gtInspectorAttachments: composite [
	<gtInspectorPresentationOrder: 2>
	^ composite fastList
		title: 'Attachments';
		display: [ self attachments ];
		when: [ self hasAttachments ];
		yourself
]

{ #category : '*Discord-Core-GT' }
DSMessage >> gtInspectorContent: composite [
	<gtInspectorPresentationOrder: 1>
	^ composite text
		title: 'Content';
		display: [ self printFullMessage ];
		when: [ self hasContent or: [ self hasEmbeds ] ];
		yourself
]

{ #category : '*Discord-Core-GT' }
DSMessage >> gtInspectorEmbedImage: composite [
	<gtInspectorPresentationOrder: 1.2>
	^ composite morph
		title: 'Image';
		display: [ self embedImages first asForm ];
		when: [ self hasEmbedImages ];
		yourself
]

{ #category : '*Discord-Core-GT' }
DSMessage >> gtInspectorEmbeds: composite [
	<gtInspectorPresentationOrder: 3>
	^ composite fastList
		title: 'Embeds';
		display: [ self embeds ];
		when: [ self hasEmbeds ];
		yourself
]

{ #category : '*Discord-Core-GT' }
DSMessage >> gtInspectorImage: composite [
	<gtInspectorPresentationOrder: 1.1>
	^ composite morph
		title: 'Image';
		display: [ self imageAttachments first asForm ];
		when: [ self hasImageAttachments ];
		yourself
]

{ #category : '*Discord-Core-GT' }
DSMessage >> gtMentionsFor: aView [
	<gtView>
	self mentions ifEmpty: [ ^ aView empty ].
	^ aView columnedList
		title: 'Mentions';
		priority: 10;
		items: [ self mentions ];
		column: 'Name' item: [ :aUser | aUser username ];
		column: 'Id' item: [ :aUser | aUser id ]
]
