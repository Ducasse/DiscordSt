Class {
	#name : 'BaselineOfDiscordStGateway',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfDiscordStGateway',
	#package : 'BaselineOfDiscordStGateway'
}

{ #category : 'baseline' }
BaselineOfDiscordStGateway >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec
			baseline: 'DiscordStCore' with: [
				spec repository: 'github://Ducasse/DiscordSt/src' ].
			spec
				baseline: 'ZincHTTPComponents'
			with: [ spec
				loads: #('WebSocket');
				repository: 'github://svenvc/zinc:v5/repository' ].

		spec 
			package: #'Discord-Announcements';
			package: #'Discord-Gateway' with: [
				spec requires: #( #'Discord-Announcements' #DiscordStCore #'ZincHTTPComponents' ). ];
			package: #'Discord-Gateway-Tests' with: [
				spec requires: #( #'Discord-Gateway' ) ]
	]
]
