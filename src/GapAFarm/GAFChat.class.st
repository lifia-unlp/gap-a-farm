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
	self harvestingforMessage: aMessage
	"| sapi bytes text |
	sapi := SpeechToTextApi new.
	sapi isProperlyConfigured ifFalse: [
		^ aMessage answer:
			  'Al parecer, la API de transcripción no está correctamente configurada.' ].

	bytes := (aMessage voice readStreamWith: GAFBot singleton) contents.
	text := sapi transcribeByteArray: bytes.
	aMessage answer: 'Usted dijo: ' , text.

	self state ifNotNil: [
		^ self state handleTranscription: text for: self ].
	self harvestingText: text forMessage: aMessage"
]

{ #category : #'as yet unclassified' }
GAFChat >> harvestingParameters: extractedParameters forMessage: aMessage [

	state := JSONParseState new.
	state parseParameters: extractedParameters for: self
]

{ #category : #'as yet unclassified' }
GAFChat >> harvestingforMessage: aMessage [

	state := JSONParseState new.
	state startFrom: aMessage for: self.
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

	state := WaitingForPlotState new.
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
