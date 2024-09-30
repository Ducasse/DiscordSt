"
A DSModelJsonMappingTest is a test class for testing the behavior of DSModelJsonMapping
"
Class {
	#name : 'DSModelJsonMappingTest',
	#superclass : 'TestCase',
	#category : 'Discord-Core-Tests-Utility',
	#package : 'Discord-Core-Tests',
	#tag : 'Utility'
}

{ #category : 'running' }
DSModelJsonMappingTest >> classToTest [
	^ DSModelJsonMapping
]

{ #category : 'utility' }
DSModelJsonMappingTest >> read: jsonString as: schema mappedTo: mappingMessage [
	"Return an object that is represented by the JSON string."
	<return: #DSObject>
	^ self classToTest read: schema withMapping: mappingMessage on: jsonString readStream
]

{ #category : 'tests - message' }
DSModelJsonMappingTest >> testAttachmentMappingFor [
	| result jsonResult jsonString |
	jsonString := self classToTest jsonAttachment.
	result := self read: jsonString as: DSAttachment mappedTo: #attachmentMappingFor:.
	self assert: result class equals: DSAttachment.
	self assert: result id equals: '376014041878912856'.
	self assert: result filename equals: 'file.jpg'.
	self assert: result fileSize equals: 32143.
	self assert: result url equals: 'http://cdn.example.com/attachment.jpg'.
	self assert: result proxyUrl equals: 'http://proxy.example.com/attachment.jpg'.
	self assert: result height equals: 512.
	self assert: result width equals: 768.
	jsonResult := self write: result mappedTo: #attachmentMappingFor:.
	self assert: jsonResult equals: jsonString.
]

{ #category : 'tests - channel' }
DSModelJsonMappingTest >> testChannelTypeMappingFor [
	| result jsonResult jsonString |
	jsonString := '0'.
	result := self read: jsonString as: DSChannelType mappedTo: #channelTypeMappingFor:.
	self assert: result class equals: DSChannelGuildTextType.
	jsonResult := self write: result mappedTo: #channelTypeMappingFor:.
	self assert: jsonResult equals: jsonString.
]

{ #category : 'tests - message' }
DSModelJsonMappingTest >> testCollectionOfAttachmentsMappingFor [
	| result jsonResult jsonString |
	jsonString := self classToTest jsonCollectionOfAttachmentsOne.
	result := self read: jsonString as: #CollectionOfAttachments mappedTo: #collectionOfAttachmentsMappingFor:.
	self assert: result class equals: Array.
	self assert: result size equals: 1.
	self assert: result first class equals: DSAttachment.
	jsonResult := self write: result mappedTo: #collectionOfAttachmentsMappingFor:.
	self assert: jsonResult equals: jsonString.
]

{ #category : 'tests - message' }
DSModelJsonMappingTest >> testCollectionOfEmbedsMappingFor [
	| result jsonResult jsonString |
	jsonString := self classToTest jsonCollectionOfEmbedsOne.
	result := self read: jsonString as: #CollectionOfEmbeds mappedTo: #collectionOfEmbedsMappingFor:.
	self assert: result class equals: Array.
	self assert: result size equals: 1.
	self assert: result first class equals: DSEmbed.
	jsonResult := self write: result mappedTo: #collectionOfEmbedsMappingFor:.
	self assert: jsonResult equals: jsonString.
]

{ #category : 'tests - message' }
DSModelJsonMappingTest >> testCollectionOfEmojisMappingFor [
	| result jsonResult jsonString |
	jsonString := self classToTest jsonCollectionOfEmojisOne.
	result := self read: jsonString as: #CollectionOfEmojis mappedTo: #collectionOfEmojisMappingFor:.
	self assert: result class equals: Array.
	self assert: result size equals: 1.
	self assert: result first class equals: DSEmoji.
	jsonResult := self write: result mappedTo: #collectionOfEmojisMappingFor:.
	self assert: jsonResult equals: jsonString.
]

{ #category : 'tests - embed' }
DSModelJsonMappingTest >> testCollectionOfFieldsMappingFor [
	| result jsonResult jsonString |
	jsonString := self classToTest jsonEmbedFieldsOne.
	result := self read: jsonString as: #CollectionOfFields mappedTo: #collectionOfFieldsMappingFor:.
	self assert: result class equals: Array.
	self assert: result size equals: 1.
	self assert: result first class equals: DSEmbedField.
	jsonResult := self write: result mappedTo: #collectionOfFieldsMappingFor:.
	self assert: jsonResult equals: jsonString.
]

{ #category : 'tests - embed' }
DSModelJsonMappingTest >> testCollectionOfFieldsMappingForTwo [
	| result jsonResult jsonString |
	jsonString := self classToTest jsonEmbedFieldsTwo.
	result := self read: jsonString as: #CollectionOfFields mappedTo: #collectionOfFieldsMappingFor:.
	self assert: result class equals: Array.
	self assert: result size equals: 2.
	self assert: result first class equals: DSEmbedField.
	self assert: result second class equals: DSEmbedField.
	jsonResult := self write: result mappedTo: #collectionOfFieldsMappingFor:.
	self assert: jsonResult equals: jsonString.
]

{ #category : 'tests - message' }
DSModelJsonMappingTest >> testCollectionOfGuildMembersMappingFor [
	| result jsonResult jsonString |
	jsonString := self classToTest jsonCollectionOfGuildMembersOne.
	result := self read: jsonString as: #CollectionOfGuildMembers mappedTo: #collectionOfGuildMembersMappingFor:.
	self assert: result class equals: DSGuildMembers.
	self assert: result size equals: 1.
	self assert: result first class equals: DSGuildMember.
	jsonResult := self write: result mappedTo: #collectionOfGuildMembersMappingFor:.
	self assert: jsonResult equals: jsonString.
]

{ #category : 'tests - guild' }
DSModelJsonMappingTest >> testCollectionOfGuildsMappingFor [
	| result jsonString jsonResult |
	jsonString := self classToTest jsonCollectionOfGuildsOne.
	result := self read: jsonString as: #CollectionOfGuilds mappedTo: #collectionOfGuildsMappingFor:.
	self assert: result class equals: DSGuilds.
	self assert: result size equals: 1.
	self assert: result first class equals: DSGuild.
	jsonResult := self write: result mappedTo: #collectionOfGuildsMappingFor:.
	self assert: jsonResult equals: jsonString.
]

{ #category : 'tests - message' }
DSModelJsonMappingTest >> testCollectionOfMessagesMappingFor [
	| result jsonResult jsonString |
	jsonString := self classToTest jsonCollectionOfMessagesOne.
	result := self read: jsonString as: #CollectionOfMessages mappedTo: #collectionOfMessagesMappingFor:.
	self assert: result class equals: DSMessages.
	self assert: result size equals: 1.
	self assert: result first class equals: DSMessage.
	jsonResult := self write: result mappedTo: #collectionOfMessagesMappingFor:.
	self assert: jsonResult equals: jsonString.
]

{ #category : 'tests - channel' }
DSModelJsonMappingTest >> testCollectionOfOverwritesMappingFor [
	| result jsonResult jsonString |
	jsonString := self classToTest jsonCollectionOfOverwritesOne.
	result := self read: jsonString as: #CollectionOfOverwrites mappedTo: #collectionOfOverwritesMappingFor:.
	self assert: result class equals: Array.
	self assert: result size equals: 1.
	self assert: result first class equals: DSOverwrite.
	jsonResult := self write: result mappedTo: #collectionOfOverwritesMappingFor:.
	self assert: jsonResult equals: jsonString.
]

{ #category : 'tests - message' }
DSModelJsonMappingTest >> testCollectionOfPresenceUpdatesMappingFor [
	| result jsonResult jsonString |
	jsonString := self classToTest jsonCollectionOfPresenceUpdatesOne.
	result := self read: jsonString as: #CollectionOfPresenceUpdates mappedTo: #collectionOfPresenceUpdatesMappingFor:.
	self assert: result class equals: Array.
	self assert: result size equals: 1.
	self assert: result first class equals: DSPresenceUpdate.
	jsonResult := self write: result mappedTo: #collectionOfPresenceUpdatesMappingFor:.
	self assert: jsonResult equals: jsonString.
]

{ #category : 'tests - message' }
DSModelJsonMappingTest >> testCollectionOfReactionsMappingFor [
	| result jsonResult jsonString |
	jsonString := self classToTest jsonCollectionOfReactionsOne.
	result := self read: jsonString as: #CollectionOfReactions mappedTo: #collectionOfReactionsMappingFor:.
	self assert: result class equals: Array.
	self assert: result size equals: 1.
	self assert: result first class equals: DSReaction.
	jsonResult := self write: result mappedTo: #collectionOfReactionsMappingFor:.
	self assert: jsonResult equals: jsonString.
]

{ #category : 'tests - message' }
DSModelJsonMappingTest >> testCollectionOfRolesMappingFor [
	| result jsonResult jsonString |
	jsonString := self classToTest jsonCollectionOfRolesOne.
	result := self read: jsonString as: #CollectionOfRoles mappedTo: #collectionOfRolesMappingFor:.
	self assert: result class equals: Array.
	self assert: result size equals: 1.
	self assert: result first class equals: DSRole.
	jsonResult := self write: result mappedTo: #collectionOfRolesMappingFor:.
	self assert: jsonResult equals: jsonString.
]

{ #category : 'tests - channel' }
DSModelJsonMappingTest >> testCollectionOfSortedChannelsMappingFor [
	| result jsonString jsonResult |
	jsonString := self classToTest jsonCollectionOfChannelsThree.
	result := self read: jsonString as: #CollectionOfSortedChannels mappedTo: #collectionOfSortedChannelsMappingFor:.
	self assert: result class equals: DSChannels.
	self assert: result size equals: 1.
	self assert: result first class equals: DSCategoryChannel.
	self assert: result first subordinateChannels size equals: 2.
	self assert: result first subordinateChannels first class equals: DSGuildVoiceChannel.
	self assert: result first subordinateChannels second class equals: DSGuildTextChannel.
	jsonResult := self write: result mappedTo: #collectionOfSortedChannelsMappingFor:.
	self assert: jsonResult equals: jsonString.
]

{ #category : 'tests - channel' }
DSModelJsonMappingTest >> testCollectionOfSortedChannelsMappingFor2 [
	| result jsonString jsonResult |
	jsonString := self classToTest jsonCollectionOfChannelsThree.
	result := self read: jsonString as: #CollectionOfSortedChannels mappedTo: #collectionOfSortedChannelsMappingFor:.
	self assert: result class equals: DSChannels.
	self assert: result size equals: 1.
	self assert: result first class equals: DSCategoryChannel.
	self assert: result first subordinateChannels size equals: 2.
	self assert: result first subordinateChannels first class equals: DSGuildVoiceChannel.
	self assert: result first subordinateChannels second class equals: DSGuildTextChannel.
	jsonResult := self 
		write: result 
		as: #CollectionOfSortedChannels 
		mappedTo: #collectionOfSortedChannelsMappingFor:.
	self assert: jsonResult equals: jsonString.
]

{ #category : 'tests - channel' }
DSModelJsonMappingTest >> testCollectionOfSpecifiedChannelsMappingFor [
	| result jsonResult jsonString |
	jsonString := self classToTest jsonCollectionOfChannelsTwo.
	result := self read: jsonString as: #CollectionOfSpecifiedChannels mappedTo: #collectionOfSpecifiedChannelsMappingFor:.
	self assert: result class equals: DSChannels.
	self assert: result size equals: 2.
	self assert: result first class equals: DSGuildTextChannel.
	self assert: result second class equals: DSGuildVoiceChannel.
	jsonResult := self write: result mappedTo: #collectionOfSpecifiedChannelsMappingFor:.
	self assert: jsonResult equals: jsonString.
]

{ #category : 'tests - channel' }
DSModelJsonMappingTest >> testCollectionOfUnspecifiedChannelsMappingFor [
	| result jsonResult jsonString |
	jsonString := self classToTest jsonCollectionOfChannelsOne.
	result := self read: jsonString as: #CollectionOfUnspecifiedChannels mappedTo: #collectionOfUnspecifiedChannelsMappingFor:.
	self assert: result class equals: DSChannels.
	self assert: result size equals: 1.
	self assert: result first class equals: DSUnspecifiedChannel.
	jsonResult := self write: result mappedTo: #collectionOfUnspecifiedChannelsMappingFor:.
	self assert: jsonResult equals: jsonString.
]

{ #category : 'tests - message' }
DSModelJsonMappingTest >> testCollectionOfUsersMappingFor [
	| result jsonResult jsonString |
	jsonString := self classToTest jsonCollectionOfUsersOne.
	result := self read: jsonString as: #CollectionOfUsers mappedTo: #collectionOfUsersMappingFor:.
	self assert: result class equals: Array.
	self assert: result size equals: 1.
	self assert: result first class equals: DSUser.
	jsonResult := self write: result mappedTo: #collectionOfUsersMappingFor:.
	self assert: jsonResult equals: jsonString.
]

{ #category : 'tests - message' }
DSModelJsonMappingTest >> testCollectionOfVoiceStatesMappingFor [
	| result jsonResult jsonString |
	jsonString := self classToTest jsonCollectionOfVoiceStatesOne.
	result := self read: jsonString as: #CollectionOfVoiceStates mappedTo: #collectionOfVoiceStatesMappingFor:.
	self assert: result class equals: Array.
	self assert: result size equals: 1.
	self assert: result first class equals: DSVoiceState.
	jsonResult := self write: result mappedTo: #collectionOfVoiceStatesMappingFor:.
	self assert: jsonResult equals: jsonString.
]

{ #category : 'tests - basic' }
DSModelJsonMappingTest >> testColorMappingFor [
	| result jsonResult jsonString |
	jsonString := '16711680'.
	result := self read: jsonString as: Color mappedTo: #colorMappingFor:.
	self assert: result class equals: Color.
	self assert: result equals: Color red.
	jsonResult := self write: result mappedTo: #colorMappingFor:.
	self assert: jsonResult equals: jsonString.
]

{ #category : 'tests - basic' }
DSModelJsonMappingTest >> testColorMappingForBlue [
	| result jsonResult jsonString |
	jsonString := '255'.
	result := self read: jsonString as: Color mappedTo: #colorMappingFor:.
	self assert: result class equals: Color.
	self assert: result equals: Color blue.
	jsonResult := self write: result mappedTo: #colorMappingFor:.
	self assert: jsonResult equals: jsonString.
]

{ #category : 'tests - basic' }
DSModelJsonMappingTest >> testColorMappingForGreen [
	| result jsonResult jsonString |
	jsonString := '65280'.
	result := self read: jsonString as: Color mappedTo: #colorMappingFor:.
	self assert: result class equals: Color.
	self assert: result equals: Color green.
	jsonResult := self write: result mappedTo: #colorMappingFor:.
	self assert: jsonResult equals: jsonString.
]

{ #category : 'tests - guild' }
DSModelJsonMappingTest >> testConnectionStatusMappingFor [
	| result jsonResult jsonString |
	jsonString := '"idle"'.
	result := self read: jsonString as: DSConnectionStatus mappedTo: #connectionStatusMappingFor:.
	self assert: result class equals: DSIdleStatus.
	jsonResult := self write: result mappedTo: #connectionStatusMappingFor:.
	self assert: jsonResult equals: jsonString.
]

{ #category : 'tests - guild' }
DSModelJsonMappingTest >> testConnectionStatusMappingForDnd [
	| result jsonResult jsonString |
	jsonString := '"dnd"'.
	result := self read: jsonString as: DSConnectionStatus mappedTo: #connectionStatusMappingFor:.
	self assert: result class equals: DSDoNotDisturbStatus.
	jsonResult := self write: result mappedTo: #connectionStatusMappingFor:.
	self assert: jsonResult equals: jsonString.
]

{ #category : 'tests - guild' }
DSModelJsonMappingTest >> testConnectionStatusMappingForOffline [
	| result jsonResult jsonString |
	jsonString := '"offline"'.
	result := self read: jsonString as: DSConnectionStatus mappedTo: #connectionStatusMappingFor:.
	self assert: result class equals: DSOfflineStatus.
	jsonResult := self write: result mappedTo: #connectionStatusMappingFor:.
	self assert: jsonResult equals: jsonString.
]

{ #category : 'tests - guild' }
DSModelJsonMappingTest >> testConnectionStatusMappingForOnline [
	| result jsonResult jsonString |
	jsonString := '"online"'.
	result := self read: jsonString as: DSConnectionStatus mappedTo: #connectionStatusMappingFor:.
	self assert: result class equals: DSOnlineStatus.
	jsonResult := self write: result mappedTo: #connectionStatusMappingFor:.
	self assert: jsonResult equals: jsonString.
]

{ #category : 'tests - basic' }
DSModelJsonMappingTest >> testDateAndTimeMappingFor [
	| result jsonResult jsonString |
	jsonString := '"2017-11-03T15:21:38.579+00:00"'.
	result := self read: jsonString as: DateAndTime mappedTo: #dateAndTimeMappingFor:.
	self assert: result class equals: DateAndTime.
	self assert: result year equals: 2017.
	self assert: result month equals: 11.
	self assert: result dayOfMonth equals: 3.
	jsonResult := self write: result mappedTo: #dateAndTimeMappingFor:.
	self assert: jsonResult equals: jsonString.
]

{ #category : 'tests - basic' }
DSModelJsonMappingTest >> testDateAndTimeMappingForNil [
	| result jsonResult jsonString |
	jsonString := 'null'.
	result := self read: jsonString as: DateAndTime mappedTo: #dateAndTimeMappingFor:.
	self assert: result isNil.
	jsonResult := self write: result mappedTo: #dateAndTimeMappingFor:.
	self assert: jsonResult equals: jsonString.
]

{ #category : 'tests - basic' }
DSModelJsonMappingTest >> testDateAndTimeMappingForStandard [
	"This JSON is the one returned by Discord."
	| result jsonResult jsonString |
	jsonString := '"2017-11-03T15:21:38.579000+00:00"'.
	result := self read: jsonString as: DateAndTime mappedTo: #dateAndTimeMappingFor:.
	self assert: result class equals: DateAndTime.
	self assert: result year equals: 2017.
	self assert: result month equals: 11.
	self assert: result dayOfMonth equals: 3.
	jsonResult := self write: result mappedTo: #dateAndTimeMappingFor:.
	self assert: jsonResult equals: '"2017-11-03T15:21:38.579+00:00"'.
]

{ #category : 'tests - basic' }
DSModelJsonMappingTest >> testDurationInSecondsMappingFor [
	| result jsonResult jsonString |
	jsonString := '300234'.
	result := self read: jsonString as: #DurationInSeconds mappedTo: #durationInSecondsMappingFor:.
	self assert: result class equals: Duration.
	self assert: result equals: 300234 seconds.
	jsonResult := self write: result as: #DurationInSeconds mappedTo: #durationInSecondsMappingFor:.
	self assert: jsonResult equals: jsonString.
]

{ #category : 'tests - message' }
DSModelJsonMappingTest >> testEditMessagePayloadMappingFor [
	| result jsonResult jsonString |
	jsonString := self classToTest jsonEditMessagePayload.
	result := self read: jsonString as: NeoJSONObject mappedTo: #editMessagePayloadMappingFor:.
	self assert: result class equals: NeoJSONObject.
	self assert: result content equals: 'any string'.
	self assert: result embed class equals: DSEmbed.
	jsonResult := self write: result mappedTo: #editMessagePayloadMappingFor:.
	self assert: jsonResult equals: jsonString.
]

{ #category : 'tests - embed' }
DSModelJsonMappingTest >> testEmbedAuthorMappingFor [
	| result jsonResult jsonString |
	jsonString := self classToTest jsonEmbedAuthor.
	result := self read: jsonString as: DSEmbedAuthor mappedTo: #embedAuthorMappingFor:.
	self assert: result class equals: DSEmbedAuthor.
	self assert: result name equals: 'name of author'.
	self assert: result url equals: 'https://example.com/author.html' asZnUrl.
	self assert: result iconUrl equals: 'http://cdn.example.com/author_icon.png' asZnUrl.
	self assert: result proxyIconUrl equals: 'http://image.example.com/author_icon.png' asZnUrl.
	jsonResult := self write: result mappedTo: #embedAuthorMappingFor:.
	self assert: jsonResult equals: jsonString.
]

{ #category : 'tests - embed' }
DSModelJsonMappingTest >> testEmbedFieldMappingFor [
	| result jsonResult jsonString |
	jsonString := self classToTest jsonEmbedField.
	result := self read: jsonString as: DSEmbedField mappedTo: #embedFieldMappingFor:.
	self assert: result class equals: DSEmbedField.
	self assert: result name equals: 'name of the field'.
	self assert: result value equals: 'value of the field'.
	self assert: result isInline.
	jsonResult := self write: result mappedTo: #embedFieldMappingFor:.
	self assert: jsonResult equals: jsonString.
]

{ #category : 'tests - embed' }
DSModelJsonMappingTest >> testEmbedFieldMappingForFalse [
	| result jsonResult jsonString |
	jsonString := self classToTest jsonEmbedFieldFalse.
	result := self read: jsonString as: DSEmbedField mappedTo: #embedFieldMappingFor:.
	self assert: result class equals: DSEmbedField.
	self assert: result name equals: 'name of the not-inlined field'.
	self assert: result value equals: 'value of the not-inlined field'.
	self deny: result isInline.
	jsonResult := self write: result mappedTo: #embedFieldMappingFor:.
	self assert: jsonResult equals: jsonString.
]

{ #category : 'tests - embed' }
DSModelJsonMappingTest >> testEmbedFooterMappingFor [
	| result jsonResult jsonString |
	jsonString := self classToTest jsonEmbedFooter.
	result := self read: jsonString as: DSEmbedFooter mappedTo: #embedFooterMappingFor:.
	self assert: result class equals: DSEmbedFooter.
	self assert: result text equals: 'footer text'.
	self assert: result iconUrl equals: 'http://cdn.example.com/icon.png' asZnUrl.
	self assert: result proxyIconUrl equals: 'http://image.example.com/icon.png' asZnUrl.
	jsonResult := self write: result mappedTo: #embedFooterMappingFor:.
	self assert: jsonResult equals: jsonString.
]

{ #category : 'tests - embed' }
DSModelJsonMappingTest >> testEmbedImageMappingFor [
	self testImage: DSEmbedImage mappedTo: #embedImageMappingFor:.
]

{ #category : 'tests - embed' }
DSModelJsonMappingTest >> testEmbedMappingFor [
	| result jsonResult jsonString |
	jsonString := self classToTest jsonEmbedOneField.
	result := self read: jsonString as: DSEmbed mappedTo: #embedMappingFor:.
	self assert: result class equals: DSEmbed.
	self assert: result title equals: 'title of embed'.
	self assert: result type equals: 'rich'.
	self assert: result description equals: 'description of embed'.
	self assert: result url equals: 'http://example.com/embed.html' asZnUrl.
	self assert: result timestamp equals: '2017-11-03T15:21:38.579000+00:00' asDateAndTime.
	self assert: result color equals: Color red.
	self assert: result footer class equals: DSEmbedFooter.
	self assert: result image class equals: DSEmbedImage.
	self assert: result thumbnail class equals: DSEmbedThumbnail.
	self assert: result video class equals: DSEmbedVideo.
	self assert: result provider class equals: DSEmbedProvider.
	self assert: result author class equals: DSEmbedAuthor.
	self assert: result fields class equals: Array.
	jsonResult := self write: result mappedTo: #embedMappingFor:.
	self assert: jsonResult equals: jsonString.
]

{ #category : 'tests - embed' }
DSModelJsonMappingTest >> testEmbedProviderMappingFor [
	| result jsonResult jsonString |
	jsonString := self classToTest jsonEmbedProvider.
	result := self read: jsonString as: DSEmbedProvider mappedTo: #embedProviderMappingFor:.
	self assert: result class equals: DSEmbedProvider.
	self assert: result url equals: 'http://example.com/provider.html' asZnUrl.
	self assert: result name equals: 'name of provider'.
	jsonResult := self write: result mappedTo: #embedProviderMappingFor:.
	self assert: jsonResult equals: jsonString.
]

{ #category : 'tests - embed' }
DSModelJsonMappingTest >> testEmbedThumbnailMappingFor [
	self testImage: DSEmbedThumbnail mappedTo: #embedThumbnailMappingFor:.
]

{ #category : 'tests - embed' }
DSModelJsonMappingTest >> testEmbedVideoMappingFor [
	| result jsonResult jsonString |
	jsonString := self classToTest jsonEmbedVideo.
	result := self read: jsonString as: DSEmbedVideo mappedTo: #embedVideoMappingFor:.
	self assert: result class equals: DSEmbedVideo.
	self assert: result url equals: 'http://example.com/video.html' asZnUrl.
	self assert: result height equals: 768.
	self assert: result width equals: 1024.
	jsonResult := self write: result mappedTo: #embedVideoMappingFor:.
	self assert: jsonResult equals: jsonString.
]

{ #category : 'tests - message' }
DSModelJsonMappingTest >> testEmojiMappingFor [
	| result jsonResult jsonString |
	jsonString := self classToTest jsonEmoji.
	result := self read: jsonString as: DSEmoji mappedTo: #emojiMappingFor:.
	self assert: result class equals: DSEmoji.
	self assert: result id equals: '41274983523343936'.
	self assert: result name equals: 'emoji name'.
	self assert: result roles class equals: Array.
	self assert: result user class equals: DSUser.
	self assert: result requireColons.
	self deny: result managed.
	jsonResult := self write: result mappedTo: #emojiMappingFor:.
	self assert: jsonResult equals: jsonString.
]

{ #category : 'tests - guild' }
DSModelJsonMappingTest >> testGameMappingFor [
	| result jsonResult jsonString |
	jsonString := self classToTest jsonGame.
	result := self read: jsonString as: DSGame mappedTo: #gameMappingFor:.
	self assert: result class equals: DSGame.
	self assert: result name equals: 'Rocket League'.
	self assert: result type equals: 1.
	self assert: result url equals: 'https://www.twitch.tv/123' asZnUrl.
	jsonResult := self write: result mappedTo: #gameMappingFor:.
	self assert: jsonResult equals: jsonString.
]

{ #category : 'tests - guild' }
DSModelJsonMappingTest >> testGuildMappingFor [
	| result jsonString jsonResult |
	jsonString := self classToTest jsonGuild.
	result := self read: jsonString as: DSGuild mappedTo: #guildMappingFor:.
	self assert: result class equals: DSGuild.
	self assert: result id equals: '41771983423143921'.
	self assert: result name equals: 'guild name (2-100 characters)'.
	self assert: result iconHash equals: 'icon hash'.
	self assert: result splashHash equals: 'splash hash'.
	self assert: result ownerId equals: '41771983763143932'.
	self assert: result region equals: 'voice_region.id'.
	self assert: result afkChannelId equals: '41771983423143920'.
	self assert: result afkTimeout equals: 300 seconds.
	self assert: result embedEnabled.
	self assert: result embedChannelId equals: '41771983423143921'.
	self assert: result verificationLevel equals: 0.
	self assert: result defaultMessageNotifications equals: 1.
	self assert: result explicitContentFilter equals: 2.
	self assert: result roles class equals: Array.
	self assert: result roles first class equals: DSRole.
	self assert: result emojis class equals: Array.
	self assert: result emojis first class equals: DSEmoji.
	self assert: result features equals: 'enabled guild features'.
	self assert: result mfaLevel equals: 1.
	self assert: result applicationId equals: '31771923763143932'.
	self assert: result widgetEnabled.
	self assert: result widgetChannelId equals: '41771983423143921'.
	self assert: result joinedAt equals: '2017-11-03T15:21:38.579+00:00' asDateAndTime.
	self assert: result large.
	self deny: result unavailable.
	self assert: result memberCount equals: 108.
	self assert: result voiceStates class equals: Array.
	self assert: result voiceStates first class equals: DSVoiceState.
	self assert: result members class equals: DSGuildMembers.
	self assert: result members first class equals: DSGuildMember.
	self assert: result channels class equals: DSChannels.
	self assert: result channels first class equals: DSCategoryChannel.
	self assert: result presences class equals: Array.
	self assert: result presences first class equals: DSPresenceUpdate.
	jsonResult := self write: result mappedTo: #guildMappingFor:.
	self assert: jsonResult equals: jsonString.
]

{ #category : 'tests - guild' }
DSModelJsonMappingTest >> testGuildMemberMappingFor [
	| result jsonResult jsonString |
	jsonString := self classToTest jsonGuildMember.
	result := self read: jsonString as: DSGuildMember mappedTo: #guildMemberMappingFor:.
	self assert: result class equals: DSGuildMember.
	self assert: result user class equals: DSUser.
	self assert: result nick equals: 'this users guild nickname (if one is set)'.
	self assert: result roleIds class equals: Array.
	self assert: result roleIds size equals: 1.
	self assert: result roleIds first equals: '80351110222677913'.
	self assert: result joinedAt equals: '2015-04-26T06:26:56.936000+00:00' asDateAndTime.
	self deny: result deaf.
	self deny: result mute.
	jsonResult := self write: result mappedTo: #guildMemberMappingFor:.
	self assert: jsonResult equals: jsonString.
]

{ #category : 'tests - channel' }
DSModelJsonMappingTest >> testGuildTextChannelMappingFor [
	| result jsonResult jsonString |
	jsonString := self classToTest jsonChannelGuildText.
	result := self read: jsonString as: DSGuildTextChannel mappedTo: #guildTextChannelMappingFor:.
	self assert: result class equals: DSGuildTextChannel.
	self assert: result id equals: '41771983423143937'.
	self assert: result guildId equals: '41771983423143937'.
	self assert: result position equals: 6.
	self assert: result permissionOverwrites class equals: Array.
	self assert: result name equals: 'general'.
	self assert: result topic equals: '24/7 chat about how to gank Mike #2'.
	self assert: result nsfw.
	self assert: result lastMessageId equals: '155117677105512449'.
	self assert: result icon equals: '309350229021696111'.
	self assert: result parentId equals: '41771983423143939'.
	jsonResult := self write: result mappedTo: #guildTextChannelMappingFor:.
	self assert: jsonResult equals: jsonString.
]

{ #category : 'tests - basic' }
DSModelJsonMappingTest >> testImage: aDiscordClass mappedTo: mappingSymbol [
	| result jsonResult jsonString |
	jsonString := self classToTest jsonEmbedImage.
	result := self read: jsonString as: aDiscordClass mappedTo: mappingSymbol.
	self assert: result class equals: aDiscordClass.
	self assert: result url equals: 'http://cdn.example.com/image.jpg' asZnUrl.
	self assert: result proxyUrl equals: 'http://proxy.example.com/image.jpg' asZnUrl.
	self assert: result height equals: 618.
	self assert: result width equals: 967.
	jsonResult := self write: result mappedTo: mappingSymbol.
	self assert: jsonResult equals: jsonString.
]

{ #category : 'tests - message' }
DSModelJsonMappingTest >> testMessageMappingFor [
	| result jsonResult jsonString |
	jsonString := self classToTest jsonMessage.
	result := self read: jsonString as: DSMessage mappedTo: #messageMappingFor:.
	self assert: result class equals: DSMessage.
	jsonResult := self write: result mappedTo: #messageMappingFor:.
	self assert: jsonResult equals: jsonString.
]

{ #category : 'tests - channel' }
DSModelJsonMappingTest >> testOverwriteMappingFor [
	| result jsonResult jsonString |
	jsonString := self classToTest jsonOverwriteMember.
	result := self read: jsonString as: DSOverwrite mappedTo: #overwriteMappingFor:.
	self assert: result class equals: DSOverwrite.
	self assert: result id equals: '376082041888961714'.
	self assert: result type equals: 'member'.
	self assert: result allow equals: 123.
	self assert: result deny equals: 345.
	jsonResult := self write: result mappedTo: #overwriteMappingFor:.
	self assert: jsonResult equals: jsonString.
]

{ #category : 'tests - channel' }
DSModelJsonMappingTest >> testOverwriteMappingForRole [
	| result jsonResult jsonString |
	jsonString := self classToTest jsonOverwriteRole.
	result := self read: jsonString as: DSOverwrite mappedTo: #overwriteMappingFor:.
	self assert: result class equals: DSOverwrite.
	self assert: result id equals: '376082041888961711'.
	self assert: result type equals: 'role'.
	self assert: result allow equals: 987.
	self assert: result deny equals: 654.
	jsonResult := self write: result mappedTo: #overwriteMappingFor:.
	self assert: jsonResult equals: jsonString.
]

{ #category : 'tests - guild' }
DSModelJsonMappingTest >> testPresenceUpdateMappingFor [
	| result jsonResult jsonString |
	jsonString := self classToTest jsonPresenceUpdate.
	result := self read: jsonString as: DSPresenceUpdate mappedTo: #presenceUpdateMappingFor:.
	self assert: result class equals: DSPresenceUpdate.
	self assert: result user class equals: DSUser.
	self assert: result roleIds class equals: Array.
	self assert: result roleIds size equals: 1.
	self assert: result roleIds first equals: '80351110222677913'.
	self assert: result guildId equals: '60251110222617911'.
	self assert: result status class equals: DSIdleStatus.
	jsonResult := self write: result mappedTo: #presenceUpdateMappingFor:.
	self assert: jsonResult equals: jsonString.
]

{ #category : 'tests - guild' }
DSModelJsonMappingTest >> testPresenceUpdateMappingForWithGameNull [
	| result jsonResult jsonString |
	jsonString := self classToTest jsonPresenceUpdateWithGameNull.
	result := self read: jsonString as: DSPresenceUpdate mappedTo: #presenceUpdateMappingFor:.
	self assert: result class equals: DSPresenceUpdate.
	self assert: result user class equals: DSUser.
	self assert: result roleIds isNil.
	self assert: result guildId isNil.
	self assert: result game isNil.
	self assert: result status class equals: DSIdleStatus.
	jsonResult := self write: result mappedTo: #presenceUpdateMappingFor:.
	self assert: jsonResult equals: '{"user":{"id":"286153065164308480","bot":false,"verified":false},"status":"idle"}'.
]

{ #category : 'tests - message' }
DSModelJsonMappingTest >> testReactionMappingFor [
	| result jsonResult jsonString |
	jsonString := self classToTest jsonReaction.
	result := self read: jsonString as: DSReaction mappedTo: #reactionMappingFor:.
	self assert: result class equals: DSReaction.
	self assert: result count equals: 5.
	self assert: result me.
	self assert: result emoji class equals: DSEmoji.
	jsonResult := self write: result mappedTo: #reactionMappingFor:.
	self assert: jsonResult equals: jsonString.
]

{ #category : 'tests - message' }
DSModelJsonMappingTest >> testRecipientMappingFor [
	| result jsonResult jsonString |
	jsonString := self classToTest jsonRecipient.
	result := self read: jsonString as: DSUser mappedTo: #recipientMappingFor:.
	self assert: result class equals: DSUser.
	self assert: result id equals: '80351110224678912'.
	jsonResult := self write: result mappedTo: #recipientMappingFor:.
	self assert: jsonResult equals: jsonString.
]

{ #category : 'tests - message' }
DSModelJsonMappingTest >> testRoleMappingFor [
	| result jsonResult jsonString |
	jsonString := self classToTest jsonRole.
	result := self read: jsonString as: DSRole mappedTo: #roleMappingFor:.
	self assert: result class equals: DSRole.
	self assert: result id equals: '41771983423143936'.
	self assert: result name equals: 'WE DEM BOYZZ!!!!!!'.
	self assert: result color equals: (Color r: 0.20400000000000001 g: 0.596 b: 0.859 alpha: 1.0).
	self assert: result hoist.
	self assert: result position equals: 1.
	self assert: result permissions equals: 66321471.
	self deny: result managed.
	self deny: result mentionable.
	jsonResult := self write: result mappedTo: #roleMappingFor:.
	self assert: jsonResult equals: jsonString.
]

{ #category : 'tests - channel' }
DSModelJsonMappingTest >> testSpecifiedChannelMappingFor [
	| result jsonResult jsonString |
	jsonString := self classToTest jsonChannelGuildText.
	result := self read: jsonString as: #SpecifiedChannel mappedTo: #specifiedChannelMappingFor:.
	self assert: result class equals: DSGuildTextChannel.
	self assert: result id equals: '41771983423143937'.
	self assert: result guildId equals: '41771983423143937'.
	self assert: result position equals: 6.
	self assert: result permissionOverwrites class equals: Array.
	self assert: result name equals: 'general'.
	self assert: result topic equals: '24/7 chat about how to gank Mike #2'.
	self assert: result nsfw.
	self assert: result lastMessageId equals: '155117677105512449'.
	self assert: result icon equals: '309350229021696111'.
	self assert: result parentId equals: '41771983423143939'.
	jsonResult := self write: result mappedTo: #specifiedChannelMappingFor:.
	self assert: jsonResult equals: jsonString.
]

{ #category : 'tests - channel' }
DSModelJsonMappingTest >> testSpecifiedChannelMappingForCategory [
	| result jsonResult jsonString |
	jsonString := self classToTest jsonChannelCategory.
	result := self read: jsonString as: #SpecifiedChannel mappedTo: #specifiedChannelMappingFor:.
	self assert: result class equals: DSCategoryChannel.
	self assert: result id equals: '41771983423143939'.
	self assert: result guildId equals: '290926798629997250'.
	self assert: result position equals: 0.
	self assert: result permissionOverwrites class equals: Array.
	self assert: result name equals: 'Test'.
	self deny: result nsfw.
	jsonResult := self write: result mappedTo: #specifiedChannelMappingFor:.
	self assert: jsonResult equals: jsonString.
]

{ #category : 'tests - channel' }
DSModelJsonMappingTest >> testSpecifiedChannelMappingForDM [
	| result jsonResult jsonString |
	jsonString := self classToTest jsonChannelDirectMessage.
	result := self read: jsonString as: #SpecifiedChannel mappedTo: #specifiedChannelMappingFor:.
	self assert: result class equals: DSDirectMessageChannel.
	self assert: result id equals: '319674150115610528'.
	self assert: result recipients class equals: Array.
	self assert: result lastMessageId equals: '3343820033257021450'.
	jsonResult := self write: result mappedTo: #specifiedChannelMappingFor:.
	self 
		assert: jsonResult
		equals: '{"id":"319674150115610528","type":1,"last_message_id":"3343820033257021450","recipients":[{"id":"82198898841029460","username":"test","discriminator":"9999","avatar":"33ecab261d4681afa4d85a04691c4a01","bot":false,"verified":false}]}'.
]

{ #category : 'tests - channel' }
DSModelJsonMappingTest >> testSpecifiedChannelMappingForDMGroup [
	| result jsonResult jsonString |
	jsonString := self classToTest jsonChannelDirectMessageGroup.
	result := self read: jsonString as: #SpecifiedChannel mappedTo: #specifiedChannelMappingFor:.
	self assert: result class equals: DSDirectMessageGroupChannel.
	self assert: result id equals: '319674150115710528'.
	self assert: result name equals: 'Some test channel'.
	self assert: result recipients class equals: Array.
	self assert: result lastMessageId equals: '3343820033257021450'.
	self assert: result icon equals: 'an icon hash'.
	self assert: result ownerId equals: '82198810841029460'.
	jsonResult := self write: result mappedTo: #specifiedChannelMappingFor:.
	self 
		assert: jsonResult 
		equals: '{"id":"319674150115710528","type":3,"name":"Some test channel","last_message_id":"3343820033257021450","recipients":[{"id":"82198898841029460","username":"test","discriminator":"9999","avatar":"33ecab261d4681afa4d85a04691c4a01","bot":false,"verified":false},{"id":"82198810841029460","username":"test2","discriminator":"9999","avatar":"33ecab261d4681afa4d85a10691c4a01","bot":false,"verified":false}],"icon":"an icon hash","owner_id":"82198810841029460"}'.
]

{ #category : 'tests - channel' }
DSModelJsonMappingTest >> testSpecifiedChannelMappingForVoice [
	| result jsonResult jsonString |
	jsonString := self classToTest jsonChannelGuildVoice.
	result := self read: jsonString as: #SpecifiedChannel mappedTo: #specifiedChannelMappingFor:.
	self assert: result class equals: DSGuildVoiceChannel.
	self assert: result id equals: '41771983423143938'.
	self assert: result guildId equals: '41771983423143937'.
	self assert: result position equals: 5.
	self assert: result permissionOverwrites class equals: Array.
	self assert: result name equals: 'ROCKET CHEESE'.
	self assert: result userLimit equals: 0.
	self assert: result parentId equals: '41771983423143939'.
	jsonResult := self write: result mappedTo: #specifiedChannelMappingFor:.
	self assert: jsonResult equals: jsonString.
]

{ #category : 'tests - channel' }
DSModelJsonMappingTest >> testUnspecifiedChannelMappingFor [
	| result jsonResult jsonString |
	jsonString := self classToTest jsonAllPropertiesChannel.
	result := self read: jsonString as: DSUnspecifiedChannel mappedTo: #unspecifiedChannelMappingFor:.
	self assert: result class equals: DSUnspecifiedChannel.
	self assert: result id equals: '376680041881962816'.
	self assert: result type class equals: DSChannelGuildTextType.
	self assert: result guildId equals: '376204541188962822'.
	self assert: result position equals: 1.
	self assert: result permissionOverwrites class equals: Array.
	self assert: result name equals: 'the name of the channel (2-100 characters)'.
	self assert: result topic equals: 'the channel topic (0-1024 characters)'.
	self deny: result nsfw.
	self assert: result lastMessageId equals: '372200541188962021'.
	self assert: result bitrate equals: 1204.
	self assert: result userLimit equals: 24.
	self assert: result recipients class equals: Array.
	self assert: result icon equals: '309350229021696111'.
	self assert: result ownerId equals: '319350229021696243'.
	self assert: result applicationId equals: '319347229021696269'.
	self assert: result parentId equals: '371083041588962823'.
	jsonResult := self write: result mappedTo: #unspecifiedChannelMappingFor:.
	self assert: jsonResult equals: jsonString.
]

{ #category : 'tests - basic' }
DSModelJsonMappingTest >> testUrlMappingFor [
	| result jsonResult jsonString |
	jsonString := '"https://www.twitch.tv/123"'.
	result := self read: jsonString as: ZnUrl mappedTo: #urlMappingFor:.
	self assert: result class equals: ZnUrl.
	self assert: result equals: 'https://www.twitch.tv/123' asZnUrl.
	jsonResult := self write: result mappedTo: #urlMappingFor:.
	self assert: jsonResult equals: jsonString.
]

{ #category : 'tests - message' }
DSModelJsonMappingTest >> testUserMappingFor [
	| result jsonResult jsonString |
	jsonString := self classToTest jsonUser.
	result := self read: jsonString as: DSUser mappedTo: #userMappingFor:.
	self assert: result class equals: DSUser.
	self assert: result id equals: '80351110224678912'.
	self assert: result username equals: 'Nelly'.
	self assert: result discriminator equals: '1337'.
	self assert: result avatarHash equals: '8342729096ea3675442027381ff50dfe'.
	self deny: result isBot.
	self deny: result isMfaEnabled.
	self assert: result isVerified.
	self assert: result email equals: 'nelly@discordapp.com'.
	jsonResult := self write: result mappedTo: #userMappingFor:.
	self assert: jsonResult equals: jsonString.
]

{ #category : 'tests - guild' }
DSModelJsonMappingTest >> testVoiceStateMappingFor [
	| result jsonResult jsonString |
	jsonString := self classToTest jsonVoiceState.
	result := self read: jsonString as: DSVoiceState mappedTo: #voiceStateMappingFor:.
	self assert: result class equals: DSVoiceState.
	self assert: result guildId equals: '157733188964188161'.
	self assert: result channelId equals: '157733188964188160'.
	self assert: result userId equals: '80351110224678912'.
	self assert: result sessionId equals: '90326bd25d71d39b9ef95b299e3872ff'.
	self deny: result deaf.
	self deny: result mute.
	self deny: result selfDeaf.
	self assert: result selfMute.
	self deny: result suppress.
	jsonResult := self write: result mappedTo: #voiceStateMappingFor:.
	self assert: jsonResult equals: jsonString.
]

{ #category : 'utility' }
DSModelJsonMappingTest >> write: aDSObject as: schema mappedTo: mappingSymbol [ 
	"Return a JSON string representation of the Discord object."
	<return: #String>
	^ self classToTest write: aDSObject as: schema mappedTo: mappingSymbol
]

{ #category : 'utility' }
DSModelJsonMappingTest >> write: aDSObject mappedTo: mappingSymbol [ 
	"Return a JSON string representation of the Discord object."
	<return: #String>
	^ self classToTest write: aDSObject mappedTo: mappingSymbol
]
