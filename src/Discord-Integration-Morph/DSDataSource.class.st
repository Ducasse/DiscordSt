"
I represent a Fast Table data source for DSPackageListMorph. 

Internal Representation and Key Implementation Points.

    Instance Variables
	packages:		<DSSelections>

"
Class {
	#name : #DSDataSource,
	#superclass : #FTTreeDataSource,
	#category : 'Discord-Integration-Morph'
}

{ #category : #accessing }
DSDataSource >> cellColumn: column row: rowIndex [
	| item cell |
	item := self elementAt: rowIndex.
	cell := FTIndentedCellMorph new.
	cell indentBy: item depth * 16.
	cell 
		addMorphBack: (self buttonFor: item);
		addMorphBack: (self newCheckBoxFor: item).
	^ cell
]

{ #category : #accessing }
DSDataSource >> items: anObject [
	"Set a collection of items to display."
	self rootItem: (self class rootItemFor: anObject).
	self addSourceToRootItem.
	self expandAll.
	
]

{ #category : #'instance creation' }
DSDataSource >> newCheckBoxFor: aFTBasicItem [ 
	<return: #CheckboxMorph>
	^ aFTBasicItem data accept: (DSDataSourceItemCheckbox new
		dataSource: self;
		tableItem: aFTBasicItem;
		yourself).
]

{ #category : #'as yet unclassified' }
DSDataSource >> updateData [
	"I am here to reset the items in case someone updated them."
	self rootItem updateData.
	self expandAll.
]
