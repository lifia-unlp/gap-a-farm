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
			self state
				perform: callback asValidSelector , ':'
				with: aCallbackQueryUpdate callbackQuery ]
		ifFalse: [
		self state error: 'Mensaje ' , callback , ' no implementado.' ]
]

{ #category : #'as yet unclassified' }
GAFChat >> handleTextMessage: aMessage forFarm: farm [

	(self state) ifNotNil:[
			^ self state handleTextMessage: aMessage for: self.
		].
	self offerActionsForFarm: farm inResponseTo: aMessage.

	
]

{ #category : #hooks }
GAFChat >> handleVoiceMessage: aMessage [

	self state ifNotNil: [
		^ self state startFrom: aMessage for: self ].
	self harvestingforVoiceMessage: aMessage
]

{ #category : #'as yet unclassified' }
GAFChat >> harvestingforVoiceMessage: aMessage [

	(GAFBot singleton farmForMessage: aMessage) hasPlantedPlots ifFalse: [
		^ aMessage answer: 'No tenés lotes con cultivos.' ].
	state := JSONParseState new.
	state startFrom: aMessage for: self
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

{ #category : #'as yet unclassified' }
GAFChat >> startHarvestingReport: aMessage [

	(GAFBot singleton farmForMessage: aMessage) hasPlantedPlots ifFalse: [
		^ aMessage answer: 'No tenés lotes con cultivos.' ].
	state := WaitingForPlotState new.
	state event: Harvesting new.
	state startFrom: aMessage for: self
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
