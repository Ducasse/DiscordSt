"
I am a baseline for DiscordSt library.
"
Class {
	#name : #BaselineOfDiscordSt,
	#superclass : #BaselineOf,
	#category : 'BaselineOfDiscordSt'
}

{ #category : #baseline }
BaselineOfDiscordSt >> baseline: spec [
	<baseline>
	self externalProjects: spec.
	self corePackages: spec.
	self brickPackages: spec.
	self integrationPackages: spec.
	self researchPackages: spec.
	self downloaderPackages: spec.
	self groups: spec.
]

{ #category : #private }
BaselineOfDiscordSt >> brickPackages: spec [
	spec for: #'common' do: [
		spec
			package: #'Discord-UI-Brick' with: [ 
				spec requires: #( #'Discord-Core' ) ]
	].
	
	spec for: #'notGToolkit' do: [
		spec
			package: #'Discord-UI-Brick' with: [ 
				spec requires: #( #'Brick' ) ]
	].
]

{ #category : #private }
BaselineOfDiscordSt >> corePackages: spec [
	spec for: #'common' do: [
		spec
			package: #'Discord-WorldMenu';
			package: #'Discord-Announcements';

			package: #'Discord-Core' with: [
				spec requires: #( #'NeoJSON' #'ExternalVolatileStore' ). ];
			package: #'Discord-Core-Tests' with: [
				spec requires: #( #'Discord-Core' ). ];

			package: #'Discord-WebhookClient' with: [
				spec requires: #( #'Discord-Core' ). ];
			package: #'Discord-WebhookClient-Tests' with: [
				spec requires: #( #'Discord-WebhookClient' #'Discord-Core-Tests' ). ];

			package: #'Discord-Client' with: [
				spec requires: #( 
					#'Discord-Announcements' #'Discord-Core' #'Discord-Gateway' #'ExternalVolatileStore' ). ];
			package: #'Discord-Client-Tests' with: [
				spec requires: #( #'Discord-Client' #'Discord-Core-Tests' #'Discord-Gateway-Tests' ). ];

			package: #'Discord-Gateway' with: [
				spec requires: #( #'Discord-Announcements' #'Discord-Core'). ];
			package: #'Discord-Gateway-Tests' with: [
				spec requires: #( #'Discord-Gateway' #'Discord-Core-Tests' ). ]
	].
]

