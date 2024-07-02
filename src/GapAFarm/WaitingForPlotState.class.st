Class {
	#name : #WaitingForPlotState,
	#superclass : #HarvestState,
	#category : #'GapAFarm-telegram'
}

{ #category : #'as yet unclassified' }
WaitingForPlotState >> handleTextMessage: aMessage for: aChat [

	| plot next bot |
	bot := GAFBot singleton.
	plot := (bot farmForMessage: aMessage) plots
		        detect: [ :each | aMessage text = each id ]
		        ifNone: [ nil ].
	plot
		ifNil: [
			bot
				sendChatMessage:
				'El lote ingresado es incorrecto. Intentá nuevamente.'
				to: aChat ]
		ifNotNil: [
			harvestEvent
				plot: plot;
				crop: plot currentCrop.
			next := WaitingForDate new.
			aChat state: next.
			next event: harvestEvent.
			next startFrom: aMessage for: aChat ]
]

{ #category : #initialization }
WaitingForPlotState >> initialize [

	harvestEvent := Harvesting new.
]

{ #category : #'as yet unclassified' }
WaitingForPlotState >> plotsToHarvestListforFarm: aFarm [

	| plots |
	plots := aFarm plotsWithSowing collect: [ :each |
		         {
			         ('plot' -> each id).
			         ('crop' -> each currentCrop) } asDictionary ].
	^ GAFBotMessageTemplateFactory new harvestingPlotsList
		  asMustacheTemplate value: { ('plots' -> plots) } asDictionary
]

{ #category : #'as yet unclassified' }
WaitingForPlotState >> startFrom: aMessage for: aChat [

		| bot |
		bot := GAFBot singleton.
		bot 
		sendChatMessage:
		(self plotsToHarvestListforFarm: (bot farmForMessage: aMessage ))
		toUser: aMessage from
]
