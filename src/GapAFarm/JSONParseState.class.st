Class {
	#name : #JSONParseState,
	#superclass : #HarvestState,
	#instVars : [
		'response'
	],
	#category : #'GapAFarm-telegram'
}

{ #category : #adding }
JSONParseState >> errorResponseAdd: text [

	response := response , text
]

{ #category : #initialization }
JSONParseState >> initialize [

	harvestEvent := Harvesting new.
	response := ''
]

{ #category : #parsing }
JSONParseState >> parseParameters: extractedParameters for: aChat [

	self
		parsePlot: (extractedParameters at: 'plot' ifAbsent: [ nil ])
		for: aChat
]

{ #category : #parsing }
JSONParseState >> parsePlot: plotId for: aChat [

	| plot |
	plotId
		ifNil: [
			harvestEvent plot ifNil: [
				self errorResponseAdd: 'Debe ingresar un lote' ] ]
		ifNotNil: [
			harvestEvent plot ifNil: [
				plot := self
					        findPlot: plotId
					        forFarm: (GAFBot singleton farmForChat: aChat).
				plot
					ifNil: [
						self errorResponseAdd:
							'El lote indicado no es correcto. Indique nuevamente el nombre.' ]
					ifNotNil: [
						harvestEvent plot: plot.
						response := 'ok' ] ] ]
]

{ #category : #'as yet unclassified' }
JSONParseState >> startFrom: aMessage for: aChat [

	| extractedParameters |
	extractedParameters := GptDataExtractor new
		                       extractHarvestingParametersFrom:
		                       (super
			                        handleVoiceMessage: aMessage
			                        for: aChat)
		                       for:
		                       (GAFBot singleton farmForMessage: aMessage).
	self parseParameters: extractedParameters  for: aChat.
	aMessage answer: response.
	"aMessage answer: 'Usted dijo: ' , text."
	"aMessage answer: 'Pude entender que: ' , extractedParameters asJson."
	aChat state: nil
]
