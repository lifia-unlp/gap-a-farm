Class {
	#name : #WaitingFieldToUpdateState,
	#superclass : #HarvestState,
	#category : #'GapAFarm-telegram'
}

{ #category : #'as yet unclassified' }
WaitingFieldToUpdateState >> handleTextMessage: aMessage for: aChat [

	aMessage text = 'lote' ifTrue: [ self updatePlot: aMessage for: aChat ]
]

{ #category : #'as yet unclassified' }
WaitingFieldToUpdateState >> startFrom: aCallbackQuery for: aChat [

	"| inlineKeyboard |
	inlineKeyboard := TelegramInlineKeyboard new
		                  buttonText: 'Lote' callbackData: 'updatePlot';
		                  buttonText: 'Comentario'
		                  callbackData: 'nada'."

	GAFBot singleton
		sendChatMessage:
		'Decime el nombre del dato que querés modificar: lote, fecha, hora cantidad o comentario.'
		"withInlineKeyboard: inlineKeyboard"
		to: aChat
]

{ #category : #'as yet unclassified' }
WaitingFieldToUpdateState >> updatePlot: aMessage for: aChat [

	| next |
   next := WaitingForPlotState new.
	next event: harvestEvent.
	aChat state: next.
	next startFrom: aMessage for: aChat
	
	
]
