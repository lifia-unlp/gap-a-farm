Class {
	#name : #Application,
	#superclass : #EventOnPlantedPlot,
	#instVars : [
		'substance',
		'machine',
		'quantity',
		'dose'
	],
	#category : #'GapAFarm-model'
}

{ #category : #'instance creation' }
Application class >> date: aDate time: aTime plot: aPlot substance: aSubstance quantity: aQuantity machine: aMachine [
	^ self new
		time: aTime;
		quantity: aQuantity;
		machine: aMachine;
		date: aDate;
		plot: aPlot;
		substance: aSubstance;
		yourself
]

{ #category : #testing }
Application class >> isVoyageRoot [
	^ true
]

{ #category : #accessing }
Application >> dose [
	^ dose
]

{ #category : #accessing }
Application >> dose: anObject [
	dose := anObject
]

{ #category : #queries }
Application >> endOfWaitingPeriodFor: aCrop [
	"Returns the date for the end of the waiting period of  crop - in case not waiting period is necesary, returns the date and time of application.
	
	Raises MissingWithdrawalInformationException the withdrawal perios is needed and has not been set. "

	^ self date addDays: (substance withdrawalTimeFor: aCrop)
]

{ #category : #accessing }
Application >> initialize [
	super initialize.
	machine := ''
]

{ #category : #accessing }
Application >> machine [
	^ machine
]

{ #category : #accessing }
Application >> machine: anObject [
	machine := anObject
]

{ #category : #accessing }
Application >> quantity [
	^ quantity
]

{ #category : #accessing }
Application >> quantity: anObject [
	quantity := anObject
]

{ #category : #accessing }
Application >> substance [
	^ substance
]

{ #category : #accessing }
Application >> substance: anObject [
	substance := anObject
]

{ #category : #printing }
Application >> summaryFor: aSummaryRequestor [
	^ aSummaryRequestor summaryForApplication: self
]
