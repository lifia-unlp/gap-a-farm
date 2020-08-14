Class {
	#name : #Statistics,
	#superclass : #Object,
	#instVars : [
		'sowingStatistics'
	],
	#category : #'GapAFarm-statistics'
}

{ #category : #initialization }
Statistics >> initialize [
	sowingStatistics := Dictionary new
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
	
]

{ #category : #updating }
Statistics >> visitApplication: anApplication on: aFarm [ 
	
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
