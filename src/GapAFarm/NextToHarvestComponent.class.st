Class {
	#name : #NextToHarvestComponent,
	#superclass : #GAFAbstractWidgetComponent,
	#category : #'GapAFarm-ui-farmer-dashboard'
}

{ #category : #rendering }
NextToHarvestComponent >> columnHeadings [
	^  {'Cultivo' . 'En'. 'Cantidad'}
]

{ #category : #rendering }
NextToHarvestComponent >> columnValuesFor: element [

	^ {element vulgarName.
		(self dateOfHarvestFor: element) asString , ' dias'.
		(self kilogramsFor: element) asString , ' Kg' }
]

{ #category : #'as yet unclassified' }
NextToHarvestComponent >> dateOfHarvestFor: aCrop [
	^ ((((self plotsToHarvest select: [ :plot | plot currentCrop = aCrop ])
		collect: [ :plot | plot currentCycle latestSowing harvestDate])
		asSortedCollection: [ :a :b | a < b ]) first) subtractDate: (Date today)
]

{ #category : #accessing }
NextToHarvestComponent >> elements [
	^ (self plotsToHarvest collect: [ :each | each currentCrop ]) asSet
]

{ #category : #'as yet unclassified' }
NextToHarvestComponent >> kilogramsFor: aCrop [
	^ (((self plotsToHarvest select: [ :plot | plot currentCrop = aCrop ])
		collect: [ :plot | plot currentCycle latestSowing])
		asSortedCollection: [ :a :b | a harvestDate  < b harvestDate ]) first expectedYield
]

{ #category : #accessing }
NextToHarvestComponent >> parent [
	^ parent
]

{ #category : #'as yet unclassified' }
NextToHarvestComponent >> plotsInWaitingPeriod [
	^ self session farm plots select: [ :plot | plot isInWithdrawal ]
]

{ #category : #accessing }
NextToHarvestComponent >> plotsToHarvest [
	^ (self session farm plotsWithSowing
		select: [ :plot | plot currentCycle harvestDate isAfter: Date today ])
		reject: [ :plot | self plotsInWaitingPeriod includes: plot ]
]

{ #category : #'as yet unclassified' }
NextToHarvestComponent >> viewAll [
]
