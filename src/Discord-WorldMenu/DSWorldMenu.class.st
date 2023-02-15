Class {
	#name : #DSWorldMenu,
	#superclass : #Object,
	#category : 'Discord-WorldMenu'
}

{ #category : #'world menu' }
DSWorldMenu class >> communicationGroupOn: aBuilder [
	<worldMenu>
	(aBuilder item: #Collaboration)
		order: 1.1;
		target: self;
		iconName: #announcement
]

{ #category : #actions }
DSWorldMenu class >> updateDiscordSt [
	UIManager default
		informUserDuring: [ :bar | 
			bar label: 'Removing cached DiscordSt repository from github-cache'.
			bar current: 0.
			(FileLocator workingDirectory / 'github-cache' / 'JurajKubelka' / 'DiscordSt')
				ensureDeleteAll.
			bar label: 'Updating DiscordSt baseline definition'.
			bar current: 0.33.
			Iceberg enableMetacelloIntegration ifFalse: [ 
				Gofer new 
					url: 'github://JurajKubelka/DiscordSt/src' asZnUrl;
					package: 'BaselineOfDiscordSt';
					load ].
			bar label: 'Updating DiscordSt source files'.
			bar current: 0.66.
			Metacello new
				baseline: #DiscordSt;
				repository: 'github://JurajKubelka/DiscordSt/src';
				onConflict: [:ex | ex allow]; 
				load: #default.
			bar current: 1 ].
]

{ #category : #'world menu' }
DSWorldMenu class >> updateDiscordStOn: aBuilder [
	<worldMenu>
	(aBuilder item: #UpdateDiscordSt)
		order: 10;
		label: 'Update DiscordSt';
		icon:
			(self iconNamed: #glamorousRefresh);
		parent: #Collaboration;
		action: [ self updateDiscordSt ]
]
