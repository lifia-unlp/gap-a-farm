Class {
	#name : #WithdrawalTimeRecommendationsEditor,
	#superclass : #GAFAbstractComponent,
	#instVars : [
		'substance',
		'days',
		'source',
		'editing'
	],
	#category : #'GapAFarm-ui-expert'
}

{ #category : #'instance creation' }
WithdrawalTimeRecommendationsEditor class >> substance: aSubstance [
	^ self new
		substance: aSubstance;
		yourself
]

{ #category : #callbacks }
WithdrawalTimeRecommendationsEditor >> accept [
	| recommendation numberOfDays |
	numberOfDays := [ days asNumber ]
		on: Error
		do: [ days := ''.
			^ self ].
	numberOfDays < 0
		ifTrue: [ days := ''.
			^ self ].
	recommendation := substance withdrawalRecommendationFor: editing.
	recommendation
		ifNil: [ recommendation := WithdrawalRecommendation
				daysToWait: numberOfDays
				crop: editing
				referenceUrl: source.
			substance addWithdrawalRecommendation: recommendation ]
		ifNotNil: [ recommendation
				daysToWait: days asNumber;
				referenceUrl: source ].
	substance save.
	editing := nil
]

{ #category : #callbacks }
WithdrawalTimeRecommendationsEditor >> cancel [
	editing := nil
]

{ #category : #accessing }
WithdrawalTimeRecommendationsEditor >> cropsRequiringWithdrawalRecomendationPeriod [
	| crops |
	crops := substance activeIngredients
		flatCollect:
			[ :ingredient | self session gapAFarm registeredCropsForActiveIngredient: ingredient ]
		as: Set.
	^ crops asSortedCollection: [ :a :b | a vulgarName < b vulgarName ]
]

{ #category : #accessing }
WithdrawalTimeRecommendationsEditor >> days [
	^ days asString
]

{ #category : #accessing }
WithdrawalTimeRecommendationsEditor >> days: anObject [
	days := anObject
]

{ #category : #callbacks }
WithdrawalTimeRecommendationsEditor >> editRecordFor: crop [
	editing := crop.
	(substance withdrawalRecommendationFor: crop)
		ifNil: [ days := ''.
			source := '' ]
		ifNotNil: [ :it | 
			days := it daysToWait.
			source := it referenceUrl ]
]

{ #category : #initialization }
WithdrawalTimeRecommendationsEditor >> initialize [
	super initialize.
	days := 0
]

{ #category : #accessing }
WithdrawalTimeRecommendationsEditor >> isExempt [
	^ substance activeIngredients
		allSatisfy:
			[ :ingredient | SenasaCatalogue singleton isExempt: ingredient tradeName ]
]

{ #category : #callbacks }
WithdrawalTimeRecommendationsEditor >> removeWithdrawalPeriodRecommentationFor: aCrop [
	substance
		removeWithdrawalRecommendation: (substance withdrawalRecommendationFor: aCrop).
	substance save
]

{ #category : #rendering }
WithdrawalTimeRecommendationsEditor >> renderContentOn: html [
	self renderFixedDataOn: html.
	html heading
		level5;
		with: 'Períodos de carencia'.
		
	editing notNil
		ifTrue: [ html form: [ self renderWithdrawalRecommendationPeriodsOn: html ] ]
		ifFalse: [ self renderWithdrawalRecommendationPeriodsOn: html ]
]

{ #category : #rendering }
WithdrawalTimeRecommendationsEditor >> renderDisplayRowFor: crop on: html [
	| record |
	record := substance withdrawalRecommendationFor: crop.
	^ html
		tableData: crop vulgarName;
		tableData: (record ifNil: [ '?' ] ifNotNil: [ record daysToWait ]);
		tableData: (record ifNil: [ '?' ] ifNotNil: [ record referenceUrl ]);
		tableData: [ editing
				ifNil: [ html anchor
						callback: [ self editRecordFor: crop ];
						with: [ html span
								class: 'fa fa-pencil';
								attributeAt: 'title' put: 'Modificar' ].
					record
						ifNotNil: [ html space.
							html anchor
								callback: [ self removeWithdrawalPeriodRecommentationFor: crop ];
								with: [ html span
										class: 'fa fa-trash';
										attributeAt: 'title' put: 'Borrar' ] ] ] ]
]

{ #category : #rendering }
WithdrawalTimeRecommendationsEditor >> renderEditRowFor: crop on: html [
	html
		tableData: crop vulgarName;
		tableData: [ html textInput
				formControl;
				size: 4;
				on: #days of: self ];
		tableData: [ html textInput
				formControl;
				on: #source of: self ];
		tableData: [ html formButton
				bePrimary;
				callback: [ self accept ];
				with: 'Aceptar'.
			html space.
			html formButton
				beSecondary;
				callback: [ self cancel ];
				with: 'Cancelar' ]
]

{ #category : #rendering }
WithdrawalTimeRecommendationsEditor >> renderFixedDataOn: html [
	html heading
		level5;
		with: 'Nombre comercial: '.
	html paragraph: substance comercialName.
	html heading
		level5;
		with: 'Principios activos: '.
	html
		paragraph: (substance activeIngredients collect: #tradeName) asCommaString.
	html heading
		level5;
		with: 'Aptitud:  '.
	html
		paragraph:
			(SenasaCatalogue singleton
				combinedApplicabilitiesFor: (substance activeIngredients collect: #tradeName))
				asCommaString
]

{ #category : #rendering }
WithdrawalTimeRecommendationsEditor >> renderWithdrawalRecommendationPeriodsOn: html [
	| crops |
	crops := self cropsRequiringWithdrawalRecomendationPeriod.
	crops
		ifEmpty: [ html paragraph: 'Exento'.
			^ self ].
	html table
		class: 'table table-hover';
		with: [ html
				tableHead: [ html
						tableRow: [ {'Cultivo' . 'Carencia (días)' . 'Fuente' . 'Acciones'}
								do: [ :heading | html tableHeading: heading ] ] ].
			html
				tableBody: [ crops
						do: [ :crop | 
							html
								tableRow: [ editing = crop
										ifFalse: [ self renderDisplayRowFor: crop on: html ]
										ifTrue: [ self renderEditRowFor: crop on: html ] ] ] ] ]
]

{ #category : #accessing }
WithdrawalTimeRecommendationsEditor >> source [
	^ source
]

{ #category : #accessing }
WithdrawalTimeRecommendationsEditor >> source: anObject [
	source := anObject
]

{ #category : #accessing }
WithdrawalTimeRecommendationsEditor >> substance [
	^ substance
]

{ #category : #accessing }
WithdrawalTimeRecommendationsEditor >> substance: aSubstance [ 
	substance := aSubstance
]
