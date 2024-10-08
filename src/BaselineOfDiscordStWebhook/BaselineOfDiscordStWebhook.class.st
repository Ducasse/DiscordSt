Class {
	#name : 'BaselineOfDiscordStWebhook',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfDiscordStWebhook',
	#package : 'BaselineOfDiscordStWebhook'
}

{ #category : 'baseline' }
BaselineOfDiscordStWebhook >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec
			baseline: 'DiscordStCore' with: [
				spec repository: 'github://Ducasse/DiscordSt/src' ];

			package: #'Discord-WebhookClient' with: [
				spec requires: #( #'DiscordStCore' ). ];
			package: #'Discord-WebhookClient-Tests' with: [
				spec requires: #( #'Discord-WebhookClient' ) ]
	]
]
