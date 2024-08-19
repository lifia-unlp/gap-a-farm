Class {
	#name : #WaitingForPlotState,
	#superclass : #HarvestState,
	#category : #'GapAFarm-telegram'
}

{ #category : #'as yet unclassified' }
WaitingForPlotState >> handleTextMessage: aMessage for: aChat [

	| bot next plot |
	bot := GAFBot singleton.
	plot := self
		        findPlot: aMessage text
		        forFarm: (bot farmForMessage: aMessage).
	plot ifNil: [
		self failedInputAttempt > 0
			ifTrue: [
				^ bot
					  sendChatMessage:
					  'El lote ingresado es incorrecto. Intentá nuevamente.'
					  to: aChat ]
			ifFalse: [ ^ self tooManyFailedAttemptsFor: aChat ] ].
	plot currentCrop ifNil: [
		self failedInputAttempt > 0
			ifTrue: [
				^ bot
					  sendChatMessage:
					  'El lote ingresado no tiene ningún cultivo asociado.'
					  to: aChat ]
			ifFalse: [ ^ self tooManyFailedAttemptsFor: aChat ] ].
	next := self nextState.
	self plot: plot crop: plot currentCrop.
	aChat state: next.
	next event: harvestEvent.
	next startFrom: aMessage for: aChat
]

{ #category : #accessing }
WaitingForPlotState >> nextState [

	harvestEvent plot ifNil: [ ^ WaitingForDate new ].
	^ WaitingConfirmationState new
]

{ #category : #'as yet unclassified' }
WaitingForPlotState >> startFrom: aMessage for: aChat [

	| bot |
	bot := GAFBot singleton.
	bot
		sendChatMessage:
		(self plotsToHarvestListforFarm: (bot farmForMessage: aMessage))
		toUser: aMessage from
]
