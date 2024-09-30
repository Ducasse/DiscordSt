Extension { #name : 'DSEmbedImage' }

{ #category : '*Discord-Core-GT' }
DSEmbedImage >> gtInspectorActionDownloadData [
	<gtInspectorAction>
	^ GLMGenericAction new
		action: [ :presentation | self data. presentation update ];
		icon: (self iconNamed: #bottom);
		condition: [ self hasData not ];
		title: 'Download data'
]

{ #category : '*Discord-Core-GT' }
DSEmbedImage >> gtInspectorImage: composite [
	<gtInspectorPresentationOrder: 2>
	^ composite morph
		title: 'Image';
		display: [ | aStream |
				aStream := self data readStream.
				ImageReadWriter formFromStream: aStream ];
		when: [ self hasData and: [ 
					[ ImageReadWriter formFromStream: self data readStream.
					true ]
					on: Error do: [ :exception | exception return: false ] ] ];
		yourself	
]
