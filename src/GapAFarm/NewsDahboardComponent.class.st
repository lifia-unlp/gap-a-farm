Class {
	#name : #NewsDahboardComponent,
	#superclass : #GAFAbstractWidgetComponent,
	#category : #'GapAFarm-ui-farmer-dashboard'
}

{ #category : #accessing }
NewsDahboardComponent >> elements [ 
	GAFDeployer demoMode ifTrue: [ ^{1} ] ifFalse: [ ^{} ]
]

{ #category : #rendering }
NewsDahboardComponent >> renderContentOn: html [
	html table
		class: 'table table-hover';
		with: [ html
				tableBody: [ html
						tableRow: [ html
								tableData: [ html anchor
										url: '';
										with: 'El proyecto RUC-APS no se detiene ...' ] ];
						tableRow: [ html
								tableData: [ html anchor
										url: '';
										with: 'BPAi, el portal lúdico de buenas prácticas de la UNLP' ] ];
						tableRow: [ html
								tableData: [ html anchor
										url: '';
										with: 'El INTA publica manual de horticultura periurbana' ] ];
						tableRow: [ html
								tableData: [ html anchor
										url: '';
										with: 'Tomate platense, ¿el mas rico de todos?' ] ] ] ]
]

{ #category : #'as yet unclassified' }
NewsDahboardComponent >> viewAll [
]
