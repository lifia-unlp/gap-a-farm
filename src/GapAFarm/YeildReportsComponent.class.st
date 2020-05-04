Class {
	#name : #YeildReportsComponent,
	#superclass : #GAFAbstractWidgetComponent,
	#category : #'GapAFarm-ui-farmer-dashboard'
}

{ #category : #rendering }
YeildReportsComponent >> columnHeadings [
	^  {'Lote'. 'Cultivo' . 'Cosechado' . 'Esperado'.  'Restan'}
]

{ #category : #rendering }
YeildReportsComponent >> columnValuesFor: element [

	^ {element id.
		element currentCrop vulgarName.
		element currentCycle harvested.
		element currentCycle latestSowing expectedYield.
		(element currentCycle daysToEndOfHarvest asString), ' dias'}
]

{ #category : #accessing }
YeildReportsComponent >> elements [
	^ self session farm plotsWithSowing
		select: [ :plot |  
			(Date today isBefore: plot currentCycle endOfPeriod)
				and: [ Date today isAfter: plot currentCycle harvestDate ] ]
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
