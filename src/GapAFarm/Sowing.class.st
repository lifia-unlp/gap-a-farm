Class {
	#name : #Sowing,
	#superclass : #Event,
	#instVars : [
		'quantity',
		'cultivarName',
		'timeToHarvest',
		'harvestDuration',
		'expectedYield'
	],
	#category : #'GapAFarm-model'
}

{ #category : #'instance creation' }
Sowing class >> date: aDate time: aTime plot: aPlot crop: aCrop quantity: aQuantity timeToHarvest: aTTH harvestDuration: aHD expectedYield: aEY [
	^ self new
		date: aDate;
		time: aTime;
		crop: aCrop;
		quantity: aQuantity;
		plot: aPlot;
		timeToHarvest: aTTH;
		harvestDuration: aHD;
		expectedYield: aEY;
		yourself
]

{ #category : #testing }
Sowing class >> isVoyageRoot [
	^ true
]

{ #category : #visitor }
Sowing >> acceptVisitor: aVisitor on: aFarm [
	aVisitor visitSowing: self on: aFarm
]

{ #category : #accessing }
Sowing >> cultivarName [
	^ cultivarName
]

{ #category : #accessing }
Sowing >> cultivarName: anObject [
	cultivarName := anObject
]

{ #category : #accessing }
Sowing >> expectedYield [
	^ expectedYield
]

{ #category : #accessing }
Sowing >> expectedYield: anObject [
	expectedYield := anObject
]

{ #category : #accessing }
Sowing >> harvestDate [
	^ self date addDays: timeToHarvest.
]

{ #category : #accessing }
Sowing >> harvestDuration [
	^ harvestDuration
]

{ #category : #accessing }
Sowing >> harvestDuration: anObject [
	harvestDuration := anObject
]

{ #category : #accessing }
Sowing >> harvestPeriod [
	^ self harvestDate addDays: harvestDuration.
]

{ #category : #initializeation }
Sowing >> initialize [
	"initialize only noptional attributes"

	super initialize.
	cultivarName := ''
]

{ #category : #copying }
Sowing >> postCopy [
	super postCopy.
	quantity := quantity copy.
	^ self
]

{ #category : #accessing }
Sowing >> quantity [
	^ quantity
]

{ #category : #accessing }
Sowing >> quantity: anObject [
	quantity := anObject
]

{ #category : #printing }
Sowing >> summaryFor: aSummaryRequestor [
	^ aSummaryRequestor summaryForSowing: self
]

{ #category : #accessing }
Sowing >> timeToHarvest [
	^ timeToHarvest
]

{ #category : #accessing }
Sowing >> timeToHarvest: anObject [
	timeToHarvest := anObject
]
