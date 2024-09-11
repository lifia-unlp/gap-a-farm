Class {
	#name : #VoiceUpdateState,
	#superclass : #HarvestState,
	#category : #'GapAFarm-telegram'
}

{ #category : #'as yet unclassified' }
VoiceUpdateState >> handleVoiceMessage: aMessage for: aChat [

	| bot extractedParameters next command |
	bot := GAFBot singleton.
	extractedParameters := GptDataExtractor new
		                       extractUpdateHarvestingParametersFrom:
		                       (bot extractTextFrom: aMessage)
		                       for: (bot farmForMessage: aMessage).
	"aMessage answer: extractedParameters."
	command := extractedParameters at: 'field'.
	(self class canPerform: command asValidSelector , ':')
	ifTrue: [ 
		self perform: command asValidSelector , ':' with: extractedParameters ]
		ifFalse: [ 
		aMessage answer: command , ' is not a recognized command' ].
	next := VoiceWaitingConfirmationState new.
	next event: harvestEvent.
	aChat state: next.
	next startFrom: aMessage for: aChat
]

{ #category : #accessing }
VoiceUpdateState >> hour: extractedParameter [

	super hour: (extractedParameter at: 'hour').
]

{ #category : #'as yet unclassified' }
VoiceUpdateState >> startFrom: aMessage for: aChat [

	GAFBot singleton
		sendChatMessage:
		'¿Qué datos te gustaría modificar? Indicame el nombre de cada dato que quieras cambiar: lote, cultivo, hora y cantidad (cultivada en kg). Por ejemplo, para cambiar el lote y la hora podés decir : "Cambio lote por (nombre del nuevo lote) y hora por (nueva hora)."'
		to: aChat
]
