Class {
	#name : #VoiceParseState,
	#superclass : #HarvestState,
	#instVars : [
		'response'
	],
	#category : #'GapAFarm-telegram'
}

{ #category : #adding }
VoiceParseState >> errorResponseAdd: text [

	response := response , text
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
	response := ''
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
		^ harvestEvent crop ifNil: [ ^ self eventSetDefaultCrop ] ].

	crop := GapAFarm singleton cropNamed: cropName.
	crop ifNil: [
		^ self errorResponseAdd:
			  'No reconozco el nombre de cultivo que indicaste o no se encuentra dentro de los que conozco.' ].

	"Check whether input is different from the current crop. MUST be current!"
	(self cropMatchPlotCurrent: cropName) ifFalse: [
		^ self errorResponseAdd:
			  'El nombre del cultivo que indicaste no coincide con el que actualmente se encuentra en tu lote. ' ].

	self eventSetDefaultCrop
]

{ #category : #parsing }
VoiceParseState >> parseHour: hourInput [

	hourInput ifNil: [ ^ self hour: (Time now hour24 asString,':',Time now minutes asString ) ].
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
	self parseCrop: (extractedParameters at: 'crop' ifAbsent: [ nil ]).
	"Date of the day receiving the message"
	harvestEvent date: Date today.
	self parseHour: (extractedParameters at: 'hour' ifAbsent: [ nil ]).
	self parseQuantity:
		((extractedParameters at: 'quantity' ifAbsent: [ nil ]) at: 'value').
]

{ #category : #parsing }
VoiceParseState >> parsePlot: plotId for: aChat [

	| plot |
	harvestEvent plot ifNil: [
		plotId ifNil: [
			^ self errorResponseAdd: 'Tenés que indicar un lote.' ].

		plot := self
			        findPlot: plotId
			        forFarm: (GAFBot singleton farmForChat: aChat).
		plot ifNil: [
			^ self errorResponseAdd:
				  'El lote indicado no es correcto. Indique nuevamente el nombre.' ].
		plot currentCrop ifNil: [
			^ self errorResponseAdd:
				  'El lote indicado no tiene ningún cultivo en este momento.' ].
		harvestEvent plot: plot ]
]

{ #category : #parsing }
VoiceParseState >> parseQuantity: quantityInput [

	quantityInput ifNil:[
			^ response errorResponseAdd: 'Tenés que indicar la cantidad cosechada.'
		].
	self quantity: quantityInput.
]

{ #category : #'as yet unclassified' }
VoiceParseState >> startFrom: aMessage for: aChat [

	| extractedParameters next |
	extractedParameters := GptDataExtractor new
		                       extractHarvestingParametersFrom:
		                       (super
			                        handleVoiceMessage: aMessage
			                        for: aChat)
		                       for:
		                       (GAFBot singleton farmForMessage: aMessage).
	self parseParameters: extractedParameters for: aChat.
	response = '' ifFalse: [
		^ GAFBot singleton sendChatMessage: response to: aChat ].
	next := VoiceWaitingConfirmationState new.
	next event: harvestEvent.
	aChat state: next.
	next startFrom: aMessage for: aChat
]
