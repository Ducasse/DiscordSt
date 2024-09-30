Extension { #name : 'DSAttachment' }

{ #category : '*Discord-Core-GT' }
DSAttachment >> gtInspectorActionDownloadData [
	<gtInspectorAction>
	^ GLMGenericAction new
		action: [ :presentation | self data. presentation update ];
		icon: (self iconNamed: #bottom);
		condition: [ self hasData not ];
		title: 'Download data'
]

{ #category : '*Discord-Core-GT' }
DSAttachment >> gtInspectorActionMaterializeData [
	<gtInspectorAction>
	^ GLMGenericAction new
		action: [ :presentation | | result |
				result := self materialize.
				presentation update; selection: result ];
		icon: (self iconNamed: #glamorousAdd);
		condition: [ self isImage not ];
		title: 'Materialize'
]

{ #category : '*Discord-Core-GT' }
DSAttachment >> gtInspectorImage: composite [
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

{ #category : '*Discord-Core-GT' }
DSAttachment >> gtInspectorString: composite [
	<gtInspectorPresentationOrder: 2>
	^ composite text 
		title: 'String';
		display: [ self data truncateWithElipsisTo: 100000 ];
		when: [ self hasData and: [ self data isString ] ];
		yourself			
]

{ #category : '*Discord-Core-GT' }
DSAttachment >> gtInspectorZipItemsIn: composite [
	<gtInspectorPresentationOrder: 3>
	^ composite fastList
		title: 'ZIP';
		display: [ ZipArchive new 
						readFrom: self data readStream;
						members ];
		when: [ self isZipArchive ];
		format: [ :zipFileMember | zipFileMember fileName ];
		selectionPopulate: #selection 
			entitled: 'Inspect the ZIP member'
			with: [ :list | list rawSelection gtInspectorInterestingObject ];
		send: [ :zipFileMemberOrNil | 
			zipFileMemberOrNil ifNotNil: [ :member | member contents ] ]
]
