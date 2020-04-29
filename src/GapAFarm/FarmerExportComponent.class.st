Class {
	#name : #FarmerExportComponent,
	#superclass : #ExportComponent,
	#category : #'GapAFarm-ui-farmer'
}

{ #category : #callbacks }
FarmerExportComponent >> exportApplications [
	self
		export: (CSVApplicationsExporter events: self session farm aplications) export
		inCsvFileNamed: 'aplicaciones.csv'
]

{ #category : #callbacks }
FarmerExportComponent >> exportHarvestings [
	self
		export:
			(CSVHarverstingsExporter events: self session farm harvestings) export
		inCsvFileNamed: 'cosechas.csv'
]

{ #category : #callbacks }
FarmerExportComponent >> exportProblems [
	self
		export: (CSVProblemsExporter events: self session farm problems) export
		inCsvFileNamed: 'adversidades.csv'
]

{ #category : #callbacks }
FarmerExportComponent >> exportSowings [
	self
		export: (CSVSowingsExporter events: self session farm sowings) export
		inCsvFileNamed: 'siembras.csv'
]

{ #category : #rendering }
FarmerExportComponent >> renderContentOn: html [
	html table
		class: 'table table-hover';
		with: [ html
				tableHead: [ html
						tableHeading: 'Información';
						tableHeading: 'Formatos disponibles' ].
			html
				tableBody: [ html
						tableRow: [ html
								tableData: 'Siembras';
								tableData: [ self renderExportCsvButonFor: #exportSowings on: html ] ];
						tableRow: [ html
								tableData: 'Adversidades';
								tableData: [ self renderExportCsvButonFor: #exportProblems on: html ] ];
						tableRow: [ html
								tableData: 'Aplicaciones';
								tableData: [ self renderExportCsvButonFor: #exportApplications on: html ] ];
						tableRow: [ html
								tableData: 'Cosechas';
								tableData:
										[ self renderExportCsvButonFor: #exportHarvestings on: html ] ] ] ]
]
