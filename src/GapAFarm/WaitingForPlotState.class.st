Class {
	#name : #WaitingForPlotState,
	#superclass : #HarvestState,
	#instVars : [
		'nextState'
	],
	#category : #'GapAFarm-telegram'
}

{ #category : #'as yet unclassified' }
WaitingForPlotState >> handleTextMessage: aMessage for: aChat [

	| bot response |
	
	bot := GAFBot singleton.
	response := self plot: aMessage text for: (bot farmForMessage: aMessage).
	response ifNotNil: [ 	
			self failedInputAttempt > 0
			ifTrue: [
				^ bot sendChatMessage: response
					  to: aChat ]
			ifFalse: [ ^ self tooManyFailedAttemptsFor: aChat ] ].
	self useCurrentCrop.
	aChat state: nextState.
	nextState event: harvestEvent.
	nextState startFrom: aMessage for: aChat
]

{ #category : #'as yet unclassified' }
WaitingForPlotState >> startFrom: aMessage for: aChat [

	nextState := WaitingForDate new.
	self startMessageFor: aMessage
]

{ #category : #'as yet unclassified' }
WaitingForPlotState >> startMessageFor: aMessage [

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
	self startMessageFor: aMessage 
]
