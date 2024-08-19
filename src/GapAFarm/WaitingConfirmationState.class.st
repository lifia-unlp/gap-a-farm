Class {
	#name : #WaitingConfirmationState,
	#superclass : #HarvestState,
	#category : #'GapAFarm-telegram'
}

{ #category : #'as yet unclassified' }
WaitingConfirmationState >> confirmHarvest: aCallbackQueryUpdate [

	| chat |
	chat := GAFBot singleton chatForTelegramUser: aCallbackQueryUpdate from.
	chat state: nil.

	harvestEvent plot addEvent: harvestEvent.

	GAFBot singleton
		sendChatMessage: 'Se reportó correctamente su cosecha.'
		toUser: aCallbackQueryUpdate from
]

{ #category : #'as yet unclassified' }
WaitingConfirmationState >> handleTextMessage: aMessage for: aChat [

	aMessage answer: 'Aún no confirmaste la información sobre tu cosecha.'
]

{ #category : #'as yet unclassified' }
WaitingConfirmationState >> startFrom: aMessage for: aChat [

	| inlineKeyboard |
	inlineKeyboard := TelegramInlineKeyboard new
		                  buttonText: 'Sí' callbackData: 'confirmHarvest';
		                  buttonText: 'No' callbackData: 'modifyHarvest'.

	GAFBot singleton
		sendChatMessage:
			(GAFBotMessageTemplateFactory new harvestingConfirmationTextMessage
				 asMustacheTemplate value: {
					 ('plot' -> harvestEvent plot id).
					 ('crop' -> harvestEvent crop).
					 ('date' -> harvestEvent date ddmmyyyy).
					 ('hour' -> harvestEvent time hour24 ).
					 ('quantity' -> harvestEvent quantity).
					 ('comment' -> harvestEvent comment) } asDictionary)
		withInlineKeyboard: inlineKeyboard
		toUser: aMessage from
]
