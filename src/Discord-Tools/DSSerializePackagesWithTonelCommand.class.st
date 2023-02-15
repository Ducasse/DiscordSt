Class {
	#name : #DSSerializePackagesWithTonelCommand,
	#superclass : #DSToolCommand,
	#instVars : [
		'packages',
		'directory'
	],
	#category : 'Discord-Tools-Commands'
}

{ #category : #accessing }
DSSerializePackagesWithTonelCommand >> directory [
	^ directory
]

{ #category : #accessing }
DSSerializePackagesWithTonelCommand >> directory: anObject [
	directory := anObject
]

{ #category : #execute }
DSSerializePackagesWithTonelCommand >> execute [
	| command |
	command := DSSerializePackageWithTonelCommand new.
	self packages do: [ :eachPackage | 
		command package: eachPackage.
		command execute ].
	self directory: command directory.
]

{ #category : #accessing }
DSSerializePackagesWithTonelCommand >> packages [
	^ packages
]

{ #category : #accessing }
DSSerializePackagesWithTonelCommand >> packages: anObject [
	packages := anObject
]

{ #category : #accessing }
DSSerializePackagesWithTonelCommand >> zipFile [
	^ DSCompressDirectoryWithZipCommand new
		directory: self directory;
		zipFileInTempDirectory;
		execute;
		zipFile
]
