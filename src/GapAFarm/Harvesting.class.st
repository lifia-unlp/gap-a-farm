Class {
	#name : #Harvesting,
	#superclass : #Event,
	#instVars : [
		'quantity',
		'cultivarName',
		'otherUnit'
	],
	#category : #'GapAFarm-model'
}

{ #category : #'instance creation' }
Harvesting class >> date: aDate time: aTime plot: aPlot crop: aCrop quantity: aQuantity [
	^ self new
		date: aDate;
		time: aTime;
		crop: aCrop;
		quantity: aQuantity;
		plot: aPlot;
		yourself
]

{ #category : #testing }
Harvesting class >> isVoyageRoot [
	^ true
]

{ #category : #constants }
Harvesting class >> units [
	^ (OrderedCollection
		with: 'Cajones'
		with: 'Paquetes'
		with: 'Canastos'
		with: 'Razos') copy
]

{ #category : #visitor }
Harvesting >> acceptVisitor: aVisitor on: aFarm [
	aVisitor visitHarvesting: self on: aFarm
]

{ #category : #accessing }
Harvesting >> cultivarName [
	^ cultivarName
]

{ #category : #accessing }
Harvesting >> cultivarName: anObject [
	cultivarName := anObject
]

{ #category : #initialization }
Harvesting >> initialize [
	"initialize only noptional attributes"

	super initialize.
	cultivarName := ''.
	otherUnit := Measurement magnitude: 0 unit: Harvesting units first
]

{ #category : #testing }
Harvesting >> isEvent: aName [
	^ aName = 'harvest'
]

{ #category : #accessing }
Harvesting >> otherUnit [
	^ otherUnit
]

{ #category : #accessing }
Harvesting >> otherUnit: anObject [
	otherUnit := anObject
]

{ #category : #copying }
Harvesting >> postCopy [
	super postCopy.
	quantity := quantity copy.
	otherUnit := otherUnit copy.
	^ self
]

{ #category : #accessing }
Harvesting >> quantity [
	^ quantity
]

{ #category : #accessing }
Harvesting >> quantity: anObject [
	quantity := anObject
]

{ #category : #printing }
Harvesting >> summaryFor: aSummaryRequestor [
	^ aSummaryRequestor summaryForHarvesting: self
]