{ #category : #accessing }
BaselineOfDiscordSt >> customProjectAttributes [

	^ self isGTImage
			ifTrue: [ #(GToolkit) ]
			ifFalse: [ #(notGToolkit) ].
			
	"This is just for code generation purposes. To have an effect, it needs to be on the instance-side, but that could hide problems in other baselines because DeNigrisPreferences is not guaranteed to be loaded"
]

{ #category : #private }
BaselineOfDiscordSt >> downloaderPackages: spec [
	spec for: #'common' do: [
		spec			
			package: #'Discord-Downloader' with: [ 
				spec requires: #( 
					#'Discord-Core' #'Discord-Integration-Core' 
					#'Discord-Send-Items' #'Discord-Integration-Playground' ) ];
			
			package: #'Discord-Downloader-Tests' with: [ 
				spec requires: #( #'Discord-Downloader' #'Discord-Core-Tests' ) ]
	].
]

{ #category : #private }
BaselineOfDiscordSt >> externalProjects: spec [
	spec for: #'common' do: [
		spec    
			baseline: 'NeoJSON' with: [
				spec repository: 'github://svenvc/NeoJSON:master/repository' ];
			baseline: 'ExternalVolatileStore' with: [ 
				spec
					repository: 'github://feenkcom/external-volatile-store/src';
					loads: #minimal ]
	].
	
	spec for: #'notGToolkit' do: [
		spec
			baseline: 'Brick' with: [ 
				spec
					repository: 'github://pharo-graphics/Brick/src';
					loads: #default ]
	].
	
	spec for: #'pharo6.x' do: [
		spec
			configuration: 'ZincHTTPComponents' with: [ 
				spec
					repository: 'http://smalltalkhub.com/mc/SvenVanCaekenberghe/ZincHTTPComponents/main/';
					versionString: #stable;
					loads: 'WebSocket' ] 
	].
	spec for: #'pharo7.x' do: [
		spec
			configuration: 'ZincHTTPComponents' with: [ 
				spec
					repository: 'http://smalltalkhub.com/mc/SvenVanCaekenberghe/ZincHTTPComponents/main/';
					versionString: #bleedingEdge;
					loads: 'WebSocket' ]
	].

	spec for: #'pharo9.x' do: [
		spec
			configuration: 'ZincHTTPComponents' with: [ 
				spec
					repository: 'github://svenvc/zinc/repository';
					versionString: #bleedingEdge;
					loads: 'WebSocket' ]
	].
]

{ #category : #private }
BaselineOfDiscordSt >> groups: spec [
	spec for: #'common' do: [
		spec			
			"Webhook"
			group: #'src-webhook' with: #( #'Discord-WebhookClient' );
			group: #'tests-webhook' with: #( #'Discord-WebhookClient-Tests' );
			group: #'webhook' with: #( #'src-webhook' #'tests-webhook' );
			
			"Bot App and User Client"
			group: #'src-client' with: #( #'Discord-Client' );
			group: #'tests-client' with: #( #'Discord-Client-Tests' );
			group: #'client' with: #( #'src-client' #'tests-client' );
			
			"core"
			group: #'src-core' with: #( #'src-webhook' #'src-client' );
			group: #'tests-core' with: #( #'tests-webhook' #'tests-client' );
			group: #'core' with: #( #'src-core' #'tests-core' );

			"world menu"
			group: #'ui-worldmenu' with: #( #'Discord-WorldMenu' );

			"Downloader"
			group: #'src-downloader' with: #( #'Discord-Downloader' #'Discord-Research' );

			"Integration - UI - Morphic" 
			group: #'integration-rubric' with: #( #'Discord-Integration-Rubric' #'Discord-Research' );
			group: #'integration-calypso' with: #( #'Discord-Integration-Calypso' #'Discord-Research' );
			group: #'integration-playground' with: #( 
				#'Discord-Integration-Playground' #'Discord-Research' );
			group: #'src-ui-morphic' with: (self mayRequireCalypso: spec);
			group: #'tests-ui-morphic' with: #( 
				#'src-ui-morphic'
				#'tests-core'
				#'Discord-Tools-Tests'
				#'Discord-Downloader-Tests' #'Discord-Integration-Morph-Tests'
				#'Discord-Send-Items-Tests' #'Discord-Registry-Core-Tests' );
			group: #'ui-morphic' with: #( #'src-ui-morphic' #'tests-ui-morphic' );

			"UI - Brick"
			group: #'src-ui-brick' with: #( #'Discord-UI-Brick' );
			group: #'tests-ui-brick' with: #( #'src-ui-brick' );
			group: #'ui-brick' with: #( #'src-ui-brick' #'tests-ui-brick' );
			
			"light options (no Bloc/Brick)"
			group: #'src-light' with: #( 
				#'src-core' #'src-ui-morphic' #'src-downloader' );
			group: #'tests-light' with: #( 
				#'tests-core' #'tests-ui-morphic' );
			group: #'light' with: #( #'src-light' #'tests-light' );
			
			"full (all packages including Bloc/Brick) options"
			group: #'src-full' with: #( #'src-light' #'src-ui-brick' #'src-downloader' );
			group: #'tests-full' with: #( #'tests-light' );
			group: #'full' with: #( #'src-full' #'tests-full' );
			
			"default"
			group: #'default' with: #( #'light' #'tests' );
			group: #'tests' with: #( #'tests-light' );

			"all - without legacy code"
			group: #'all' with: #( #'full' #'tests-full' )
	].
]

{ #category : #private }
BaselineOfDiscordSt >> integrationPackages: spec [
	spec for: #'common' do: [
		spec
			package: #'Discord-Tools' with: [
				"It depends on GT-Inspector and GT-Playground that are standard tools"
				spec 
					preLoadDoIt: #preLoadTonel:;
					requires: #( #'Discord-Core' ) ];
			package: #'Discord-Tools-Tests' with: [
				spec requires: #( #'Discord-Tools' ) ];

			package: #'Discord-Mock' with: [ 
				spec requires: #( #'Discord-Announcements' #'Discord-Core' ) ];
			
			package: #'Discord-Registry-Core' with: [ 
				spec requires: #( 
					#'Discord-Core' #'Discord-Client' #'Discord-Mock' ) ];
			
			package: #'Discord-Registry-Core-Tests' with: [ 
				spec requires: #( #'Discord-Registry-Core' ) ];

			package: #'Discord-Send-Items' with: [ 
				spec requires: #( 
					#'Discord-Registry-Core' #'Discord-Tools' #'Discord-WebhookClient' ) ];

			package: #'Discord-Send-Items-Tests' with: [ 
				spec requires: #( #'Discord-Send-Items' ) ];

			package: #'Discord-Integration-Core' with: [ 
				spec requires: #( 
					#'Discord-Core' #'Discord-Registry-Core' ) ];
			
			package: #'Discord-Integration-Morph' with: [ 
				spec requires: #( 
					#'Discord-Announcements' #'Discord-Mock' #'Discord-Registry-Core' 
					#'Discord-Send-Items' #'Discord-Tools' ) ];
			
			package: #'Discord-Integration-Gif' with: [ 
				spec requires: #( #'Discord-Send-Items' #'Discord-Integration-Morph' ) ];

			package: #'Discord-Integration-Morph-Tests' with: [ 
				spec requires: #( #'Discord-Integration-Morph' ) ];

			package: #'Discord-Integration-Rubric' with: [ 
				spec requires: #( 
					#'Discord-Core' 
					#'Discord-Integration-Core' 
					#'Discord-Integration-Morph'
					#'Discord-Integration-Gif' ) ];
			
			package: #'Discord-Integration-Playground' with: [ 
				spec
					preLoadDoIt: #preLoadPlayground:;
					requires: #( 
						#'Discord-Core' #'Discord-Integration-Core' 
						#'Discord-Integration-Morph' 
						#'Discord-Integration-Gif'
						#'Discord-Send-Items' #'Discord-Tools' ) ];

			package: #'Discord-Integration-Calypso' with: [ 
				spec
					requires: #( 
						#'Discord-Core' #'Discord-Integration-Core' 
						#'Discord-Integration-Morph' 
						#'Discord-Integration-Gif'
						#'Discord-Send-Items' #'Discord-Tools'
						#'Discord-Integration-Rubric' ) ]
	].
]

{ #category : #testing }
BaselineOfDiscordSt >> isGTImage [
	
	^ RPackageOrganizer default packageNames anySatisfy: [ :pn | pn beginsWith: 'Lepiter-' ].
	"Implementation note: used to check for GToolkit prefix, but P7 has a GToolkit-Examples package. Lepiter, OTOH, could only be loaded in a GT image"
]

{ #category : #actions }
BaselineOfDiscordSt >> mayRequireCalypso: aSpecLoader [
	"Load a patch to be able to extend GT-Playground with actions."

	| requirements |
	SystemVersion current highestUpdate > 60000
		ifFalse: [ ^ self ].
	requirements := #(#'integration-rubric' #'integration-playground' #'ui-worldmenu').
	self class environment
		at: #ClyBrowser
		ifPresent: [ requirements := requirements copyWith: #'integration-calypso' ].
	^ requirements
]

{ #category : #actions }
BaselineOfDiscordSt >> preLoadPlayground: aSpecLoader [
	"Load a patch to be able to extend GT-Playground with actions."

	| playgroundClass |
	SystemVersion current highestUpdate > 60000
		ifFalse: [ ^ self ].
	SystemVersion current highestUpdate < 70000
		ifFalse: [ ^ self ].
	playgroundClass := self class environment
		at: #GTPlayground
		ifAbsent: [ ^ self ].
	(playgroundClass canUnderstand: #playgroundActions)
		ifTrue: [ ^ self ].
	Gofer it
		smalltalkhubUser: 'Moose' project: 'GToolkit';
		package: 'GT-Playground';
		package: 'GT-Tests-Playground';
		load
]

{ #category : #actions }
BaselineOfDiscordSt >> preLoadTonel: aSpecLoader [
	"Load the Tonel project if not present. Useful for Pharo 6.0, exluding Pharo 6.1"
	SystemVersion current highestUpdate > 60000 ifFalse: [ ^ self ].
	#TonelWriter asClassIfPresent: [ ^ self ].
	Metacello new 
		repository: 'github://pharo-vcs/tonel';
		baseline: 'Tonel';
		load.
]

{ #category : #accessing }
BaselineOfDiscordSt >> projectClass [
   ^ Smalltalk 
		at: #'MetacelloCypressBaselineProject' 
		ifAbsent: [ super projectClass ]
]

{ #category : #private }
BaselineOfDiscordSt >> researchPackages: spec [
	spec for: #'common' do: [
		spec
			package: #'Discord-Research' with: [ 
				spec requires: #( 
					#'Discord-Downloader'
					#'Discord-WebhookClient'
					#'Discord-Send-Items'
					#'Discord-Registry-Core' ) ]
	].
]
