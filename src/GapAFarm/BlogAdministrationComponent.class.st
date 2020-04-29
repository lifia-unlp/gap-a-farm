Class {
	#name : #BlogAdministrationComponent,
	#superclass : #GAFAbstractComponent,
	#category : #'GapAFarm-ui-expert'
}

{ #category : #rendering }
BlogAdministrationComponent >> renderContentOn: html [
	html table
		class: 'table table-hover';
		with: [ html
				tableHead: [ html
						tableHeading: 'Fecha';
						tableHeading: 'Título';
						tableHeading: 'Comentarios' ].
			html
				tableBody: [ html
						tableRow: [ html
								tableData: '1/12/2019';
								tableData: 'El proyecto RUC-APS no se detiene ...';
								tableData: '36' ].
					html
						tableRow: [ html
								tableData: '12/03/2020';
								tableData: 'BPAi, el portal lúdico de buenas prácticas de la UNLP';
								tableData: '16' ].
					html
						tableRow: [ html
								tableData: '6/01/2020';
								tableData: 'El INTA publica manual de horticultura periurbana';
								tableData: '9' ] ].
			html
				tableRow: [ html
						tableData: '15/9/2019';
						tableData: 'Tomate platense, ¿el mas rico de todos?';
						tableData: '6' ] ].
	html
		paragraph: [ html anchor
				callback: [  ];
				with: [ html formButton
						bePrimary;
						with: 'Agregar' ] ]
]
