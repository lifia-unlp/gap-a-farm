Class {
	#name : #PlotsInWithdrawalTimeComponent,
	#superclass : #GAFAbstractWidgetComponent,
	#category : #'GapAFarm-ui-farmer-dashboard'
}

{ #category : #rendering }
PlotsInWithdrawalTimeComponent >> columnHeadings [
	^  {'Lote'. 'Cultivo'. 'Producto'. 'Restan'}
]

{ #category : #rendering }
PlotsInWithdrawalTimeComponent >> columnValuesFor: element [
	^ {element id.
	element currentCycle latestSowing crop vulgarName.
	element currentCycle aplications last substance comercialName.
	([ element currentCycle withdrawalPeriodDaysLeft asString , ' dias' ]
		on: MissingWithdrawalInformationException
		do: [ '¿?' ])}
]

{ #category : #accessing }
PlotsInWithdrawalTimeComponent >> elements [
	^ (self session farm plotsWithSowing
		select: [ :each | each isInWithdrawal ])
		asSortedCollection: [ :a :b | 
			([ a withdrawalPeriodDaysLeft ]
				on: MissingWithdrawalInformationException
				do: [ 9999 ])
				<
					([ b withdrawalPeriodDaysLeft ]
						on: MissingWithdrawalInformationException
						do: [ 9999 ]) ] 
]

{ #category : #accessing }
PlotsInWithdrawalTimeComponent >> parent [
	^ parent
]

{ #category : #rendering }
PlotsInWithdrawalTimeComponent >> viewAll [
	^parent call: PlotsInWithdrawalTimePageComponent new
]
