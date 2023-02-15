"
A DSCompressDirectoryWithZipCommandTest is a test class for testing the behavior of DSCompressDirectoryWithZipCommand
"
Class {
	#name : #DSCompressDirectoryWithZipCommandTest,
	#superclass : #DSToolCommandTest,
	#instVars : [
		'zipFile',
		'rootDir'
	],
	#category : 'Discord-Tools-Tests-Commands'
}

{ #category : #'as yet unclassified' }
DSCompressDirectoryWithZipCommandTest >> assertChild: aFileReference inRoot: rootDirectory [ 

	aFileReference = rootDirectory ifTrue: [ ^ self ].

	aFileReference basename = 'dir1' ifTrue: [ ^ self ].
	aFileReference basename = 'dir2' ifTrue: [ ^ self ].

	aFileReference basename = 'file1.txt' ifTrue: [ 
		^ self assert: aFileReference contents equals: 'file 1 contents with ™' ].
	aFileReference basename = 'file2.txt' ifTrue: [ 
		^ self assert: aFileReference contents equals: 'file 2 contents' ].
	aFileReference basename = 'file3.txt' ifTrue: [ 
		^ self assert: aFileReference contents equals: 'file 3 contents' ].
	aFileReference basename = 'file4.txt' ifTrue: [ 
		^ self assert: aFileReference contents equals: 'file 4 contents' ].
	
	self assert: false description: [ 'Unknown file reference ', aFileReference asString ].

]

{ #category : #asserting }
DSCompressDirectoryWithZipCommandTest >> assertMembers: aCollection includesFileName: aString [ 
	self 
		assert: (aCollection anySatisfy: [ :eachMember | eachMember fileName = aString ])
		description: [ 'ZIP Members does not include "', aString asString, '"' ]
]

{ #category : #asserting }
DSCompressDirectoryWithZipCommandTest >> assertSubDirectories [
	| members extractedDir |
	self assert: zipFile exists description: 'ZIP file does NOT exist'.
	self assert: zipFile isFile description: 'ZIP file is NOT file'.
	self deny: zipFile size isZero description: 'ZIP file size is zero.'.
	self flag: 'ZipArchive isZipArchive: zipFile does not work on Pharo 7.0'.
	(Smalltalk version = 'Pharo7.0alpha') ifFalse: [ 
		self 
			assert: (ZipArchive isZipArchive: zipFile) 
			description: 'ZIP file is NOT ZIP Archive (', zipFile fullName, ', size=', zipFile size asString, ')' ].
	members :=  ZipArchive new 
						readFrom: zipFile;
						members.
	self assert: members size equals: 4.
	self assertMembers: members includesFileName: 'dir1/file1.txt'.
	self assertMembers: members includesFileName: 'dir1/file2.txt'.
	self assertMembers: members includesFileName: 'dir2/file3.txt'.
	self assertMembers: members includesFileName: 'dir2/file4.txt'.	
	extractedDir := rootDir / 'extracted-zip'.
	extractedDir createDirectory.
	ZipArchive new
		readFrom: zipFile;
		extractAllTo: extractedDir.
	self assert: extractedDir children size equals: 2.
	self assert: extractedDir allChildren size equals: 7.
	self assert: extractedDir children size equals: 2.
	extractedDir allChildren do: [ :eachChild |
		self assertChild: eachChild inRoot: extractedDir ].
]

{ #category : #running }
DSCompressDirectoryWithZipCommandTest >> classToTest [
	^ DSCompressDirectoryWithZipCommand
]

{ #category : #support }
DSCompressDirectoryWithZipCommandTest >> createDirectoryWithSubDirectories [
	"Return a directory that includes two subdirectories, each one two files."
	<return: #FileReference>
	| dir file mainDir |
	mainDir := (rootDir / 'mainDir') createDirectory.
	dir := (mainDir / 'dir1') createDirectory.
	file := dir / 'file1.txt'.
	file writeStreamDo: [ :stream | stream << 'file 1 contents with ™' ].
	file := dir / 'file2.txt'.
	file writeStreamDo: [ :stream | stream << 'file 2 contents' ].
	dir := (mainDir / 'dir2') createDirectory.
	file := dir / 'file3.txt'.
	file writeStreamDo: [ :stream | stream << 'file 3 contents' ].
	file := dir / 'file4.txt'.
	file writeStreamDo: [ :stream | stream << 'file 4 contents' ].
	^ mainDir
]

{ #category : #support }
DSCompressDirectoryWithZipCommandTest >> createDirectoryWithTwoFiles [
	"Return a directory that includes two files."
	<return: #FileReference>
	| fileSystem dir file1 file2 |
	fileSystem := FileSystem memory.
	dir := (fileSystem root / 'dir1') createDirectory.
	file1 := dir / 'file1.txt'.
	file1 writeStreamDo: [ :stream | stream << 'file 1 contents' ].
	file2 := dir / 'file2.txt'.
	file2 writeStreamDo: [ :stream | stream << 'file 2 contents' ].
	^ dir
]

{ #category : #running }
DSCompressDirectoryWithZipCommandTest >> setUp [
	super setUp.
	rootDir := FileReference newTempFilePrefix: 'discordst-' suffix: '-test-case-dir'.
	rootDir ensureCreateDirectory.
]

{ #category : #running }
DSCompressDirectoryWithZipCommandTest >> tearDown [
	super tearDown.
	zipFile ifNotNil: #ensureDelete.
	rootDir ensureDeleteAll 
]

{ #category : #tests }
DSCompressDirectoryWithZipCommandTest >> testZipFile [
	| command dir |
	command := self classToTest new.
	dir := self createDirectoryWithTwoFiles.
	command directory: dir.
	command zipFile: rootDir / 'archive.zip'.
	zipFile := command execute; zipFile.
	self assert: zipFile isFile.
	self assert: zipFile exists.
	self deny: zipFile size isZero.
]

{ #category : #tests }
DSCompressDirectoryWithZipCommandTest >> testZipFileInTempDirectory [
	| command dir |
	command := self classToTest new.
	dir := self createDirectoryWithTwoFiles.
	command directory: dir.
	command zipFileInTempDirectory.
	zipFile := command execute; zipFile.
	self assert: zipFile isFile.
	self assert: zipFile exists.
	self deny: zipFile size isZero.
]

{ #category : #tests }
DSCompressDirectoryWithZipCommandTest >> testZipFileSubdirs [
	| command dir |
	command := self classToTest new.
	dir := self createDirectoryWithSubDirectories.
	command directory: dir.
	command zipFile: rootDir / 'archive.zip'.
	zipFile := command execute; zipFile.
	self assertSubDirectories.
]
