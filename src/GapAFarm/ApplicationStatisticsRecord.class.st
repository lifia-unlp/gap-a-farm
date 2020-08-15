Class {
	#name : #ApplicationStatisticsRecord,
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
ApplicationStatisticsRecord >> classToMonitor [
	^ Application 
]

{ #category : #accessing }
ApplicationStatisticsRecord >> eventElementOf: anApplication [
	^anApplication substance 
]

{ #category : #accessing }
ApplicationStatisticsRecord >> farmsActiveThisMonth [
	^ farmsActiveThisMonth
]

{ #category : #accessing }
ApplicationStatisticsRecord >> farmsActiveThisWeek [
	^ farmsActiveThisWeek
]

{ #category : #accessing }
ApplicationStatisticsRecord >> haveActivity [
	^farmsActiveThisMonth isNotEmpty 
]

{ #category : #initialization }
ApplicationStatisticsRecord >> initialize [
	quantityThisMonth := 0.
	quantityThisWeek := 0.
	farmsActiveThisMonth := Set new.
	farmsActiveThisWeek := Set new.
	surfaceThisMonth := 0.
	surfaceThisWeek := 0
]

{ #category : #accessing }
ApplicationStatisticsRecord >> quantityThisMonth [
	^ quantityThisMonth
]

{ #category : #accessing }
ApplicationStatisticsRecord >> quantityThisWeek [
	^ quantityThisWeek
]

{ #category : #accessing }
ApplicationStatisticsRecord >> surfaceThisMonth [
	^ surfaceThisMonth
]

{ #category : #accessing }
ApplicationStatisticsRecord >> surfaceThisWeek [
	^ surfaceThisWeek
]

{ #category : #updating }
ApplicationStatisticsRecord >> updateThisMonthWith: anEvent from: farm [
	quantityThisMonth := quantityThisMonth + anEvent quantity.
	surfaceThisMonth := surfaceThisMonth + anEvent plot surface.
	farmsActiveThisMonth add: farm
]

{ #category : #updating }
ApplicationStatisticsRecord >> updateThisWeekWith: anEvent from: farm [
	quantityThisWeek := quantityThisWeek + anEvent quantity.
	surfaceThisWeek := surfaceThisWeek + anEvent plot surface.
	farmsActiveThisWeek add: farm
]
