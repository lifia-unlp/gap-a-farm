Class {
	#name : #AdversitiStatisticsRecord,
	#superclass : #EventStatisticsRecord,
	#instVars : [
		'farmsActiveThisMonth',
		'farmsActiveThisWeek',
		'surfaceThisMonth',
		'surfaceThisWeek'
	],
	#category : #'GapAFarm-statistics'
}

{ #category : #accessing }
AdversitiStatisticsRecord >> classToMonitor [
	^ AdversityReport
]

{ #category : #accessing }
AdversitiStatisticsRecord >> eventElementOf: anAdversityReport [
	^anAdversityReport descriptionOfAdversities 
]

{ #category : #accessing }
AdversitiStatisticsRecord >> farmsActiveThisMonth [
	^ farmsActiveThisMonth
]

{ #category : #accessing }
AdversitiStatisticsRecord >> farmsActiveThisWeek [
	^ farmsActiveThisWeek
]

{ #category : #accessing }
AdversitiStatisticsRecord >> haveActivity [
	^farmsActiveThisMonth isNotEmpty 
]

{ #category : #initialization }
AdversitiStatisticsRecord >> initialize [
	farmsActiveThisMonth := Set new.
	farmsActiveThisWeek := Set new.
	surfaceThisMonth := 0.
	surfaceThisWeek := 0
]

{ #category : #accessing }
AdversitiStatisticsRecord >> surfaceThisMonth [
	^ surfaceThisMonth
]

{ #category : #accessing }
AdversitiStatisticsRecord >> surfaceThisWeek [
	^ surfaceThisWeek
]

{ #category : #updating }
AdversitiStatisticsRecord >> updateThisMonthWith: anEvent from: farm [
	surfaceThisMonth := surfaceThisMonth + anEvent plot surface.
	farmsActiveThisMonth add: farm
]

{ #category : #updating }
AdversitiStatisticsRecord >> updateThisWeekWith: anEvent from: farm [
	surfaceThisWeek := surfaceThisWeek + anEvent plot surface.
	farmsActiveThisWeek add: farm
]
