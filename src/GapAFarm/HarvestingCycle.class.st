Class {
	#name : #HarvestingCycle,
	#superclass : #Object,
	#instVars : [
		'events',
		'isOutOfSync'
	],
	#category : #'GapAFarm-model'
}

{ #category : #voyage }
HarvestingCycle class >> isVoyageRoot [
	^ false
]

{ #category : #events }
HarvestingCycle >> addEvent: anEvent [
	(events notEmpty
		and: [ anEvent dateAndTime < self dateAndTimeOfFirstEvent ])
		ifTrue: [ ^ self ].
	(anEvent species = Sowing and: [ anEvent crop ~= self crop ])
		ifTrue: [ self restart ].
	events add: anEvent
]

{ #category : #events }
HarvestingCycle >> adversities [
	^ events select: [ :each | each class = AdversityReport ]
]

{ #category : #events }
HarvestingCycle >> aplications [
	^ events select: [ :each | each class = Application ]
]

{ #category : #events }
HarvestingCycle >> crop [
	^ self latestSowing ifNil: [ nil ] ifNotNil: [ :it | it crop ]
]

{ #category : #chronology }
HarvestingCycle >> dateAndTimeOfFirstEvent [
	events ifEmpty: [ ^ nil ].
	^ (events collect: #dateAndTime) min
]

{ #category : #chronology }
HarvestingCycle >> dateOfLatestEvent [
	events ifEmpty: [ ^ nil ].
	^ (events collect: #date) max
]

{ #category : #chronology }
HarvestingCycle >> daysToEndOfHarvest [
	^self endOfPeriod subtractDate: Date today
]

{ #category : #chronology }
HarvestingCycle >> daysToHarvest [
	^self harvestDate subtractDate: Date today
]

{ #category : #accessing }
HarvestingCycle >> endOfPeriod [
	^ self harvestDate addDays: self harvestDuration.
]

{ #category : #withdrawal }
HarvestingCycle >> endsOfWithdrawalPeriods [
	"Returns the dates for the end of the waiting periods of all applications in this cycle - in case not waiting period is necesary, returns the date and time of application.
	
	Raises MissingWithdrawalInformationException the withdrawal perios is needed and has not been set. "

	self aplications ifEmpty: [ ^ Array new ].
	self sowings ifEmpty: [ ^ Array new ].
	^ self aplications
		collect: [ :app | app endOfWaitingPeriodFor: self latestSowing crop ]
		thenSelect: [ :each | each isAfter: Date today ]
]

{ #category : #accessing }
HarvestingCycle >> events [
	^ events
]

{ #category : #accessing }
HarvestingCycle >> harvestDate [
	^self latestSowing harvestDate
]

{ #category : #accessing }
HarvestingCycle >> harvestDuration [
	^self latestSowing harvestDuration
]

{ #category : #accessing }
HarvestingCycle >> harvested [
	^ self harvests inject: 0 into: [ :sum :harvest | sum + harvest quantity ]
]

{ #category : #events }
HarvestingCycle >> harvests [
	^ events select: [ :each | each class = Harvesting ]
]

{ #category : #initialization }
HarvestingCycle >> initialize [
	events := OrderedCollection new. 
	isOutOfSync := false. 
]

{ #category : #withdrawal }
HarvestingCycle >> isInWithdrawal [
	^ [ self withdrawalPeriodDaysLeft > 0 ]
		on: MissingWithdrawalInformationException
		do: [ true ]
]

{ #category : #testing }
HarvestingCycle >> isOutOfSync [
	^isOutOfSync 
]

{ #category : #testing }
HarvestingCycle >> isStaggered [
	^ self sowings size > 1
]

{ #category : #events }
HarvestingCycle >> latestAdversity [
	^ (self adversities
		asSortedCollection: [ :a :b | a dateAndTime > b dateAndTime ])
		ifEmpty: [ ^ nil ]
		ifNotEmpty: [ :it | ^ it first ]
]

{ #category : #events }
HarvestingCycle >> latestApplication [
	^ (self aplications
		asSortedCollection: [ :a :b | a dateAndTime > b dateAndTime ])
		ifEmpty: [ ^ nil ]
		ifNotEmpty: [ :it | ^ it first ]
]

{ #category : #events }
HarvestingCycle >> latestHarvest [
	^ self harvests ifEmpty: [ ^ nil ] ifNotEmpty: [ :it | ^ it last ]
]

{ #category : #events }
HarvestingCycle >> latestSowing [
	^ (self sowings
		asSortedCollection: [ :a :b | a dateAndTime > b dateAndTime ])
		ifEmpty: [ ^ nil ]
		ifNotEmpty: [ :it | ^ it first ]
]

{ #category : #events }
HarvestingCycle >> removeEvent: anEvent [
	(events includes: anEvent)
		ifFalse: [ ^ self ].
	events remove: anEvent.
	anEvent class == Sowing
		ifTrue: [ isOutOfSync := true ]
]

{ #category : #private }
HarvestingCycle >> restart [
	events ifEmpty: [ ^ self ].
	events last class = Application | (events last class = AdversityReport)
		ifTrue: [ events := OrderedCollection with: events last.
			^ self ].
	events := OrderedCollection new
]

{ #category : #events }
HarvestingCycle >> sowings [
	^ events select: [ :each | each class = Sowing ]
]

{ #category : #withdrawal }
HarvestingCycle >> withdrawalPeriodDaysLeft [
	self sowings ifEmpty: [ ^ 0 ]. 
	^ self endsOfWithdrawalPeriods
		ifEmpty: [ 0 ]
		ifNotEmpty: [ :dates | dates max: [ :date | date subtractDate: Date today ] ] 
]

{ #category : #testing }
HarvestingCycle >> wouldRestartIfSowing: aSowing [
	^ self latestSowing
		ifNil: [ false ]
		ifNotNil:
			[ :it | it dateAndTime < aSowing dateAndTime & (it crop ~= aSowing crop) ]
]
