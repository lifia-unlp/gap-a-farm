Class {
	#name : #Event,
	#superclass : #GafObject,
	#instVars : [
		'plot',
		'dateAndTime',
		'crop'
	],
	#category : #'GapAFarm-model'
}

{ #category : #testing }
Event class >> isVoyageRoot [
	^ false
]

{ #category : #accessing }
Event >> crop [
	^ crop
]

{ #category : #accessing }
Event >> crop: anObject [
	crop := anObject
]

{ #category : #accessing }
Event >> date [
	^ dateAndTime ifNil: [ nil ] ifNotNil: [ :it | it asDate ]
]

{ #category : #accessing }
Event >> date: aDate [
	dateAndTime := DateAndTime
		date: aDate
		time: (dateAndTime ifNil: [ '00:00' asTime ] ifNotNil: [ :it | it asTime ])
]

{ #category : #accessing }
Event >> dateAndTime [
	^ dateAndTime
]

{ #category : #accessing }
Event >> dateAndTime: anUndefinedObject [ 
	dateAndTime := anUndefinedObject
]

{ #category : #accessing }
Event >> plot [
	^ plot
]

{ #category : #accessing }
Event >> plot: anObject [
	plot := anObject
]

{ #category : #printing }
Event >> summaryFor: aSummaryRequestor [
	^ self subclassResponsibility
]

{ #category : #accessing }
Event >> time [
	^ dateAndTime ifNil: [ nil ] ifNotNil: [ :it | it asTime ]
]

{ #category : #accessing }
Event >> time: aTime [
	dateAndTime := DateAndTime
		date: (dateAndTime ifNil: [ Date today ] ifNotNil: [ :it | it asDate ])
		time: aTime
]
