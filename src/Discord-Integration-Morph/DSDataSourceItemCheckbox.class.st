"
I am used for building and updating Fast Table Row items. 
I know how to display package and class selections.
I use a visitor pattern to build a corresponding Morph representatition.
I am used by DSDataSource which I need to access some information, e.g., rootItem.

Internal Representation and Key Implementation Points.

    Instance Variables
	dataSource:		<DSDataSource>

"
Class {
	#name : #DSDataSourceItemCheckbox,
	#superclass : #Object,
	#instVars : [
		'dataSource',
		'tableItem'
	],
	#category : 'Discord-Integration-Morph'
}

{ #category : #'private - accessing' }
DSDataSourceItemCheckbox >> classIconFor: aDSClassSelection [
	^ #class asIcon
]

{ #category : #'private - accessing' }
DSDataSourceItemCheckbox >> classNameFor: aDSClassSelection [ 
	^ aDSClassSelection itemName
]

{ #category : #accessing }
DSDataSourceItemCheckbox >> dataSource [
	^ dataSource
]

{ #category : #accessing }
DSDataSourceItemCheckbox >> dataSource: anObject [
	dataSource := anObject
]

{ #category : #'instance creation' }
DSDataSourceItemCheckbox >> newAddGifButtonFor: aDSSendScreenshotsAttachment [ 
	^ self table theme 
		newButtonIn: self table 
		for: aDSSendScreenshotsAttachment 
		getState: nil 
		action: #addAnimatedGif 
		arguments: #() 
		getEnabled: #isSelected 
		label: '+animGIF' 
		help: 'Add animated GIF screenshot'
]

{ #category : #'instance creation' }
DSDataSourceItemCheckbox >> newAddWindowButtonFor: aDSSendScreenshotsAttachment [ 
	^ self table theme 
		newButtonIn: self table 
		for: aDSSendScreenshotsAttachment 
		getState: nil 
		action: #addNewWindow 
		arguments: #() 
		getEnabled: #isSelected 
		label: '+Window' 
		help: 'Add another window screenshot'
]

{ #category : #'instance creation' }
DSDataSourceItemCheckbox >> newCheckboxMorphFor: aDSSendAttachment labelMorph: aLabelMorph [
	| checkbox |
	checkbox := CheckboxMorph new.
	checkbox
		on: aDSSendAttachment
			selected: #isSelected
			changeSelected: #isSelected:;
		getEnabledSelector: #isEnabled;
		labelMorph: aLabelMorph;
		hResizing: #spaceFill;
		vResizing: #shrinkWrap.
	(aDSSendAttachment
		onContentChangedDo: [ :announcement | self table dataSource updateData ])
		subscriber: checkbox.
	(aDSSendAttachment
		onSelectionChangedDo: [ :announcement | self toggleEnabledForAllChildren ])
		subscriber: checkbox.
	(aDSSendAttachment
		onEnabledChangedDo: [ :announcement | checkbox enabled: aDSSendAttachment isEnabled ])
		subscriber: checkbox.
	checkbox announcer
		when: MorphDeleted
		do: [ :announcement | 
			announcement morph = checkbox
				ifTrue: [ aDSSendAttachment announcer unsubscribe: checkbox ] ].
	^ checkbox
]

{ #category : #'instance creation' }
DSDataSourceItemCheckbox >> newRecordingButtonFor: aDSAnimatedGifScreenshot [
	| button |
	button := self table theme 
		newButtonIn: self table 
		for: aDSAnimatedGifScreenshot 
		getState: nil 
		action: #nextRecoringAction 
		arguments: #()
		getEnabled: nil 
		getLabel: #recordingLabel
		help: nil.
	aDSAnimatedGifScreenshot recorder
		whenRectangleRequestedDo: [ :announcement |  
			aDSAnimatedGifScreenshot changed: #recordingLabel. ];
		whenRecordingInitiatedDo: [ :announcement | 
			aDSAnimatedGifScreenshot changed: #recordingLabel. ];
		whenRecordingFinishedDo: [ :announcement |
			aDSAnimatedGifScreenshot changed: #recordingLabel. ].
	^ button
]

{ #category : #'private - accessing' }
DSDataSourceItemCheckbox >> packageIconFor: aDSPackageSelection [
	^ #emptyPackage asIcon
]

{ #category : #'private - accessing' }
DSDataSourceItemCheckbox >> packageNameFor: aDSPackageSelection [ 
	^ Text streamContents: [ :stream | 
		stream << aDSPackageSelection itemName.
		aDSPackageSelection isSelected ifTrue: [ 
			stream withAttribute: TextEmphasis italic do: [ 
				| existingClasses selectedClasses diff |
				existingClasses := aDSPackageSelection item classes.
				selectedClasses := aDSPackageSelection classes.
				diff := (existingClasses size - selectedClasses size ).
				stream 
						space;
						nextPutAll: '(including '.
				selectedClasses ifNotEmpty: [ 
					stream 
						print: selectedClasses size;
						space;
						nextPutAll: (selectedClasses size = 1 ifTrue: [ 'class' ] ifFalse: [ 'classes' ]);
						nextPutAll: ' below' ].
				diff > 0 ifTrue: [ 
					selectedClasses ifNotEmpty: [ stream nextPutAll: ' and ' ].
					stream print: diff; space.
					selectedClasses ifNotEmpty: [ stream nextPutAll: 'more ' ].
					stream nextPutAll: (diff = 1 ifTrue: [ 'class' ] ifFalse: [ 'classes' ]) ].
				stream nextPut: $) ] ] ]
]

{ #category : #'private - accessing' }
DSDataSourceItemCheckbox >> rootItem [
	<return: #FTRootItem>
	^ self dataSource rootItem
]

{ #category : #'private - accessing' }
DSDataSourceItemCheckbox >> table [
	<return: #FTTableMorph>
	^ self dataSource table
]

{ #category : #accessing }
DSDataSourceItemCheckbox >> tableItem [
	^ tableItem
]

{ #category : #accessing }
DSDataSourceItemCheckbox >> tableItem: anObject [
	tableItem := anObject
]

{ #category : #private }
DSDataSourceItemCheckbox >> toggleEnabledForAllChildren [
	| allChildren |
	true ifTrue: [ ^ self ].
	allChildren := self withAllChildrenOf: self tableItem.
	allChildren do: [ :eachTableItem | 
		eachTableItem = self tableItem ifFalse: [ 
			eachTableItem data isEnabled: self tableItem data isSelected ] ].
]

{ #category : #visiting }
DSDataSourceItemCheckbox >> visitDSAnimatedGifScreenshot: aDSAnimatedGifScreenshot [ 
	| labelMorph rowMorph |
	labelMorph := StringMorph contents: aDSAnimatedGifScreenshot name.
	rowMorph := self table theme newRowIn: self for: {
		labelMorph.
		self newRecordingButtonFor: aDSAnimatedGifScreenshot }.
	^ self newCheckboxMorphFor: aDSAnimatedGifScreenshot labelMorph: rowMorph.
]

{ #category : #visiting }
DSDataSourceItemCheckbox >> visitDSClassSelection: aDSClassSelection [ 
	| labelMorph |
	labelMorph := self table theme newRowIn: self for: {
		(self classIconFor: aDSClassSelection) asMorph.
		(self classNameFor: aDSClassSelection) asMorph asReadOnlyMorph }.
	^ self newCheckboxMorphFor: aDSClassSelection labelMorph: labelMorph.
]

{ #category : #visiting }
DSDataSourceItemCheckbox >> visitDSMorphScreenshot: aDSMorphScreenshot [ 
	| labelMorph |
	labelMorph := (DSScreenshotCheckboxLabelMorph contents: aDSMorphScreenshot name)
			model: aDSMorphScreenshot;
			getTextSelector: #name;
			getFormSelector: #form;
			hResizing: #spaceFill; 
			vResizing: #shrinkWrap; 
			yourself.
	^ self newCheckboxMorphFor: aDSMorphScreenshot labelMorph: labelMorph.
]

{ #category : #visiting }
DSDataSourceItemCheckbox >> visitDSPackageSelection: aDSPackageSelection [ 
	| labelMorph checkbox rowMorph |
	labelMorph := (self packageNameFor: aDSPackageSelection) asMorph asReadOnlyMorph.
	rowMorph := self table theme newRowIn: self for: {
		(self packageIconFor: aDSPackageSelection) asMorph.
		labelMorph }.
	checkbox := self newCheckboxMorphFor: aDSPackageSelection labelMorph: rowMorph.
	aDSPackageSelection
		onSelectionChangedDo: [ :announcement | 
			labelMorph contents: (self packageNameFor: aDSPackageSelection) ].
	^ checkbox
]

{ #category : #visiting }
DSDataSourceItemCheckbox >> visitDSSendAttachmentsItem: aDSSendAttachmentsItem [ 
	| labelMorph |
	labelMorph := 'Attachments' asMorph asReadOnlyMorph.
	^ self newCheckboxMorphFor: aDSSendAttachmentsItem labelMorph: labelMorph
]

{ #category : #visiting }
DSDataSourceItemCheckbox >> visitDSSendCodeSnippetAttachment: aDSSendCodeSnippetAttachment [ 
	| labelMorph |
	labelMorph := 'Playground Code Snippet' asMorph asReadOnlyMorph.
	^ self newCheckboxMorphFor: aDSSendCodeSnippetAttachment labelMorph: labelMorph.
]

{ #category : #visiting }
DSDataSourceItemCheckbox >> visitDSSendPackagesAttachment: aDSSendPackagesAttachment [ 
	| labelMorph |
	labelMorph := 'Source code' asMorph asReadOnlyMorph.
	^ self newCheckboxMorphFor: aDSSendPackagesAttachment labelMorph: labelMorph
]

{ #category : #visiting }
DSDataSourceItemCheckbox >> visitDSSendScreenshotsAttachment: aDSSendScreenshotsAttachment [ 
	| rowMorph |
	rowMorph := self table theme newRowIn: self for: {
		'Screenshots' asMorph asReadOnlyMorph.
		self newAddWindowButtonFor: aDSSendScreenshotsAttachment.
		self newAddGifButtonFor: aDSSendScreenshotsAttachment }.
	^ self newCheckboxMorphFor: aDSSendScreenshotsAttachment labelMorph: rowMorph.
]

{ #category : #private }
DSDataSourceItemCheckbox >> withAllChildrenOf: aFTBasicItem [ 
	^ aFTBasicItem children
		inject: { aFTBasicItem }
		into: [ :all :each | all, (self withAllChildrenOf: each) ]
]
