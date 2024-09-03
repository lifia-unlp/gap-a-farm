Class {
	#name : #HarvestState,
	#superclass : #GAFChatState,
	#instVars : [
		'harvestEvent',
		'inputAttempts'
	],
	#category : #'GapAFarm-telegram'
}

{ #category : #accessing }
HarvestState >> comment: commentInput [

	harvestEvent comment: commentInput.

	
]

{ #category : #'as yet unclassified' }
HarvestState >> cropMatchPlotCurrent: cropName [

	^ harvestEvent plot currentCrop vulgarName  = cropName 
]

{ #category : #accessing }
HarvestState >> date: aDate [

	| dateStrings |

	dateStrings := aDate substrings: '/'.
	harvestEvent date: (Date
			 newDay: dateStrings first asInteger
			 month: dateStrings second asInteger
			 year: dateStrings third asInteger)
]

{ #category : #'as yet unclassified' }
HarvestState >> dateFormatValidation: dateInput [

	| regex |
	
	regex := '([0-2][1-9]|3[0-1])/(0[1-9]|1[0-2])/\d*' asRegex.
   ^ regex matches: dateInput 
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
HarvestState >> harvestAsDictionary [

	| arr |
	arr := {
		       ('plot' -> harvestEvent plot id).
		       ('crop' -> harvestEvent crop).
		       ('date' -> harvestEvent date ddmmyyyy).
		       ('hour' -> harvestEvent time hour24).
		       ('quantity' -> harvestEvent quantity) }.

	harvestEvent comment = '' ifFalse: [
		arr with: 'comment' -> harvestEvent comment ].
	^ arr asDictionary
]

{ #category : #accessing }
HarvestState >> hour: hour [

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
]

{ #category : #'as yet unclassified' }
HarvestState >> plot: plot crop: crop [

  harvestEvent plot: plot; crop: crop.
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

	harvestEvent quantity: quantity asInteger.
]

{ #category : #'as yet unclassified' }
HarvestState >> quantityFormatValidation: quantityInput [

	| regex |
	regex := '\d*' asRegex.
	^ regex matches: quantityInput
]

{ #category : #'as yet unclassified' }
HarvestState >> tooManyFailedAttemptsFor: aChat [

	aChat resetState.
	GAFBot singleton
		sendChatMessage:
		'Demasiados intentos fallidos. Intentalo de nuevo después.'
		to: aChat
]
