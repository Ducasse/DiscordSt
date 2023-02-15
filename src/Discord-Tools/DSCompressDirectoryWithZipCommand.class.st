"
I compress a given directory to a given zip file. 
I use ZIPArchive object to compress files.
Currently, I compress only files.
I cooperate with DSSerializePackageWithTonelCommand.
"
Class {
	#name : #DSCompressDirectoryWithZipCommand,
	#superclass : #DSToolCommand,
	#instVars : [
		'directory',
		'zipFile'
	],
	#category : 'Discord-Tools-Commands'
}

{ #category : #accessing }
DSCompressDirectoryWithZipCommand >> directory [
	^ directory
]

{ #category : #accessing }
DSCompressDirectoryWithZipCommand >> directory: anObject [
	directory := anObject
]

{ #category : #execute }
DSCompressDirectoryWithZipCommand >> execute [
	| zip files directoryFullName |
	zip := ZipArchive new.
	directoryFullName := self directory fullName size.
	files := self directory allChildren select: [ :eachChildren | eachChildren isFile ].
	files do: [ :eachFile | | member fileName | 
		fileName := eachFile fullName allButFirst: directoryFullName.
		member := zip addString: eachFile contents utf8Encoded as: fileName.
		member desiredCompressionMethod: ZipArchive compressionDeflated ].
	self zipFile ensureDelete.
	self zipFile writeStreamDo: [ :aStream |
		zip writeTo: aStream ].
]

{ #category : #accessing }
DSCompressDirectoryWithZipCommand >> zipFile [
	^ zipFile
]

{ #category : #accessing }
DSCompressDirectoryWithZipCommand >> zipFile: anObject [
	zipFile := anObject
]

{ #category : #accessing }
DSCompressDirectoryWithZipCommand >> zipFileInDirectory: aFileLocator [ 
	"Define any random and unique ZIP file name that should be located in the given directory."
	| existingFileNames |
	self assert: [ aFileLocator isDirectory ] description: 'Parameter should be a directory'.
	self assert: [ aFileLocator exists ] description: 'Parameter should be an existing directory'.
	existingFileNames := (aFileLocator directoriesMatching: '*.zip') collect: #basename.
	self zipFile: aFileLocator / (DSGenerateFileNameCommand new 
			extension: '.zip';
			existingFileNames: existingFileNames;
			execute;
			fileName).
]

{ #category : #initialization }
DSCompressDirectoryWithZipCommand >> zipFileInTempDirectory [
	"Define any random and unique ZIP file name that should be located in the temporary directory."
	self zipFileInDirectory: FileLocator temp
]
