Class {
	#name : #AdversityReport,
	#superclass : #EventOnPlantedPlot,
	#instVars : [
		'descriptionOfAdversities',
		'adversityTypes'
	],
	#category : #'GapAFarm-model'
}

{ #category : #'instance creation' }
AdversityReport class >> date: aDate time: aTime plot: aPlot description: descriptionOfAdversities types: adversityTypes [ 
	^ self new
		date: aDate;
		time: aTime;
		plot: aPlot;
		descriptionOfAdversities:  descriptionOfAdversities;
		adversityTypes: adversityTypes;
		yourself
]

{ #category : #testing }
AdversityReport class >> isVoyageRoot [
	^ true
]

{ #category : #constants }
AdversityReport class >> types [
	"types of possible problems"

	^ #('Ácaros' 'Enfermedad' 'Hongos' 'Insectos' 'Malezas' 'Carencia nutricional' 'Nemátodos' 'Otro')
]

{ #category : #accessing }
AdversityReport >> adversityTypes [
	^ adversityTypes
]

{ #category : #accessing }
AdversityReport >> adversityTypes: anObject [
	adversityTypes := anObject
]

{ #category : #accessing }
AdversityReport >> descriptionOfAdversities [
	^ descriptionOfAdversities
]

{ #category : #accessing }
AdversityReport >> descriptionOfAdversities: anObject [
	descriptionOfAdversities := anObject
]

{ #category : #initialization }
AdversityReport >> initialize [
	super initialize.
	adversityTypes := OrderedCollection new.
	descriptionOfAdversities := ''
]

{ #category : #printing }
AdversityReport >> summaryFor: aSummaryRequestor [
	^ aSummaryRequestor summaryForAdversityReport: self
]
