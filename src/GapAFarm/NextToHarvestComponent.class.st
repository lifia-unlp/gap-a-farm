Class {
	#name : #NextToHarvestComponent,
	#superclass : #GAFAbstractWidgetComponent,
	#category : #'GapAFarm-ui-farmer-dashboard'
}

{ #category : #rendering }
NextToHarvestComponent >> columnHeadings [
	^  {'Lote'. 'Cultivo' . 'Dias restantes'. 'Duracion(dias)'}
]

{ #category : #rendering }
NextToHarvestComponent >> columnValuesFor: element [

	^ {element id.
		element currentCrop vulgarName.
		element currentCycle daysToHarvest.
		element currentCycle harvestDuration}
]

{ #category : #accessing }
NextToHarvestComponent >> elements [
	^ (self session farm plotsWithSowing
		select: [ :plot | plot currentCycle harvestDate isAfter: Date today ])
		reject: [ :plot | self plotsInWaitingPeriod includes: plot ]
]

{ #category : #accessing }
NextToHarvestComponent >> parent [
	^ parent
]

{ #category : #'as yet unclassified' }
NextToHarvestComponent >> plotsInWaitingPeriod [
	^ self session farm plots select: [ :plot | plot isInWithdrawal ]
]

{ #category : #'as yet unclassified' }
NextToHarvestComponent >> viewAll [
]
