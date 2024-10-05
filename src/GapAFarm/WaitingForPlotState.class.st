Class {
	#name : #WaitingForPlotState,
	#superclass : #HarvestState,
	#category : #'GapAFarm-telegram'
}

{ #category : #'as yet unclassified' }
WaitingForPlotState >> handleTextMessage: aMessage for: aChat [

	self
		plot: aMessage text
		for: (GAFBot singleton farmForMessage: aMessage).
	self nextStateStartFrom: aMessage for: aChat.
		
]

{ #category : #'as yet unclassified' }
WaitingForPlotState >> plot: aPlot for: farm [

   super plot: aPlot for: farm.
	harvestEvent plot ifNotNil: [ self useCurrentCrop ].
]

{ #category : #'as yet unclassified' }
WaitingForPlotState >> startFrom: aMessage for: aChat [

	nextState := WaitingForDate new.
	self startMessage: aMessage
]

{ #category : #'as yet unclassified' }
WaitingForPlotState >> startMessage: aMessage [

	| bot |
	bot := GAFBot singleton.
	bot
		sendChatMessage:
		(self plotsToHarvestListforFarm: (bot farmForMessage: aMessage))
		toUser: aMessage from
]

{ #category : #'as yet unclassified' }
WaitingForPlotState >> updateFrom: aMessage for: aChat [

	nextState := WaitingConfirmationState new.
	self startMessage: aMessage 
]
