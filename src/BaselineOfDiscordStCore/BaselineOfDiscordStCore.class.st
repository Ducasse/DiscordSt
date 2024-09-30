Class {
	#name : 'BaselineOfDiscordStCore',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfDiscordStCore',
	#package : 'BaselineOfDiscordStCore'
}

{ #category : 'baseline' }
BaselineOfDiscordStCore >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec
			baseline: 'ZincHTTPComponents'
			with: [ spec
				loads: #('WebSocket');
				repository: 'github://svenvc/zinc:v5/repository' ].
		
		spec
			baseline: 'ExternalVolatileStore' with: [ 
				spec
					repository: 'github://feenkcom/external-volatile-store/src';
					loads: #minimal ];
			baseline: 'NeoJSON' with: [
				spec repository: 'github://svenvc/NeoJSON:master/repository' ];
			package: #'Discord-Core' with: [
				spec requires: #( #'NeoJSON' #'ExternalVolatileStore' ). ];
			package: #'Discord-Core-Tests' with: [
				spec requires: #( #'Discord-Core' ). ]
	]
]
