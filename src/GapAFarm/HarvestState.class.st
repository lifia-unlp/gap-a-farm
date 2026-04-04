Class {
	#name : #HarvestState,
	#superclass : #GAFChatState,
	#instVars : [
		'harvestEvent',
		'inputAttempts',
		'errorResponse',
		'nextState'
	],
	#category : #'GapAFarm-telegram'
}

{ #category : #accessing }
HarvestState >> comment: commentInput [

	harvestEvent comment: commentInput.

	
]

{ #category : #'as yet unclassified' }
HarvestState >> cropMatchPlotCurrent: cropName [

	harvestEvent plot ifNotNil: [
		^ harvestEvent plot currentCrop vulgarName  = cropName ].
	^ true
]

{ #category : #'as yet unclassified' }
HarvestState >> dateFormatValidation: dateInput [

	^ '([1-9]|0[1-9]|[1-2][0-9]|3[0-1])/([1-9]|0[1-9]|1[0-2])/\d*' asRegex matches:
		  dateInput
]

{ #category : #accessing }
HarvestState >> event: anEvent [

	harvestEvent := anEvent 
]

{ #category : #'as yet unclassified' }
HarvestState >> eventSetDefaultCrop [

	harvestEvent crop: (harvestEvent plot currentCrop).
]

{ #category : #'as yet unclassified' }
HarvestState >> failedInputAttempt [

	inputAttempts := inputAttempts - 1.
	^ inputAttempts
]

{ #category : #'as yet unclassified' }
HarvestState >> findPlot: plotId forFarm: aFarm [

	^ aFarm plots detect: [ :each | plotId = each id ] ifNone: [ nil ]
]

{ #category : #'as yet unclassified' }
HarvestState >> handleTextMessage: aMessage for: aChat [

	aMessage answer:
		'Perdón, no puedo responder un mensaje de texto en este momento.'
]

{ #category : #'as yet unclassified' }
HarvestState >> handleVoiceMessage: aMessage for: aChat [

	aMessage answer:
		'Perdón, no puedo responder un mensaje de audio en este momento.'
]

{ #category : #'as yet unclassified' }
HarvestState >> harvestAsDictionary [

	| arr |
	arr := {
		       ('plot' -> harvestEvent plot id).
		       ('crop' -> harvestEvent crop).
		       ('date' -> harvestEvent date ddmmyyyy).
		       ('hour' -> harvestEvent time hour24).
		       ('quantity' -> harvestEvent quantity).
			    "('comment' -> harvestEvent comment)" }.
	^ arr asDictionary
]

{ #category : #accessing }
HarvestState >> hour: hour [

	(self hourFormatValidation: hour) ifFalse: [
		^ self setErrorResponse:
			  'El horario que ingresaste es incorrecto. Volvé a intentarlo.' ].

	harvestEvent time: (Time fromString: hour)
]

{ #category : #'as yet unclassified' }
HarvestState >> hourFormatValidation: hourInput [

	| regex |
	regex := '^(0[0-9]|1[0-9]|2[0-3])\:[0-5][0-9]' asRegex.
	^ regex matches: hourInput
]

{ #category : #initialization }
HarvestState >> initialize [

	inputAttempts := 3. "Default amount of input attempts"
	errorResponse := nil
]

{ #category : #'as yet unclassified' }
HarvestState >> nextStateStartFrom: aMessage for: aChat [

	nextState event: harvestEvent.
	aChat state: nextState.
	nextState startFrom: aMessage for: aChat
]

{ #category : #'as yet unclassified' }
HarvestState >> notProcesingMessages: aMessage [

	aMessage answer:
		'No puedo procesar tu mensaje ahora mismo, estoy completando otra tarea. Volvé a intentarlo luego.'
]

{ #category : #'as yet unclassified' }
HarvestState >> plot: plotId for: farm [

	| plot |
	plot := self findPlot: plotId forFarm: farm.

	plot ifNil: [
		^ self setErrorResponse: 'El lote ingresado es incorrecto. Intentá nuevamente.' ].

	plot currentCrop ifNil: [
		^ self setErrorResponse: 'El lote ingresado no tiene ningún cultivo asociado.' ].

	harvestEvent plot: plot.
]

{ #category : #'as yet unclassified' }
HarvestState >> plotsToHarvestListforFarm: aFarm [

	| plots |
	plots := aFarm plotsWithSowing collect: [ :each |
		         {
			         ('plot' -> each id).
			         ('crop' -> each currentCrop) } asDictionary ].
	^ GAFBotMessageTemplateFactory new harvestingPlotsList
		  asMustacheTemplate value: { ('plots' -> plots) } asDictionary
]

{ #category : #accessing }
HarvestState >> quantity: quantity [

	(self quantityFormatValidation: quantity) ifFalse: [
		^ self setErrorResponse: 'La cantidad debe ser un número.' ].

	harvestEvent quantity: quantity asInteger
]

{ #category : #'as yet unclassified' }
HarvestState >> quantityFormatValidation: quantityInput [

	| regex |
	regex := '\d*' asRegex.
	^ regex matches: quantityInput
]

{ #category : #accessing }
HarvestState >> setDate: aDate [

	| dateStrings |
	(self dateFormatValidation: aDate) ifFalse: [
		^ self setErrorResponse:
			  'La fecha ingresada no tiene un formato correcto.' ].

	dateStrings := aDate substrings: '/'.
	harvestEvent date: (Date
			 newDay: dateStrings first asInteger
			 month: dateStrings second asInteger
			 year: dateStrings third asInteger)
]

{ #category : #initialization }
HarvestState >> setErrorResponse: aText [

	| errorState |

	errorState := ErrorState new.
   errorState setMessage: aText.
	errorState previousState: self.
	nextState := errorState 
]

{ #category : #'as yet unclassified' }
HarvestState >> tooManyFailedAttemptsFor: aChat [

	aChat resetState.
	GAFBot singleton
		sendChatMessage:
		'Demasiados intentos fallidos. Intentalo de nuevo después.'
		to: aChat
]

{ #category : #accessing }
HarvestState >> useCurrentCrop [

	"Event crop MUST be the same as the current crop"
	harvestEvent crop: harvestEvent plot currentCrop.
]
