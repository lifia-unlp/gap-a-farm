Class {
	#name : #SummaryMessageConfigState,
	#superclass : #Object,
	#instVars : [
		'frecuency',
		'dayRequested',
		'hourRequested',
		'attempts'
	],
	#category : #'GapAFarm-telegram'
}

{ #category : #'as yet unclassified' }
SummaryMessageConfigState >> dayInputValidation: aMessage [

	| regex dayInput inlineKeyboard |
	regex := '[1-7]' asRegex.
	dayInput  := aMessage text.
	(regex matches: dayInput) ifTrue: [
		dayRequested := false.
		self frecuency day: dayInput.
		inlineKeyboard := TelegramInlineKeyboard new
			buttonText: 'Si' callbackData: 'requestHour';
			buttonText: 'No' callbackData: 'requestDay'.
		GAFBot singleton sendChatMessage: (GAFBotMessageTemplateFactory new 							summaryConfigDayConfirmationTextMessage asMustacheTemplate value:{
									'day' -> dayInput} asDictionary) 
									withInlineKeyboard: inlineKeyboard 
									toUser: aMessage from.
		] ifFalse: [
		dayRequested := true.
		GAFBot singleton sendChatMessage: 'El valor que ingresaste es incorrecto. Volvé a intentarlo.' 
							toUser: aMessage from.
	].
]

{ #category : #accessing }
SummaryMessageConfigState >> frecuency [

	^ frecuency
]

{ #category : #accessing }
SummaryMessageConfigState >> frecuency: anObject [

	frecuency := anObject
]

{ #category : #hooks }
SummaryMessageConfigState >> handleTextMessage: aMessage [

	hourRequested ifTrue: [ ^self hourInputValidation: aMessage].
	dayRequested ifTrue: [ ^self dayInputValidation: aMessage ].
]

{ #category : #'as yet unclassified' }
SummaryMessageConfigState >> hourInputValidation: aMessage [

	| regex hourInput inlineKeyboard |
	regex := '^(0[0-9]|1[0-9]|2[0-3])\:[0-5][0-9]' asRegex.
	hourInput := aMessage text.
	(regex matches: hourInput) ifTrue: [
		hourRequested := false.
		self frecuency hour: hourInput.
		inlineKeyboard := TelegramInlineKeyboard new
			buttonText: 'Si' callbackData: 'saveFrecuency';
		 	buttonText: 'No' callbackData: 'requestHour'.
		GAFBot singleton sendChatMessage: (GAFBotMessageTemplateFactory new 							summaryConfigHourConfirmationTextMessage asMustacheTemplate value:{
									'hour' -> hourInput} asDictionary) 
									withInlineKeyboard: inlineKeyboard
									toUser: aMessage from.
		] ifFalse: [
		hourRequested := true.
		attempts := attempts - 1.
		(attempts == 0) ifFalse: [
			GAFBot singleton 
			sendChatMessage: 'El horario que ingresaste es incorrecto. Volvé a intentarlo.' 
			toUser: aMessage from.]
		ifTrue: [ 
			aMessage chat state: nil.
			GAFBot singleton 
			sendChatMessage: 'Demasiados intentos incorrectos. Volvé a intentarlo en otro momento.' 
			toUser: aMessage from.
			 ]
	].
]

{ #category : #initialization }
SummaryMessageConfigState >> initialize [

	dayRequested := false.
	hourRequested := false.
	attempts := 3.
]

{ #category : #'as yet unclassified' }
SummaryMessageConfigState >> requestDay: aCallbackQuery [

	| textMessage |
	textMessage := GAFBotMessageTemplateFactory new
						summaryConfigRequestDayTextMessage.
	dayRequested := true.
	GAFBot singleton sendChatMessage: textMessage to: aCallbackQuery from.
]

{ #category : #'as yet unclassified' }
SummaryMessageConfigState >> requestHour: aCallbackQuery [

	| textMessage |
	textMessage := GAFBotMessageTemplateFactory new
						summaryConfigAskHourTextMessage.
	hourRequested := true.
	GAFBot singleton sendChatMessage: textMessage to: aCallbackQuery from.
]

{ #category : #'as yet unclassified' }
SummaryMessageConfigState >> saveFrecuency: aCallbackQuery [

	| chat |
	
	chat := GAFBot singleton chatForTelegramUserId: aCallbackQuery from.
	chat state: nil.
	chat summaryFrecuency: self frecuency.
	GAFBot singleton 
		sendChatMessage: (GAFBotMessageTemplateFactory new summaryConfigSaveSuccessTextMessage)
		toUser: aCallbackQuery from.
	GAFBot singleton 
		sendChatMessage: (GAFBotMessageTemplateFactory new availableCommands asMustacheTemplate) 		toUser: aCallbackQuery from.
]

{ #category : #'as yet unclassified' }
SummaryMessageConfigState >> showFrecuencies: aCallbackQuery [

	| inlineKeyboard |
	inlineKeyboard := TelegramInlineKeyboard new
		buttonText: 'Diariamente' callbackData: 'summaryConfigDaily';
		buttonText: 'Semanalmente' callbackData: 'summaryConfigWeekly'.
	GAFBot singleton sendChatMessage:  
						GAFBotMessageTemplateFactory new greetingConfigSummaryFrecuencyTextMessage 
			withInlineKeyboard: inlineKeyboard
			toUser: aCallbackQuery from.
]

{ #category : #'as yet unclassified' }
SummaryMessageConfigState >> summaryConfigDaily: aCallbackQuery [

	| textMessage inlineKeyboard |
	self frecuency: SummaryMessageFrequencyDaily new.
	textMessage := GAFBotMessageTemplateFactory new
						summaryConfigSelectedFrecuency asMustacheTemplate value: { 
									('frecuency' -> 'diariamente' ).
							 } asDictionary.
	inlineKeyboard := TelegramInlineKeyboard new
		buttonText: 'Si' callbackData: 'requestHour';
		buttonText: 'No' callbackData: 'showFrecuencies'.
	GAFBot singleton sendChatMessage: textMessage 
						withInlineKeyboard: inlineKeyboard 
						toUser: aCallbackQuery from.  
]

{ #category : #'as yet unclassified' }
SummaryMessageConfigState >> summaryConfigWeekly: aCallbackQuery [

	| textMessage inlineKeyboard |
	self frecuency: SummaryMessageFrecuencyWeekly new.
	textMessage := GAFBotMessageTemplateFactory new
						summaryConfigSelectedFrecuency asMustacheTemplate value: { 
									('frecuency' -> 'semanalmente' ).
							 } asDictionary.
	inlineKeyboard := TelegramInlineKeyboard new
		buttonText: 'Si' callbackData: 'requestDay';
		buttonText: 'No' callbackData: 'showFrecuencies'.
	GAFBot singleton sendChatMessage: textMessage 
						withInlineKeyboard: inlineKeyboard  
						toUser: aCallbackQuery from.  
]
