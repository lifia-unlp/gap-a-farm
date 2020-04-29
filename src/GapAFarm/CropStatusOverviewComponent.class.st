Class {
	#name : #CropStatusOverviewComponent,
	#superclass : #GAFAbstractTableWithFilterAndActionsComponent,
	#instVars : [
		'harvestsPerCrop',
		'sowingsPerCrop'
	],
	#category : #'GapAFarm-ui-farmer'
}

{ #category : #rendering }
CropStatusOverviewComponent >> columnHeadings [
	^ {'Cultivo' . 'Implantado en ...' . 'Cosechando en... '. 'Cosechado'}
]

{ #category : #rendering }
CropStatusOverviewComponent >> columnValuesFor: crop [
	^ {crop vulgarName.
	(self sowedInStringFor: crop).
	(self harvestingInStringFor: crop).
	((self totalHarvestedFor: crop) printString , ' Kg')}
]

{ #category : #accessing }
CropStatusOverviewComponent >> elements [
	^ (harvestsPerCrop keys , sowingsPerCrop keys) asSet
		asSortedCollection: [ :a :b | a vulgarName < b vulgarName ]
]

{ #category : #rendering }
CropStatusOverviewComponent >> harvestingInStringFor: crop [
	^ harvestsPerCrop
		at: crop
		ifPresent: [ :them | 
			(them collect: [ :each | each plot id ]) asSet asSortedCollection
				asCommaString ]
		ifAbsent: [ '' ]
]

{ #category : #initialization }
CropStatusOverviewComponent >> initialize [
	super initialize.
	addEnabled := false.
	editEnabled := false.
	duplicateEnabled := false.
	self prepareReportData.

]

{ #category : #initialization }
CropStatusOverviewComponent >> prepareReportData [
	harvestsPerCrop := Dictionary new.
	sowingsPerCrop := Dictionary new.
	(self session farm plots
		flatCollect: [ :each | each currentCycle sowings ])
		do: [ :each | 
			(sowingsPerCrop at: each crop ifAbsentPut: [ OrderedCollection new ])
				add: each ].
	(self session farm plots
		flatCollect: [ :each | each currentCycle harvests ])
		do: [ :each | 
			(harvestsPerCrop at: each crop ifAbsentPut: [ OrderedCollection new ])
				add: each ]
]

{ #category : #rendering }
CropStatusOverviewComponent >> sowedInStringFor: crop [
	^ sowingsPerCrop
		at: crop
		ifPresent: [ :them | 
			(them collect: [ :each | each plot id ]) asSet asSortedCollection
				asCommaString ]
		ifAbsent: [ '' ]
]

{ #category : #rendering }
CropStatusOverviewComponent >> totalHarvestedFor: crop [
	^ (harvestsPerCrop at: crop ifAbsent: [ Set new ])
		sumNumbers: [ :each | each quantity truncated ]
]
