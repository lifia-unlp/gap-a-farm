Class {
	#name : #HarvestState,
	#superclass : #GAFChatState,
	#instVars : [
		'harvestEvent'
	],
	#category : #'GapAFarm-telegram'
}

{ #category : #accessing }
HarvestState >> comment: commentInput [

	harvestEvent comment: commentInput.

	
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
HarvestState >> findPlot: plotId forFarm: aFarm [

	^ aFarm plots detect: [ :each | plotId = each id ] ifNone: [ nil ]
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

{ #category : #'as yet unclassified' }
HarvestState >> plot: plot crop: crop [

  harvestEvent plot: plot; crop: crop.
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
