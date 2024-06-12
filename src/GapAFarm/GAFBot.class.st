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
GAFBot >> chatForTelegramUserId: anId [

	| farm |
	farm:= self farmForTelegramUser: anId.
	^ self chatForFarm: farm .
]

{ #category : #accessing }
GAFBot >> chatStateFromMessage: aMessage [

	^ statesForChats at: aMessage chat id.
]

{ #category : #utility }
GAFBot >> farmForMessage: aMessage [

	| farm |
	farm := farmsForChats at: aMessage chat ifAbsent: [
		        (self farmForTelegramUser: aMessage from) ifNotNil: [ :it |
			        farmsForChats at: aMessage chat put: it ] ].
	^ farm
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

	| textMessage telegramUser chat messageFactory buttons |
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
	buttons := OrderedCollection new.
	buttons add: ({('text' -> 'Diariamente').('callback_data'->'summaryConfigDaily')} asDictionary ).
	buttons add: ({('text' -> 'Semanalmente').('callback_data'->'summaryConfigWeekly')} asDictionary ).
	self sendChatMessage: messageFactory greetingConfigSummaryFrecuencyTextMessage 
					withInlineButtons: buttons asArray to: chat.
	statesForChats at: chat id put: SummaryMessageConfigState new.


]

{ #category : #'as yet unclassified' }
GAFBot >> handleCallbackQueryUpdate: aCallbackQueryUpdate [

	| callback chat chatState|
	callback := aCallbackQueryUpdate callbackQuery data.
	chat := self chatForTelegramUserId: aCallbackQueryUpdate callbackQuery from.
	chatState := statesForChats at: chat id.
	(chatState class canPerform: callback asValidSelector , ':')
		ifTrue: [ 
		chatState perform: callback asValidSelector , ':' with: aCallbackQueryUpdate callbackQuery ]
		ifFalse: [ 
		chatState error: 'Mensaje ', callback, ' no implementado.'
			]
]

{ #category : #unsupported }
GAFBot >> handleDocumentMessage: aMessage [

	aMessage answer:
		'Perdón, no estoy preparado para responder mensajes con adjuntos.'
	

]

{ #category : #unsupported }
GAFBot >> handlePhotoMessage: aMessage [

		aMessage answer:
		'Perdón, no estoy preparado para responder mensajes de con imágenes.'

]

{ #category : #unsupported }
GAFBot >> handleTextMessage: aMessage [

	| farm |
	farm := farmsForChats at: aMessage chat ifAbsent: [
		        (self farmForTelegramUser: aMessage from) ifNotNil: [ :it |
			        farmsForChats at: aMessage chat put: it ] ].
	farm ifNil: [
		^ self notifyFarmNotSetFor: aMessage from inResponseTo: aMessage ].
	aMessage chat handleTextMessage: aMessage forFarm: farm.
	"self offerActionsForFarm: farm inResponseTo: aMessage"
]

{ #category : #unsupported }
GAFBot >> handleVoiceMessage: aMessage [

	aMessage answer:
		'Perdón, no estoy preparado para responder mensajes de audio.'
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
GAFBot >> sendChatMessage: textMessage withInlineButtons: buttons toUser: user [

	self sendChatMessage: textMessage withInlineButtons: buttons  
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
