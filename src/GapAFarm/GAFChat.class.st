Class {
	#name : #GAFChat,
	#superclass : #TelegramChat,
	#category : #'GapAFarm-telegram'
}

{ #category : #'as yet unclassified' }
GAFChat >> handleTextMessage: aMessage forFarm: farm [

	self offerActionsForFarm: farm inResponseTo: aMessage.

	
]

{ #category : #hooks }
GAFChat >> offerActionsForFarm: farm inResponseTo: aMessage [

	aMessage answer:
		(GAFBotMessageTemplateFactory new availableCommands
			 asMustacheTemplate value: {  })
]
