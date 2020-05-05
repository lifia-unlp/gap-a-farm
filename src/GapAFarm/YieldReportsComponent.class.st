Class {
	#name : #YieldReportsComponent,
	#superclass : #GAFAbstractWidgetComponent,
	#category : #'GapAFarm-ui-farmer-dashboard'
}

{ #category : #rendering }
YieldReportsComponent >> columnHeadings [
	^  {'Cultivo' . 'Cosechado' . 'Esperado'.  'Restan'}
]

{ #category : #rendering }
YieldReportsComponent >> columnValuesFor: element [
	| cycles |
	cycles:= self cyclesFor: element.
	^ {element vulgarName.
		(self harvestedIn: cycles) asString , ' Kg'.
		(self expectedYieldIn: cycles) asString , ' Kg'.
		(self daysToEndOfHarvestIn: cycles) asString , ' dias'}
	
		
]

{ #category : #'as yet unclassified' }
YieldReportsComponent >> cyclesFor: aCrop [
	^ (self plotsInHarvesting select: [ :plot | plot currentCrop = aCrop ])
		collect: #currentCycle
]

{ #category : #'as yet unclassified' }
YieldReportsComponent >> daysToEndOfHarvestIn: cycles [
	^ ((cycles collect: #daysToEndOfHarvest)
		asSortedCollection: [ :a :b | a > b ]) first
]

{ #category : #accessing }
YieldReportsComponent >> elements [
	^ (self plotsInHarvesting collect: #currentCrop) asSet asOrderedCollection 
]

{ #category : #'as yet unclassified' }
YieldReportsComponent >> expectedYieldIn: cycles [
	^cycles inject: 0 into: [ :sum :cycle | sum + cycle latestSowing expectedYield ]
]

{ #category : #'as yet unclassified' }
YieldReportsComponent >> harvestedIn: cycles [
	^ (cycles inject: 0 into: [ :sum :cycle | sum + cycle harvested ])
		truncated
]

{ #category : #accessing }
YieldReportsComponent >> parent [
	^ parent
]

{ #category : #accessing }
YieldReportsComponent >> plotsInHarvesting [
	^ self session farm plotsWithSowing
		select: [ :plot | 
			(Date today isBefore: plot currentCycle endOfPeriod)
				and: [ Date today isAfter: plot currentCycle harvestDate ] ]
]

{ #category : #'as yet unclassified' }
YieldReportsComponent >> viewAll [
]
