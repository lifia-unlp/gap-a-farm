Class {
	#name : #PlotsInWithdrawalTimePageComponent,
	#superclass : #GAFAbstractTableComponent,
	#category : #'GapAFarm-ui-farmer-dashboard'
}

{ #category : #rendering }
PlotsInWithdrawalTimePageComponent >> columnHeadings [
	^  {'Lote'. 'Cultivo'. 'Producto'. 'Restan'}
]

{ #category : #rendering }
PlotsInWithdrawalTimePageComponent >> columnValuesFor: element [
	^ {element id.
	element currentCycle latestSowing crop vulgarName.
	element currentCycle aplications last substance comercialName.
	([ element currentCycle withdrawalPeriodDaysLeft asString , ' dias' ]
		on: MissingWithdrawalInformationException
		do: [ '¿?' ])}
]

{ #category : #accessing }
PlotsInWithdrawalTimePageComponent >> elements [
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

{ #category : #rendering }
PlotsInWithdrawalTimePageComponent >> renderContentOn: html [
	html heading level2; with: 'Lotes en carencia'.
	super renderContentOn: html.
	self renderReturnButtonOn: html
]

{ #category : #rendering }
PlotsInWithdrawalTimePageComponent >> renderReturnButtonOn: html [
	^ html anchor
		callback: [ self answer ];
		with: [ html formButton
				bePrimary;
				with: 'Volver' ]
]
