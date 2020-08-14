Class {
	#name : #EventStatisticsRecord,
	#superclass : #Object,
	#instVars : [
		'crop'
	],
	#category : #'GapAFarm-statistics'
}

{ #category : #'instance creation' }
EventStatisticsRecord class >> for: aCrop [
	^ self new
		for: aCrop;
		yourself
]

{ #category : #accessing }
EventStatisticsRecord >> classToMonitor [
	^ self subclassResponsibility
]

{ #category : #accessing }
EventStatisticsRecord >> crop [
	^ crop
]

{ #category : #initialization }
EventStatisticsRecord >> for: aCrop [
	crop := aCrop
]

{ #category : #updating }
EventStatisticsRecord >> updateThisMonthWith: anEvent from: farm [
	self subclassResponsibility
]

{ #category : #updating }
EventStatisticsRecord >> updateThisWeekWith: anEvent from: farm [
	self subclassResponsibility
]

{ #category : #updating }
EventStatisticsRecord >> updateWith: anEvent from: farm [
	anEvent class ~= self classToMonitor
		ifTrue: [ ^ self ].
	anEvent crop ~= crop
		ifTrue: [ ^ self ].
	anEvent date < (Date today subtractDays: 30)
		ifTrue: [ ^ self ].
	self updateThisMonthWith: anEvent from: farm.
	anEvent date < (Date today subtractDays: 7)
		ifTrue: [ ^ self ].
	self updateThisWeekWith: anEvent from: farm
]
