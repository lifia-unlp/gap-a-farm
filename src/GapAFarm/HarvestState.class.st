Class {
	#name : #HarvestState,
	#superclass : #Object,
	#instVars : [
		'harvestEvent',
		'plotRequested',
		'dateRequested',
		'hourRequested',
		'quantityRequested',
		'noteRequested'
	],
	#category : #'GapAFarm-telegram'
}

{ #category : #'as yet unclassified' }
HarvestState >> askForHarvestNote: aCallbackQuery [

	| inlineKeyboard |
	inlineKeyboard := TelegramInlineKeyboard new
		                  buttonText: 'Si'
		                  callbackData: 'requestHarvestNote';
		                  buttonText: 'No' callbackData: 'saveHarvest'.
	GAFBot singleton
		sendChatMessage:
		'¿Querés registrar una nota para esta cosecha? Si para registrar una nota, No para finalizar el registro de tu cosecha.'
		withInlineKeyboard: inlineKeyboard
		to: aCallbackQuery from
]

{ #category : #'as yet unclassified' }
HarvestState >> dateValidation: aMessage [

	| regex dateInput |
	regex := '([0-2][1-9]|3[0-1])/(0[1-9]|1[0-2])/\d*' asRegex.
	dateInput := aMessage text.
	(regex matches: dateInput)
		ifTrue: [
			dateRequested := false.
			harvestEvent date: (Date fromString: aMessage text).
			self sendDateConfirmation: aMessage ]
		ifFalse: [
			GAFBot singleton
				sendChatMessage:
				'La fecha ingresada no tiene un formato correcto.'
				toUser: aMessage from ]
]

{ #category : #hooks }
HarvestState >> handleTextMessage: aMessage [

	plotRequested ifTrue: [ ^ self plotValidation: aMessage ].
	dateRequested ifTrue: [ ^ self dateValidation: aMessage ].
	hourRequested ifTrue: [ ^ self hourInputValidation: aMessage ].
	quantityRequested ifTrue: [ ^ self quantityInputValidation: aMessage ].
	noteRequested ifTrue: [ ^ self noteInputValidation: aMessage. ]
]

{ #category : #'as yet unclassified' }
HarvestState >> hourInputValidation: aMessage [

	| regex hourInput |
	regex := '^(0[0-9]|1[0-9]|2[0-3])\:[0-5][0-9]' asRegex.
	hourInput := aMessage text.
	(regex matches: hourInput)
		ifTrue: [
			hourRequested := false.
			harvestEvent time: (Time fromString: aMessage text).
			self sendHourConfirmationForMessage: aMessage ]
		ifFalse: [
			GAFBot singleton
				sendChatMessage:
				'El horario que ingresaste es incorrecto. Volvé a intentarlo.'
				toUser: aMessage from ]
]

{ #category : #initialization }
HarvestState >> initialize [

	harvestEvent := Harvesting new.
	plotRequested := false.
	dateRequested := false.
	hourRequested := false.
	quantityRequested := false.
	noteRequested := false.
	
]

{ #category : #'as yet unclassified' }
HarvestState >> noteInputValidation: aMessage [

	noteRequested := false.
	self saveHarvest: aMessage from.
]

{ #category : #'as yet unclassified' }
HarvestState >> plotValidation: aMessage [

	| plot inlineKeyboard |
	plot := (GAFBot singleton farmForMessage: aMessage) plots
		        detect: [ :each | aMessage text = each id ]
		        ifNone: [ nil ].
	plot
		ifNil: [
			GAFBot singleton
				sendChatMessage:
				'El lote ingresado es incorrecto. Intentá nuevamente.'
				to: aMessage from ]
		ifNotNil: [
			plotRequested := false.
			harvestEvent plot: plot; crop: plot currentCrop.
			inlineKeyboard := TelegramInlineKeyboard new
				                  buttonText: 'Si' callbackData: 'requestHarvestDate';
				                  buttonText: 'No' callbackData: 'sendPlotsToHarvestList'.
			GAFBot singleton
				sendChatMessage: (GAFBotMessageTemplateFactory new
						 harvestingPlotConfirmationTextMessage asMustacheTemplate
						 value: {
								 ('plot_name' -> plot id).
								 ('crop_name' -> plot currentCrop) } asDictionary)
				withInlineKeyboard: inlineKeyboard
				toUser: aMessage from ]
]

{ #category : #'as yet unclassified' }
HarvestState >> plotsToHarvestListforFarm: aFarm [

	| plots |
	plots := aFarm plotsWithSowing collect: [ :each |
		         {
			         ('plot' -> each id).
			         ('crop' -> each currentCrop) } asDictionary ].
	plotRequested := true.
	^ GAFBotMessageTemplateFactory new harvestingPlotsList
		  asMustacheTemplate value: { ('plots' -> plots) } asDictionary
]

{ #category : #'as yet unclassified' }
HarvestState >> quantityInputValidation: aMessage [

	| regex input |
	regex := '\d*' asRegex.
	input := aMessage text.
	(regex matches: input)
		ifTrue: [
			quantityRequested := false.
			harvestEvent quantity: aMessage text.
			self sendQuantityConfirmationForMessage: aMessage ]
		ifFalse: [
			GAFBot singleton
				sendChatMessage: 'La cantidad debe ser un número.'
				toUser: aMessage from ]
]

{ #category : #'as yet unclassified' }
HarvestState >> requestHarvestDate: aCallbackQuery [

	dateRequested := true.
	GAFBot singleton
		sendChatMessage:
		GAFBotMessageTemplateFactory new harvestingRequestDateTextMessage
		toUser: aCallbackQuery from
]

{ #category : #'as yet unclassified' }
HarvestState >> requestHarvestHour: aCallbackQuery [

	hourRequested := true.
	GAFBot singleton
		sendChatMessage: 'Ingresá el horario en el que cosechaste.'
		toUser: aCallbackQuery from
]

{ #category : #'as yet unclassified' }
HarvestState >> requestHarvestNote: aCallbackQuery [

	noteRequested := true.
	GAFBot singleton
		sendChatMessage: 'Ingresá una nota para esta cosecha.'
		toUser: aCallbackQuery from
]

{ #category : #'as yet unclassified' }
HarvestState >> requestHarvestQuantity: aCallbackQuery [

	quantityRequested := true.
	GAFBot singleton
		sendChatMessage: 'Ingresá la cantidad cosechada (KG).'
		toUser: aCallbackQuery from
]

{ #category : #'as yet unclassified' }
HarvestState >> saveHarvest: aUser [

	| farm |
	farm := GAFBot singleton farmForTelegramUser: aUser.
	harvestEvent plot addEvent: harvestEvent.
	GAFBot singleton
		setState: nil forUser: aUser;
		sendChatMessage: 'Perfecto, tu cosecha se registró correctamente.'
		toUser: aUser
]

{ #category : #'as yet unclassified' }
HarvestState >> sendDateConfirmation: aMessage [

	| inlineKeyboard |
	inlineKeyboard := TelegramInlineKeyboard new
		                  buttonText: 'Si'
		                  callbackData: 'requestHarvestHour';
		                  buttonText: 'No' callbackData: 'requestHarvestDate'.
	GAFBot singleton
		sendChatMessage:
		'La fecha que ingresaste es válida. ¿Querés confirmar?'
		withInlineKeyboard: inlineKeyboard
		to: aMessage from
]

{ #category : #'as yet unclassified' }
HarvestState >> sendHourConfirmationForMessage: aMessage [

	| inlineKeyboard |
	inlineKeyboard := TelegramInlineKeyboard new
		                  buttonText: 'Si' callbackData: 'requestHarvestQuantity';
		                  buttonText: 'No' callbackData: 'requestHarvestHour'.
	GAFBot singleton
		sendChatMessage: ('La hora que ingresaste es {{hour}}. ¿Confirmar?' asMustacheTemplate
				 value: { ('hour' -> aMessage text ) } asDictionary)
		withInlineKeyboard: inlineKeyboard
		toUser: aMessage from
]

{ #category : #'as yet unclassified' }
HarvestState >> sendPlotsToHarvestList: aCallbackQuery [

	| user |
	user := aCallbackQuery from.
	GAFBot singleton
		sendChatMessage: (self plotsToHarvestListforFarm:
				 (GAFBot singleton farmForTelegramUser: user))
		toUser: user
]

{ #category : #'as yet unclassified' }
HarvestState >> sendQuantityConfirmationForMessage: aMessage [

	| inlineKeyboard |
	inlineKeyboard := TelegramInlineKeyboard new
		                  buttonText: 'Si' callbackData: 'askForHarvestNote';
		                  buttonText: 'No' callbackData: 'requestHarvestQuantity'.
	GAFBot singleton
		sendChatMessage:
			('La cantidad ingresada es: {{quantity}}KG ¿Confirmar?' asMustacheTemplate
				 value: { ('quantity' -> aMessage text)} asDictionary)
		withInlineKeyboard: inlineKeyboard
		to: aMessage from
]
