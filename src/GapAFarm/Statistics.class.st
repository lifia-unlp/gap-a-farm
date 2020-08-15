Class {
	#name : #Statistics,
	#superclass : #Object,
	#instVars : [
		'sowingStatistics',
		'applicationStatistics',
		'adversityStatistics'
	],
	#category : #'GapAFarm-statistics'
}

{ #category : #accessing }
Statistics >> adversityStatistics [
	^ adversityStatistics
]

{ #category : #accessing }
Statistics >> applicationStatistics [
	^ applicationStatistics
]

{ #category : #initialization }
Statistics >> initialize [
	sowingStatistics := Dictionary new.
	applicationStatistics := Dictionary new.
	adversityStatistics := Dictionary new
]

{ #category : #accessing }
Statistics >> sowingStatistics [
	^ sowingStatistics
]

{ #category : #updating }
Statistics >> updateWith: aGapAFarm [
	aGapAFarm farms do: [ :each | self visit: each ]
]

{ #category : #updating }
Statistics >> visit: aFarm [
	aFarm events do: [ :each | each acceptVisitor: self on: aFarm ]
]

{ #category : #updating }
Statistics >> visitAdversityReport: anAdversityReport on: aFarm [ 
	(adversityStatistics 
		at: anAdversityReport descriptionOfAdversities
		ifAbsentPut: (AdversitiStatisticsRecord for: anAdversityReport descriptionOfAdversities ))
		updateWith: anAdversityReport
		from: aFarm
	
]

{ #category : #updating }
Statistics >> visitApplication: anApplication on: aFarm [ 
	(applicationStatistics
		at: anApplication substance
		ifAbsentPut: (ApplicationStatisticsRecord for: anApplication substance ))
		updateWith: anApplication
		from: aFarm
	
]

{ #category : #updating }
Statistics >> visitCropSale: anAdversityReport on: aFarm [ 
	
]

{ #category : #updating }
Statistics >> visitHarvesting: aHarvesting on: aFarm [ 

]

{ #category : #updating }
Statistics >> visitSowing: aSowing on: aFarm [
	(sowingStatistics
		at: aSowing crop
		ifAbsentPut: (SowingStatisticsRecord for: aSowing crop))
		updateWith: aSowing
		from: aFarm
]
