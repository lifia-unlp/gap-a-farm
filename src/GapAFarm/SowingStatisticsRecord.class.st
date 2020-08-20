Class {
	#name : #SowingStatisticsRecord,
	#superclass : #EventStatisticsRecord,
	#instVars : [
		'quantityThisMonth',
		'quantityThisWeek',
		'farmsActiveThisMonth',
		'farmsActiveThisWeek',
		'surfaceThisMonth',
		'surfaceThisWeek'
	],
	#category : #'GapAFarm-statistics'
}

{ #category : #accessing }
SowingStatisticsRecord >> classToMonitor [
	^ Sowing
]

{ #category : #accessing }
SowingStatisticsRecord >> eventElementOf: aSowing [
	^aSowing crop
	
]

{ #category : #accessing }
SowingStatisticsRecord >> farmsActiveThisMonth [
	^ farmsActiveThisMonth
]

{ #category : #accessing }
SowingStatisticsRecord >> farmsActiveThisWeek [
	^ farmsActiveThisWeek
]

{ #category : #accessing }
SowingStatisticsRecord >> haveActivity [
	^farmsActiveThisMonth isNotEmpty 
]

{ #category : #initialization }
SowingStatisticsRecord >> initialize [
	quantityThisMonth := 0.
	quantityThisWeek := 0.
	farmsActiveThisMonth := Set new.
	farmsActiveThisWeek := Set new.
	surfaceThisMonth := 0.
	surfaceThisWeek := 0
]

{ #category : #accessing }
SowingStatisticsRecord >> quantityThisMonth [
	^ quantityThisMonth
]

{ #category : #accessing }
SowingStatisticsRecord >> quantityThisWeek [
	^ quantityThisWeek
]

{ #category : #accessing }
SowingStatisticsRecord >> surfaceThisMonth [
	^ surfaceThisMonth
]

{ #category : #accessing }
SowingStatisticsRecord >> surfaceThisWeek [
	^ surfaceThisWeek
]

{ #category : #updating }
SowingStatisticsRecord >> updateThisMonthWith: anEvent from: farm [
	quantityThisMonth := quantityThisMonth + anEvent quantity magnitude.
	surfaceThisMonth := surfaceThisMonth + anEvent plot surface.
	farmsActiveThisMonth add: farm
]

{ #category : #updating }
SowingStatisticsRecord >> updateThisWeekWith: anEvent from: farm [
	quantityThisWeek := quantityThisWeek + anEvent quantity magnitude.
	surfaceThisWeek := surfaceThisWeek + anEvent plot surface.
	farmsActiveThisWeek add: farm
]
