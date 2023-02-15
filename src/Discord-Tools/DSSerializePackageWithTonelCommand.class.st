"
I serialize a package (RPackage) using Tonel library.
By sending me #directory message, I return a directory where the given package is stored.
I am useful for exchanging source code among users as the source code can be serialized (ZIP archive) and send to a user.
To obtain the ZIP archive, send me #zipFile message.
"
Class {
	#name : #DSSerializePackageWithTonelCommand,
	#superclass : #DSToolCommand,
	#instVars : [
		'package',
		'fileSystem',
		'directory',
		'rootDirectory'
	],
	#category : 'Discord-Tools-Commands'
}

{ #category : #accessing }
DSSerializePackageWithTonelCommand >> directory [
	^ directory
]

{ #category : #accessing }
DSSerializePackageWithTonelCommand >> directory: anObject [
	directory := anObject
]

{ #category : #execute }
DSSerializePackageWithTonelCommand >> execute [
	| repository mcPackage workingCopy newVersion |
	repository := TonelRepository new directory: rootDirectory.
	mcPackage := MCPackage named: self package name.
	workingCopy := MCWorkingCopy forPackage: mcPackage.
	newVersion := workingCopy
		newVersionWithName: (workingCopy uniqueVersionNameIn: repository) 
		message: self message 
		in: repository.
	repository storeVersion: newVersion.
	repository storeDependencies: newVersion.
	self directory: repository directory.
]

{ #category : #accessing }
DSSerializePackageWithTonelCommand >> initialize [
	super initialize.
	fileSystem := FileSystem disk.
	rootDirectory := self uniqueRootDirectory.
	rootDirectory ensureCreateDirectory.
]

{ #category : #accessing }
DSSerializePackageWithTonelCommand >> message [
	^ 'automatic message'
]

{ #category : #accessing }
DSSerializePackageWithTonelCommand >> package [
	^ package
]

{ #category : #accessing }
DSSerializePackageWithTonelCommand >> package: anObject [
	package := anObject
]

{ #category : #private }
DSSerializePackageWithTonelCommand >> uniqueRootDirectory [
	| existingFileNames |
	existingFileNames := (FileLocator temp children) collect: #basename.
	^ FileLocator temp / (DSGenerateFileNameCommand new 
			extension: '';
			existingFileNames: existingFileNames;
			execute;
			fileName).
]

{ #category : #accessing }
DSSerializePackageWithTonelCommand >> zipFile [
	^ DSCompressDirectoryWithZipCommand new
		directory: self directory;
		zipFileInTempDirectory;
		execute;
		zipFile
]
