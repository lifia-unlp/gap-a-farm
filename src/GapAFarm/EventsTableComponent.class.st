Class {
	#name : #EventsTableComponent,
	#superclass : #GAFAbstractTableWithFilterAndActionsComponent,
	#category : #'GapAFarm-ui-farmer'
}

{ #category : #rendering }
EventsTableComponent >> columnHeadings [
	^ {'Fecha' . 'Lote'} 
]

{ #category : #rendering }
EventsTableComponent >> columnValuesFor: element [
	^ {(element date ddmmyyyy , ' - ' , element time print24WithoutSeconds ).
	element plot id}
]

{ #category : #hooks }
EventsTableComponent >> duplicate: anEvent [
	^ (super duplicate: anEvent)
		plot: nil;
		dateAndTime: nil;
		yourself
]

{ #category : #initialization }
EventsTableComponent >> initialize [
	super initialize.
	removeEnabled := true.
]

{ #category : #callbacks }
EventsTableComponent >> removeElement: element [
	| plot |
	(self
		confirm:
			'¿Está seguro de que quiere borrar ' , (self summaryForEvent: element)
				, '? El cambio no se podrá deshacer.')
		ifFalse: [ ^ self ].
	plot := element plot.
	plot removeEvent: element.
	plot save.
	element remove
]

{ #category : #rendering }
EventsTableComponent >> renderContentOn: html [
	super renderContentOn: html.
	html
		paragraph: [ html small
				class: 'text-muted';
				with:
					'Nota: Los eventos de ciclos anteriores (si existen) se muestran en color mas claro.' ]
]

{ #category : #rendering }
EventsTableComponent >> renderElementRowFor: element class: aCssClass on: html [
	(element plot currentCycle events includes: element)
		ifTrue: [ super
				renderElementRowFor: element
				class: 'current-cycle-event'
				on: html ]
		ifFalse: [ super
				renderElementRowFor: element
				class: 'past-cycle-event'
				on: html ]
]

{ #category : #adding }
EventsTableComponent >> saveAddedElement: anEvent [
	super saveAddedElement: anEvent.
	self session dateAndTimeOfLastAddedEvent: anEvent dateAndTime.
	anEvent plot addEvent: anEvent.
	anEvent plot save.
	"in case the plot changed it on add / not a good Idea anyway"
	super saveAddedElement: anEvent
]

{ #category : #style }
EventsTableComponent >> style [
	^ '	.past-cycle-event {color: silver}
	'
]

{ #category : #callbacks }
EventsTableComponent >> summaryForEvent: element [
	self subclassResponsibility
]
