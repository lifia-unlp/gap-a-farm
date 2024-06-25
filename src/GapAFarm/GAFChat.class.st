Class {
	#name : #GAFChat,
	#superclass : #TelegramChat,
	#instVars : [
		'state',
		'summaryFrecuency'
	],
	#category : #'GapAFarm-telegram'
}

{ #category : #'as yet unclassified' }
GAFChat >> handleCallbackQueryUpdate: aCallbackQueryUpdate [

		| callback |
		callback := aCallbackQueryUpdate callbackQuery data.
		(self state class canPerform: callback asValidSelector , ':')
		ifTrue: [ 
		self state perform: callback asValidSelector , ':' with: aCallbackQueryUpdate callbackQuery ]
		ifFalse: [ 
		self state error: 'Mensaje ', callback, ' no implementado.'
			]
]

{ #category : #'as yet unclassified' }
GAFChat >> handleTextMessage: aMessage forFarm: farm [

	(self state) ifNotNil:[
			^ self state handleTextMessage: aMessage.
		].
	self offerActionsForFarm: farm inResponseTo: aMessage.

	
]

{ #category : #hooks }
GAFChat >> offerActionsForFarm: farm inResponseTo: aMessage [

	aMessage answer:
		(GAFBotMessageTemplateFactory new availableCommands
			 asMustacheTemplate value: {  })
]

{ #category : #initialization }
GAFChat >> resetState [

	self state: nil
]

{ #category : #accessing }
GAFChat >> state [

	^state
]

{ #category : #accessing }
GAFChat >> state: anObject [

	state:= anObject.
]

{ #category : #accessing }
GAFChat >> summaryFrecuency [

	^ summaryFrecuency
]

{ #category : #accessing }
GAFChat >> summaryFrecuency: anObject [

	summaryFrecuency := anObject
]
