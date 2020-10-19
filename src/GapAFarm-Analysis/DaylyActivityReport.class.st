Class {
	#name : #DaylyActivityReport,
	#superclass : #ActivityReport,
	#instVars : [
		'date',
		'eventCounts'
	],
	#category : #'GapAFarm-Analysis'
}

{ #category : #'instance creation' }
DaylyActivityReport class >> with: anEvent [
	^ self new
		updateWith: anEvent;
		yourself
]

{ #category : #accessing }
DaylyActivityReport >> date [
	^ date
]

{ #category : #printing }
DaylyActivityReport >> eventCounts [
	^ eventCounts
]

{ #category : #accessing }
DaylyActivityReport >> eventCounts: anObject [
	eventCounts := anObject
]

{ #category : #printing }
DaylyActivityReport >> group [
	^ date printString
]

{ #category : #printing }
DaylyActivityReport >> groupingCriteria [
	^ 'date'
]

{ #category : #initialization }
DaylyActivityReport >> initialize [
	eventCounts := SpeciesCounter new
]

{ #category : #printing }
DaylyActivityReport >> printOn: aStream [
	date printOn: aStream.
	aStream space.
	super printOn: aStream
]

{ #category : #updating }
DaylyActivityReport >> updateWith: anEvent [
	date
		ifNil: [ date := anEvent date ]
		ifNotNil: [ anEvent date ~= date
				ifTrue: [ self error: 'Mismatching event dates' ] ].
	eventCounts count: anEvent
]
