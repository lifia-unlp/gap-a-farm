Class {
	#name : #ActiveIngredientViewer,
	#superclass : #GAFAbstractComponent,
	#instVars : [
		'activeIngredient'
	],
	#category : #'GapAFarm-ui-expert'
}

{ #category : #accessing }
ActiveIngredientViewer >> activeIngredient [
	^ activeIngredient
]

{ #category : #accessing }
ActiveIngredientViewer >> activeIngredient: anObject [
	activeIngredient := anObject
]

{ #category : #rendering }
ActiveIngredientViewer >> renderContentOn: html [
	html heading
		level5;
		with: 'Principio activo'.
	html paragraph: activeIngredient tradeName.
	html heading
		level5;
		with: 'Aptitud'.
	html
		paragraph:
			(SenasaCatalogue singleton
				combinedApplicabilitiesFor: {activeIngredient tradeName}) asCommaString.
	activeIngredient comment
		ifNotEmpty: [ :it | 
			html heading
				level5;
				with: 'Notes'.
			html paragraph: it ].
	html heading
		level5;
		with: 'Cultivos registrados'.
	html table
		class: 'table table-hover';
		with: [ html
				tableHead: [ html
						tableHeading: 'Cultivo';
						tableHeading: 'Residuo';
						tableHeading: 'Fuente' ].
			html
				tableBody: [ (SenasaCatalogue singleton
						recordsForActiveIngredientNamed: activeIngredient tradeName)
						do: [ :record | 
							html
								tableRow: [ html
										tableData: record cropVulgarName;
										tableData: (record residue ifNil: [ 'Exento' ]);
										tableData: record source ] ] ] ]
]
