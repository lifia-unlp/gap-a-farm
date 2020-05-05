Class {
	#name : #SubstancesComponent,
	#superclass : #GAFAbstractTableWithFilterAndActionsComponent,
	#category : #'GapAFarm-ui-expert'
}

{ #category : #rendering }
SubstancesComponent >> columnHeadings [
	^ {'Nombre comercial' . 'Principios activos' . 'Aptitud' . 'Períodos de carencia'. 'Usuarios'}
		, super columnHeadings
]

{ #category : #rendering }
SubstancesComponent >> columnValuesFor: substance [
	"{'Nombre comercial'. 'Marca'. 'Componentes activos'. 'Carencia (días)'}"

	^ {substance comercialName.
	(substance activeIngredients collect: #tradeName) asCommaString.
	(SenasaCatalogue singleton applicabilitiesForSubstance: substance)
		asCommaString.
	(self withdrawalStringFor: substance).
	(self numberOfUsersFor: substance) printString}
		, (super columnValuesFor: substance)
]

{ #category : #rendering }
SubstancesComponent >> definedWithdrawalStringFor: aSubstance [
	| stream |
	stream := String new writeStream.
	(aSubstance withdrawalRecommendationsByDays associations
		asSortedCollection: [ :a :b | a key < b key ])
		do: [ :association | 
			association value
				do: [ :recommendation| stream nextPutAll:  recommendation crop vulgarName ]
				separatedBy: [ stream nextPutAll: ', ' ].
			stream nextPutAll: ': '.
			stream
				nextPutAll: association key asString;
				nextPutAll: ' días' ]
		separatedBy: [ stream nextPutAll: ' - ' ].
	^ stream contents
]

{ #category : #callbacks }
SubstancesComponent >> editWithdrawalPeriodRecommendations: aSubstance [
	self
		call: (WithdrawalTimeRecommendationsEditor substance: aSubstance)
]

{ #category : #hooks }
SubstancesComponent >> elementClass [
	"Returns the class of elements to edit and add"

	^ Substance 
]

{ #category : #hooks }
SubstancesComponent >> elementEditorClass [
	"Returns the class of editor used to edit elements"

	^ SubstanceEditor
]

{ #category : #accessing }
SubstancesComponent >> elements [
	^ self session gapAFarm substances
]

{ #category : #initialization }
SubstancesComponent >> initialize [
	super initialize.
	duplicateEnabled := true.
	removeEnabled := true.
]

{ #category : #private }
SubstancesComponent >> isExempt: aSubstance [
	^ (aSubstance activeIngredients collect: #tradeName)
		allSatisfy: [ :each | SenasaCatalogue singleton isExempt: each ]
]

{ #category : #private }
SubstancesComponent >> isIncomplete: aSubstance [
	| namesOfCropsWithWithdrawalPeriod namesOfCropsThatRequireWithdrawal missing |
	namesOfCropsWithWithdrawalPeriod := aSubstance
		withdrawalRecommendations
		collect: [ :each | each crop vulgarName ]
		as: Set.
	namesOfCropsThatRequireWithdrawal := ((aSubstance activeIngredients
		collect: #tradeName)
		flatCollect: [ :aTradeName | 
			(SenasaCatalogue singleton recordsForActiveIngredientNamed: aTradeName)
				reject: #isExempt ]) collect: #cropVulgarName as: Set.
	missing := (namesOfCropsThatRequireWithdrawal
		intersection: (self session gapAFarm crops collect: #vulgarName))
		copyWithoutAll: namesOfCropsWithWithdrawalPeriod.
	^ missing notEmpty
]

{ #category : #rendering }
SubstancesComponent >> numberOfUsersFor: aSubstance [
	^ self session gapAFarm numberOfUsersForSubstance: aSubstance
]

{ #category : #callbacks }
SubstancesComponent >> removeElement: element [
	"Just in case someone applied it since the menu was generated"

	(self removeEnabledFor: element)
		ifTrue: [ element remove ]
]

{ #category : #private }
SubstancesComponent >> removeEnabledFor: element [
	^ (super removeEnabledFor: element)
		& (self session gapAFarm canRemoveSubstance: element)
]

{ #category : #rendering }
SubstancesComponent >> renderSpecificActionsFor: element on: html [
	html div class: 'dropdown-divider'.
	html anchor
		class: 'dropdown-item';
		callback: [ self editWithdrawalPeriodRecommendations: element ];
		with: 'Ajustar tiempos de carencia'
]

{ #category : #rendering }
SubstancesComponent >> withdrawalStringFor: aSubstance [
	(self isExempt: aSubstance)
		ifTrue: [ ^ 'Exento' ].
	(self isIncomplete: aSubstance)
		ifTrue: [ ^ 'INCOMPLETO' ].
	^self definedWithdrawalStringFor: aSubstance
]
