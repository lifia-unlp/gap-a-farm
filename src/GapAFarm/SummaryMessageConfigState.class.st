Class {
	#name : #SummaryMessageConfigState,
	#superclass : #Object,
	#instVars : [
		'frecuency',
		'requestedDay',
		'requestedHour',
		'attempts'
	],
	#category : #'GapAFarm-telegram'
}

{ #category : #'as yet unclassified' }
SummaryMessageConfigState >> dayInputValidation: aMessage [

	| regex dayInput buttons |
	regex := '[1-7]' asRegex.
	dayInput  := aMessage text.
	(regex matches: dayInput) ifTrue: [
		requestedDay  := false.
		self frecuency day: dayInput.
		buttons := OrderedCollection new.
		buttons add: ({('text' -> 'Si').('callback_data'->'requestHour')} asDictionary ).
		buttons add: ({('text' -> 'No').('callback_data'->'requestDay')} asDictionary ).
		GAFBot singleton sendChatMessage: (GAFBotMessageTemplateFactory new 							summaryConfigDayConfirmationTextMessage asMustacheTemplate value:{
									'day' -> dayInput} asDictionary) 
									withInlineButtons: buttons
									toUser: aMessage from.
		] ifFalse: [
		requestedDay := true.
		GAFBot singleton 
		sendChatMessage: 'El valor que ingresaste es incorrecto. Volvé a intentarlo.' 
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

	requestedHour ifTrue: [ ^self hourInputValidation: aMessage].
	requestedDay ifTrue: [ ^self dayInputValidation: aMessage ].
	"GAFBot singleton setState: nil forChat: aMessage chat id.
	GAFBot singleton sendChatMessage: aMessage text to: aMessage chat."
]

{ #category : #'as yet unclassified' }
SummaryMessageConfigState >> hourInputValidation: aMessage [

	| regex hourInput buttons |
	regex := '^(0[0-9]|1[0-9]|2[0-3])\:[0-5][0-9]' asRegex.
	hourInput := aMessage text.
	(regex matches: hourInput) ifTrue: [
		requestedHour := false.
		self frecuency hour: hourInput.
		buttons := OrderedCollection new.
		buttons add: ({('text' -> 'Si').('callback_data'->'saveFrecuency')} asDictionary ).
		buttons add: ({('text' -> 'No').('callback_data'->'requestHour')} asDictionary ).
		GAFBot singleton sendChatMessage: (GAFBotMessageTemplateFactory new 							summaryConfigHourConfirmationTextMessage asMustacheTemplate value:{
									'hour' -> hourInput} asDictionary) 
									withInlineButtons: buttons
									toUser: aMessage from.
		] ifFalse: [
		requestedHour  := true.
		attempts := attempts - 1.
		(attempts == 0) ifFalse: [
			GAFBot singleton 
			sendChatMessage: 'El horario que ingresaste es incorrecto. Volvé a intentarlo.' 
			toUser: aMessage from.]
		ifTrue: [ 
			GAFBot singleton 
			sendChatMessage: 'Demasiados intentos incorrectos. Volvé a intentarlo en otro momento.' 
			toUser: aMessage from.
			 ]
	].
]

{ #category : #initialization }
SummaryMessageConfigState >> initialize [

	requestedDay := false.
	requestedHour := false.
	attempts := 3.
]

{ #category : #'as yet unclassified' }
SummaryMessageConfigState >> requestDay: aCallbackQuery [

	| textMessage |
	textMessage := GAFBotMessageTemplateFactory new
						summaryConfigRequestDayTextMessage.
	requestedDay := true.
	GAFBot singleton sendChatMessage: textMessage to: aCallbackQuery from.
]

{ #category : #'as yet unclassified' }
SummaryMessageConfigState >> requestHour: aCallbackQuery [

	| textMessage |
	textMessage := GAFBotMessageTemplateFactory new
						summaryConfigAskHourTextMessage.
	requestedHour := true.
	GAFBot singleton sendChatMessage: textMessage to: aCallbackQuery from.
]

{ #category : #'as yet unclassified' }
SummaryMessageConfigState >> saveFrecuency: aCallbackQuery [

	"Primero deberia hacer que el bot almacene(persista) las configuraciones."
	GAFBot singleton setState: nil forUser: aCallbackQuery from.
	GAFBot singleton sendChatMessage: 'Perfecto, ya configuraste la frecuencia para recibir los 												mensajes sobre el estado de tu predio.' 
							toUser: aCallbackQuery from.
	GAFBot singleton sendChatMessage: (GAFBotMessageTemplateFactory new availableCommands
			 asMustacheTemplate value: {  }) toUser: aCallbackQuery from.
]

{ #category : #'as yet unclassified' }
SummaryMessageConfigState >> showFrecuencies: aCallbackQuery [

	| buttons |
	buttons := OrderedCollection new.
	buttons add: ({('text' -> 'Diariamente').('callback_data'->'summaryConfigDaily')} asDictionary ).
	buttons add: ({('text' -> 'Semanalmente').('callback_data'->'summaryConfigWeekly')} asDictionary ).
	GAFBot singleton sendChatMessage:  'Elija una de las opciones:
													Diariamente -> una vez por día
													Semanalmente -> una vez a la semana'
						withInlineButtons: buttons
						toUser: aCallbackQuery from.
]

{ #category : #'as yet unclassified' }
SummaryMessageConfigState >> summaryConfigDaily: aCallbackQuery [

	| textMessage buttons |
	self frecuency: SummaryMessageFrequencyDaily new.
	textMessage := GAFBotMessageTemplateFactory new
						summaryConfigSelectedFrecuency asMustacheTemplate value: { 
									('frecuency' -> 'diariamente' ).
							 } asDictionary.
	buttons := OrderedCollection new.
	buttons add: ({('text' -> 'Si').('callback_data'->'requestHour')} asDictionary ).
	buttons add: ({('text' -> 'No').('callback_data'->'summaryConfigFrecOptions')} asDictionary ).
	GAFBot singleton sendChatMessage: textMessage  withInlineButtons: buttons toUser: aCallbackQuery from.  
]

{ #category : #'as yet unclassified' }
SummaryMessageConfigState >> summaryConfigWeekly: aCallbackQuery [

	| textMessage buttons |
	self frecuency: SummaryMessageFrecuencyWeekly new.
	textMessage := GAFBotMessageTemplateFactory new
						summaryConfigSelectedFrecuency asMustacheTemplate value: { 
									('frecuency' -> 'semanalmente' ).
							 } asDictionary.
	buttons := OrderedCollection new.
	buttons add: ({('text' -> 'Si').('callback_data'->'requestDay')} asDictionary ).
	buttons add: ({('text' -> 'No').('callback_data'->'showFrecuencies')} asDictionary ).
	GAFBot singleton sendChatMessage: textMessage  withInlineButtons: buttons toUser: aCallbackQuery from.  
]
