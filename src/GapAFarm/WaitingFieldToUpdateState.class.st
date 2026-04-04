Class {
	#name : #WaitingFieldToUpdateState,
	#superclass : #HarvestState,
	#category : #'GapAFarm-telegram'
}

{ #category : #'as yet unclassified' }
WaitingFieldToUpdateState >> handleTextMessage: aMessage for: aChat [

	| option |
	option := aMessage text.
	(self optionValidation: option) ifFalse: [
		self setErrorResponse:
			  'El número que indicaste no es una opción válida. Volvé a intentarlo.'.
			^ self nextStateStartFrom: aMessage  for: aChat  ].
	nextState := self updateOptions at: option.
	nextState event: harvestEvent.
	aChat state: nextState.
	nextState updateFrom: aMessage for: aChat
]

{ #category : #'as yet unclassified' }
WaitingFieldToUpdateState >> optionValidation: option [

	| regex |
	regex := '[1-4]' asRegex.
	^ regex matches: option
]

{ #category : #'as yet unclassified' }
WaitingFieldToUpdateState >> startFrom: aCallbackQuery for: aChat [

	GAFBot singleton
		sendChatMessage:
		'Indicame el número del dato que querés modificar: 1: lote, 2: fecha, 3: hora o 4: cantidad.'
		to: aChat
]

{ #category : #'as yet unclassified' }
WaitingFieldToUpdateState >> updateOptions [

	| options |
	options := {
		           ('1' -> WaitingForPlotState new).
		           ('2' -> WaitingForDate new).
		           ('3' -> WaitingForHour new).
		           ('4' -> WaitingForQuantity new) }.
	^ options asDictionary
]
