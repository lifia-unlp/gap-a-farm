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
GAFChat >> detectVoiceCommandFor: aMessage [

	| extractedParameters bot command|
	bot := GAFBot singleton.
	extractedParameters := GptDataExtractor new
		                       extractCommandFrom:
			                       (bot extractTextFrom: aMessage).
	command := (extractedParameters at: 'command').
	"aMessage answer: (extractedParameters at: 'command')."
	(self class canPerform: command asValidSelector , ':')
		ifTrue: [
			self
				perform: command asValidSelector , ':'
				with: aMessage ]
		ifFalse: [
		self error: 'Mensaje ' , command , ' no implementado.' ]
]

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
		^ self state handleVoiceMessage: aMessage for: self ].
	self detectVoiceCommandFor: aMessage
]

{ #category : #'as yet unclassified' }
GAFChat >> harvestingForVoiceMessage: aMessage [

	(GAFBot singleton farmForMessage: aMessage) hasPlantedPlots ifFalse: [
		^ aMessage answer: 'No tenés lotes con cultivos.' ].
	state := WaitingVoiceHarvestParams new.
	state startFrom: aMessage for: self
]

{ #category : #'as yet unclassified' }
GAFChat >> harvestingWithParamsForVoiceMessage: aMessage [

	(GAFBot singleton farmForMessage: aMessage) hasPlantedPlots ifFalse: [
		^ aMessage answer: 'No tenés lotes con cultivos.' ].
	state := VoiceHarvestState new.
	state startFrom: aMessage for: self
]

{ #category : #hooks }
GAFChat >> offerActionsForFarm: farm inResponseTo: aMessage [

	aMessage answer:
		(GAFBotMessageTemplateFactory new availableCommands
			 asMustacheTemplate value: {  })
]

{ #category : #'as yet unclassified' }
GAFChat >> offerVoiceActions: aMessage [

	aMessage answer: '	Probá pedirme algo como: "Quiero realizar una cosecha."'
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

{ #category : #tests }
GAFChat >> testGPTMemory: aMessage [

	aMessage answer: GptDataExtractor new memoryTest 
]
