Class {
	#name : #VoiceParseState,
	#superclass : #HarvestState,
	#category : #'GapAFarm-telegram'
}

{ #category : #adding }
VoiceParseState >> errorResponseAdd: text [

	errorResponse := errorResponse , text
]

{ #category : #'as yet unclassified' }
VoiceParseState >> handleTextMessage: aMessage for: aChat [

	self notProcesingMessages: aMessage
]

{ #category : #'as yet unclassified' }
VoiceParseState >> handleVoiceMessage: aMessage for: aChat [

	self notProcesingMessages: aMessage
]

{ #category : #initialization }
VoiceParseState >> initialize [

	harvestEvent := Harvesting new.
	errorResponse := ''
]

{ #category : #'as yet unclassified' }
VoiceParseState >> notProcesingMessages: aMessage [

	aMessage answer:
		'No puedo procesar tu mensaje ahora mismo, estoy completando otra tarea. Volvé a intentarlo luego.'
]

{ #category : #parsing }
VoiceParseState >> parseCrop: cropName [

	| crop |
	cropName ifNil: [
		harvestEvent plot ifNotNil: [
			harvestEvent crop ifNil: [
				^ self useCurrentCrop "eventSetDefaultCrop" ] ] ].

	crop := GapAFarm singleton cropNamed: cropName.
	crop isEmpty ifTrue: [
		^ self errorResponseAdd:
			  'No reconozco el nombre de cultivo que indicaste o no se encuentra dentro de los que conozco.' ].

	"Check whether input is different from the current crop. MUST be current!"
	(self cropMatchPlotCurrent: cropName) ifFalse: [
		^ self errorResponseAdd:
			  'El nombre del cultivo que indicaste no coincide con el que actualmente se encuentra en tu lote. ' ].

	harvestEvent crop: crop first

	"self useCurrentCrop"
	"self eventSetDefaultCrop"
]

{ #category : #parsing }
VoiceParseState >> parseHour: hourInput [

	hourInput ifNil: [
		^ self hour:
			  Time now hour24 asString , ':' , Time now minutes asString ].
	(self hourFormatValidation: hourInput) ifFalse: [
		^ self errorResponseAdd:
			  'El horario indicado no es correcto, por favor intentalo de nuevo.' ].
	self hour: hourInput
]

{ #category : #parsing }
VoiceParseState >> parseParameters: extractedParameters for: aChat [

	self
		parsePlot: (extractedParameters at: 'plot' ifAbsent: [ nil ])
		for: aChat.
	self parseCrop: (extractedParameters at: 'crop').
	"Date of the day receiving the message"
	harvestEvent date: Date today.
	self parseHour: (extractedParameters at: 'hour' ifAbsent: [ nil ]).
	self parseQuantity:
		(extractedParameters at: 'quantity' ifAbsent: [ nil ]).
]

{ #category : #parsing }
VoiceParseState >> parsePlot: plotId for: aChat [

	harvestEvent plot ifNil: [
		plotId ifNil: [
			^ self errorResponseAdd: 'Tenés que indicar un lote.' ].

		self plot: plotId for: (GAFBot singleton farmForChat: aChat) ]
]

{ #category : #parsing }
VoiceParseState >> parseQuantity: quantityInput [

	quantityInput ifNil:[
			^ self errorResponseAdd: 'Tenés que indicar la cantidad cosechada.'
		].
	self quantity: quantityInput.
]

{ #category : #initialization }
VoiceParseState >> setErrorResponse: aText [

	self errorResponseAdd: aText
]

{ #category : #'as yet unclassified' }
VoiceParseState >> startFrom: aMessage for: aChat [

	| extractedParameters next bot |
	bot:= GAFBot singleton.
	extractedParameters := GptDataExtractor new
		                       extractHarvestingParametersFrom:
			                       (bot extractTextFrom: aMessage)
		                       for:
		                       (bot farmForMessage: aMessage).
	self parseParameters: extractedParameters for: aChat.
	errorResponse = '' ifFalse: [
		aChat state: nil.
		^ bot sendChatMessage: errorResponse to: aChat ].
	next := VoiceWaitingConfirmationState new.
	next event: harvestEvent.
	aChat state: next.
	next startFrom: aMessage for: aChat
]
