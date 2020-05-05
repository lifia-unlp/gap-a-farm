Class {
	#name : #YeildReportsComponent,
	#superclass : #GAFAbstractWidgetComponent,
	#category : #'GapAFarm-ui-farmer-dashboard'
}

{ #category : #rendering }
YeildReportsComponent >> columnHeadings [
	^  {'Cultivo' . 'Cosechado' . 'Esperado'.  'Restan'}
]

{ #category : #rendering }
YeildReportsComponent >> columnValuesFor: element [
	| cycles |
	cycles:= self cyclesFor: element.
	^ {element vulgarName.
		(self harvestedIn: cycles) asString , ' Kg'.
		(self expectedYieldIn: cycles) asString , ' Kg'.
		(self daysToEndOfHarvestIn: cycles) asString , ' dias'}
	
		
]

{ #category : #'as yet unclassified' }
YeildReportsComponent >> cyclesFor: aCrop [
	^ (self plotsInHarvesting select: [ :plot | plot currentCrop = aCrop ])
		collect: #currentCycle
]

{ #category : #'as yet unclassified' }
YeildReportsComponent >> daysToEndOfHarvestIn: cycles [
	^ ((cycles collect: #daysToEndOfHarvest)
		asSortedCollection: [ :a :b | a > b ]) first
]

{ #category : #accessing }
YeildReportsComponent >> elements [
	^ (self plotsInHarvesting collect: #currentCrop) asSet asOrderedCollection 
]

{ #category : #'as yet unclassified' }
YeildReportsComponent >> expectedYieldIn: cycles [
	^cycles inject: 0 into: [ :sum :cycle | sum + cycle latestSowing expectedYield ]
]

{ #category : #'as yet unclassified' }
YeildReportsComponent >> harvestedIn: cycles [
	^cycles inject: 0 into: [ :sum :cycle | sum + cycle harvested ]
	
]

{ #category : #accessing }
YeildReportsComponent >> parent [
	^ parent
]

{ #category : #accessing }
YeildReportsComponent >> plotsInHarvesting [
	^ self session farm plotsWithSowing
		select: [ :plot | 
			(Date today isBefore: plot currentCycle endOfPeriod)
				and: [ Date today isAfter: plot currentCycle harvestDate ] ]
]

{ #category : #'as yet unclassified' }
YeildReportsComponent >> viewAll [
]
