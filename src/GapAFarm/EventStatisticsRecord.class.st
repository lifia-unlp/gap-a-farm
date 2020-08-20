Class {
	#name : #EventStatisticsRecord,
	#superclass : #Object,
	#instVars : [
		'element'
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
EventStatisticsRecord >> element [
	^ element
]

{ #category : #accessing }
EventStatisticsRecord >> eventElementOf: anEvent [
	self subclassResponsibility
]

{ #category : #initialization }
EventStatisticsRecord >> for: anElement [
	element := anElement
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
	(self eventElementOf: anEvent) ~= element
		ifTrue: [ ^ self ].
	anEvent date < (Date today subtractDays: 30)
		ifTrue: [ ^ self ].
	self updateThisMonthWith: anEvent from: farm.
	anEvent date < (Date today subtractDays: 7)
		ifTrue: [ ^ self ].
	self updateThisWeekWith: anEvent from: farm
]
