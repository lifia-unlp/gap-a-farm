Class {
	#name : #GAFBot,
	#superclass : #PollingTelegramBot,
	#instVars : [
		'farmsForChats'
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

{ #category : #hooks }
GAFBot >> handleTextMessage: aMessage [

	| farm |
	farm := farmsForChats at: aMessage chat ifAbsent: [
		        (self farmForTelegramUser: aMessage from) ifNotNil: [ :it |
			        farmsForChats at: aMessage chat put: it ] ].
	farm ifNil: [
		^ self notifyFarmNotSetFor: aMessage from inResponseTo: aMessage ].
	self offerActionsForFarm: farm inResponseTo: aMessage
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

{ #category : #hooks }
GAFBot >> offerActionsForFarm: farm inResponseTo: aMessage [

	aMessage answer:
		(GAFBotMessageTemplateFactory new availableCommands
			 asMustacheTemplate value: {  })
]

{ #category : #'as yet unclassified' }
GAFBot >> scheduledReport [

	farmsForChats keysAndValuesDo: [ :chat :farm |
	self sendChatMessage: (self summaryForFarm: farm) to: chat ].
]

{ #category : #'as yet unclassified' }
GAFBot >> summaryConfigAskHour: aCallbackQuery [

	| chat textMessage |
	chat := self chatForTelegramUserId: aCallbackQuery from.
	textMessage := GAFBotMessageTemplateFactory new
						summaryConfigAskHourTextMessage.
	self sendChatMessage: textMessage to: chat.
]

{ #category : #'as yet unclassified' }
GAFBot >> summaryConfigDaily: aCallbackQuery [

	| chat textMessage buttons |
	chat := self chatForTelegramUserId: aCallbackQuery from.
	textMessage := GAFBotMessageTemplateFactory new
						summaryConfigSelectedFrecuency asMustacheTemplate value: { 
									('frecuency' -> 'diariamente' ).
							 } asDictionary.
	buttons := OrderedCollection new.
	buttons add: ({('text' -> 'Si').('callback_data'->'summaryConfigAskHour')} asDictionary ).
	buttons add: ({('text' -> 'No').('callback_data'->'summaryConfigFrecOptions')} asDictionary ).
	self sendChatMessage: textMessage  withInlineButtons: buttons to: chat.  
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
