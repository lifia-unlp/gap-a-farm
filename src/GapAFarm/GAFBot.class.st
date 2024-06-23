Class {
	#name : #GAFBot,
	#superclass : #PollingTelegramBot,
	#instVars : [
		'farmsForChats',
		'statesForChats'
	],
	#classInstVars : [
		'singleton'
	],
	#category : #'GapAFarm-telegram'
}

{ #category : #singleton }
GAFBot class >> singleton [

	^ singleton ifNil: [ singleton := self new ]
]

{ #category : #commands }
GAFBot >> alertas: aMessage [

	| alerts |	
	
	alerts := self blogPostsType: 'Alerta' forMessage: aMessage.
   aMessage answer: (GAFBotMessageTemplateFactory new alertsAsTextMessage: alerts).
]

{ #category : #'as yet unclassified' }
GAFBot >> blogPostsType: aType forFarm: aFarm [

	| blogPosts |
	blogPosts := GapAFarm singleton blogPostFor: aFarm .
	^ blogPosts select: [ :each | aType = each type ].
]

{ #category : #utilities }
GAFBot >> blogPostsType: aType forMessage: aMessage [

	| farm |
	farm := self farmForMessage: aMessage.
	^ self blogPostsType: aType forFarm: farm. 
	
	

]

{ #category : #pushing }
GAFBot >> broadcast: aString [

	farmsForChats keysDo: [ :chat |
		self sendChatMessage: aString to: chat ]
]

{ #category : #commands }
GAFBot >> carencia: aMessage [
	
	"Listado de lotes en carencia"
	| plots |	
		
	plots := self withdrawalPlotsForFarm: (self farmForMessage: aMessage).
	aMessage answer: (GAFBotMessageTemplateFactory new plotsInWithdrawalPeriodAsTextMessage: plots).
]

{ #category : #builder }
GAFBot >> chatBuilderClass [ 

	^ GAFChatBuilder
]

{ #category : #utility }
GAFBot >> chatForFarm: aFarm [

	^ farmsForChats keyAtValue: aFarm ifAbsent: [ nil ]
]

{ #category : #'as yet unclassified' }
GAFBot >> chatForTelegramUser: anUser [

	| farm |
	farm:= self farmForTelegramUser: anUser.
	^ self chatForFarm: farm .
]

{ #category : #accessing }
GAFBot >> chatStateFromMessage: aMessage [

	^ statesForChats at: aMessage chat id.
]

{ #category : #'as yet unclassified' }
GAFBot >> ensureChatFarmAssociationWith: aMessage [

	| farm |
	farm := farmsForChats at: aMessage chat ifAbsent: [
		        (self farmForTelegramUser: aMessage from) ifNotNil: [ :it |
			        farmsForChats at: aMessage chat put: it ] ].
	farm ifNil: [
		self notifyFarmNotSetFor: aMessage from inResponseTo: aMessage. 
		^ false ].
	^ true.
]

{ #category : #utility }
GAFBot >> farmForChat: aChat [

	^ farmsForChats at: aChat
]

{ #category : #utility }
GAFBot >> farmForMessage: aMessage [

	^ self farmForChat: aMessage chat
]

{ #category : #utility }
GAFBot >> farmForTelegramUser: aTelegramUser [

	^ (self gafUserFor: aTelegramUser)
		  ifNil: [ nil ]
		  ifNotNil: [ :it | it farms first ]
]

{ #category : #utility }
GAFBot >> farmsWithChats [

	^ farmsForChats values
]

{ #category : #private }
GAFBot >> gafUserFor: aTelegramUser [

	^ GapAFarm singleton users
		  detect: [ :each | each telegramId = aTelegramUser id ]
		  ifNone: [ nil ]
]

{ #category : #'as yet unclassified' }
GAFBot >> greeting: aMessage [

	| textMessage telegramUser chat messageFactory inlineKeyboard |
	"statesForChats := Dictionary new. --> porque no inicializaba el diccionario"
	chat := aMessage chat.
	telegramUser := aMessage from.
	messageFactory := GAFBotMessageTemplateFactory new.
	textMessage := messageFactory greetingTextMessage asMustacheTemplate value:{
									('username' -> telegramUser username).
								} asDictionary .
	"self sendChatMessage: textMessage to: chat.
	self sendChatMessage: messageFactory greetingBotDescriptionTextMessage to: chat.
	self sendChatMessage: messageFactory greetingAvailabilityInfoTextMessage to: chat."
	self sendChatMessage: messageFactory greetingConfigSummaryTextMessage to: chat.
	inlineKeyboard := TelegramInlineKeyboard new. 
	inlineKeyboard buttonText: 'Diariamente' callbackData: 'summaryConfigDaily'.
	inlineKeyboard buttonText: 'Semanalmente' callbackData: 'summaryConfigWeekly'.
	self sendChatMessage: messageFactory greetingConfigSummaryFrecuencyTextMessage 
					withInlineKeyboard: inlineKeyboard to: chat.
	chat state: SummaryMessageConfigState new.


]

{ #category : #'as yet unclassified' }
GAFBot >> handleCallbackQueryUpdate: aCallbackQueryUpdate [

	| chat|

	chat := self chatForTelegramUserId: aCallbackQueryUpdate callbackQuery from.
	chat handleCallbackQueryUpdate: aCallbackQueryUpdate.
]

{ #category : #unsupported }
GAFBot >> handleDocumentMessage: aMessage [

	aMessage answer:
		'Perdón, no estoy preparado para responder mensajes con adjuntos.'
	

]

{ #category : #'update handling' }
GAFBot >> handleMessageReceivedUpdate: aMessageReceivedUpdate [

	| msg |
	msg := aMessageReceivedUpdate message.
	(self ensureChatFarmAssociationWith: msg) ifFalse: [ ^ self ].
	super handleMessageReceivedUpdate: aMessageReceivedUpdate
]

{ #category : #unsupported }
GAFBot >> handlePhotoMessage: aMessage [

		aMessage answer:
		'Perdón, no estoy preparado para responder mensajes de con imágenes.'

]

{ #category : #unsupported }
GAFBot >> handleTextMessage: aMessage [

	| farm |
	farm := self farmForMessage: aMessage.
	aMessage chat handleTextMessage: aMessage forFarm: farm.
]

{ #category : #'voice-mesages' }
GAFBot >> handleVoiceMessage: aMessage [

	| sapi bytes text extractedParameters |
	sapi := SpeechToTextApi new.
	sapi isProperlyConfigured ifFalse: [
		aMessage answer:
			'Al parecer, la API de transcripción no está correctamente configurada.' ].
	bytes := (aMessage voice readStreamWith: self) contents.
	text := sapi transcribeByteArray: bytes.
	extractedParameters := GptDataExtractor new extractHarvestingParametersFrom: text.
	aMessage answer: 'Usted dijo: ', text.
	aMessage answer: 'Pude entender que: ', extractedParameters asJson .
]

{ #category : #private }
GAFBot >> hasElephantMemory [

	^ true
]

{ #category : #'initialize-release' }
GAFBot >> initialize [

	super initialize.
	farmsForChats := Dictionary new.
	statesForChats := Dictionary new.
	
]

{ #category : #private }
GAFBot >> notifyFarmNotSetFor: aTelegramUser inResponseTo: aMessage [

	| messageText |
	messageText := GAFBotMessageTemplateFactory new
		               farmNotSetNotification asMustacheTemplate value: {
			               ('username' -> aTelegramUser username).
			               ('id' -> aTelegramUser id) } asDictionary.
	aMessage answer: messageText
]

{ #category : #commands }
GAFBot >> novedades: aMessage [

	| news |
	"Paginar noticias?"
	news := self blogPostsType: 'Noticia' forMessage: aMessage.
	aMessage answer: (GAFBotMessageTemplateFactory new newsAsTextMessage: news).
]

{ #category : #utility }
GAFBot >> reset [

	self stopBot.
	self initialize. 
]

{ #category : #'as yet unclassified' }
GAFBot >> scheduledReport [

	farmsForChats keysAndValuesDo: [ :chat :farm |
	self sendChatMessage: (self summaryForFarm: farm) to: chat ].
]

{ #category : #'as yet unclassified' }
GAFBot >> sendChatMessage: textMessage toUser: user [

	self sendChatMessage: textMessage to: (self chatForTelegramUserId: user).
]

{ #category : #'as yet unclassified' }
GAFBot >> sendChatMessage: textMessage withInlineKeyboard: inlineKeyboard toUser: user [

	self sendChatMessage: textMessage withInlineKeyboard: inlineKeyboard  
							to: (self chatForTelegramUserId: user).
]

{ #category : #initialization }
GAFBot >> setState: aState forChat: anId [

	statesForChats at: anId put: aState.
]

{ #category : #initialization }
GAFBot >> setState: aState forUser: user [

	statesForChats at: (self chatForTelegramUserId: user) id put: aState.
]

{ #category : #'as yet unclassified' }
GAFBot >> summaryForFarm: aFarm [
	
	| plots textMsg | 
	textMsg := 'El resumen diario de tu granja:', Character lf asString.
	plots := self withdrawalPlotsForFarm: aFarm.
	^ textMsg copyWithAll: 
		(GAFBotMessageTemplateFactory new plotsInWithdrawalPeriodAsTextMessage: plots).
	
	
	
]

{ #category : #commands }
GAFBot >> test: aMessage [

	| farm |
	farm := self farmForMessage: aMessage.



	aMessage answer: 'Su granja se llama ' , farm name
]

{ #category : #updating }
GAFBot >> updateWithEvent: anAdversityReport [ 
	self broadcast: 'Se reporto una adversidad'.
]

{ #category : #'as yet unclassified' }
GAFBot >> withdrawalPlotsForFarm: aFarm [

	^ aFarm plots select: [ :each | 
				each withdrawalPeriodDaysLeft > 0 ].
]
