Class {
	#name : #EventEditor,
	#superclass : #GAFEditor,
	#instVars : [
		'dateEditorComponent',
		'plotEditorComponent',
		'timeEditorComponent'
	],
	#category : #'GapAFarm-ui-editors'
}

{ #category : #'subclass-responsibility' }
EventEditor >> children [
	^ {dateEditorComponent.
	timeEditorComponent.
	plotEditorComponent} , self eventSpecificChildren, super children
]

{ #category : #'subclass-responsibility' }
EventEditor >> eventSpecificChildren [
	^ self subclassResponsibility
]

{ #category : #initialization }
EventEditor >> initializeComponents [
	"Initialize all property components"

	super initializeComponents.
	self initializeDateEditorComponent.
	self initializeTimeEditorComponent.
	self initializePlotEditorComponent.
	self suggestDateAndTimeIfMissing
]

{ #category : #initialization }
EventEditor >> initializeDateEditorComponent [
	dateEditorComponent := DatePropertyEditorComponent
		id: 'date'
		subject: subject
		selector: #date
		label: 'Fecha'
		required: true.
	subject date ifNotNil: [ dateEditorComponent readOnly: true ]
]

{ #category : #'subclass-responsibility' }
EventEditor >> initializePlotEditorComponent [
	plotEditorComponent := DropdownSelectPropertyEditorComponent
		id: 'plotSelector'
		subject: subject
		selector: #plot
		label: 'Lote - Cultivo presente'
		required: true.
	plotEditorComponent
		possibleValuesBlock: [ {nil} , self plots ];
		labelsBlock: [ :each | self labelForPlot: each ].
	subject plot ifNotNil: [ plotEditorComponent readOnly: true. ]
]

{ #category : #initialization }
EventEditor >> initializeTimeEditorComponent [
	timeEditorComponent := TimeStringPropertyEditorComponent
		id: 'time'
		subject: subject
		selector: #time
		label: 'Hora'
		required: true.
	subject time ifNotNil: [ timeEditorComponent readOnly: true ]
]

{ #category : #initialization }
EventEditor >> labelForPlot: each [
	| daysLeft |
	each ifNil: [ ^ '' ].
	^ String
		streamContents: [ :stream | 
			stream nextPutAll: each id.
			each currentCycle latestSowing
				ifNotNil: [ :it | 
					stream
						nextPutAll: ' - ';
						nextPutAll: it crop vulgarName ].
			daysLeft := [ each withdrawalPeriodDaysLeft ]
				on: MissingWithdrawalInformationException
				do: [ nil ].
			daysLeft
				ifNil: [ stream nextPutAll: ' (en carencia por tiempo desconocido)' ]
				ifNotNil: [ daysLeft > 0
						ifTrue: [ stream
								nextPutAll: ' (en carencia por ';
								nextPutAll: daysLeft printString;
								nextPutAll: ' días más)' ] ] ]
]

{ #category : #accessing }
EventEditor >> plots [
	^ self session farm plots asOrderedCollection
]

{ #category : #initialization }
EventEditor >> suggestDateAndTimeIfMissing [
	| dateAndTimeOfLastAddedEvent |
	dateAndTimeOfLastAddedEvent := self session
		dateAndTimeOfLastAddedEvent.
	dateAndTimeOfLastAddedEvent ifNil: [ ^ self ].
	dateEditorComponent bufferedValue
		ifNil: [ dateEditorComponent
				bufferedValue: dateAndTimeOfLastAddedEvent asDate ].
	timeEditorComponent bufferedValue
		ifNil: [ timeEditorComponent
				bufferedValue: dateAndTimeOfLastAddedEvent asTime ]
]
