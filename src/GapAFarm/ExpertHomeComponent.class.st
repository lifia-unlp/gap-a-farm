Class {
	#name : #ExpertHomeComponent,
	#superclass : #GAFHomeComponent,
	#category : #'GapAFarm-ui-expert'
}

{ #category : #rendering }
ExpertHomeComponent >> barBrand [
	"return a string for the Bar brand"

	^ 'GAP-a-Farm (para expertos)'
]

{ #category : #rendering }
ExpertHomeComponent >> dashboardComponentClass [
	^ ExpertDashboardComponent
]

{ #category : #rendering }
ExpertHomeComponent >> loadDashboardShowcaseDemoData [
	ExampleDataLoaderToShowcaseTheDashboard new
		session: self session;
		addExpertDemoData
]

{ #category : #rendering }
ExpertHomeComponent >> loadStressTestDemoData [
	ExampleDataLoaderToStressTest new
		session: self session;
		addExpertDemoData
]

{ #category : #rendering }
ExpertHomeComponent >> renderLeftMenuOn: html [
	html
		form: [ html
				listGroup: [ self
						renderMenuBlock:
							{('Tablero de control' -> ExpertDashboardComponent).
							('Noticias' -> BlogPostsComponentForExperts)}
						heading: 'Gestión'
						on: html.
					self
						renderMenuBlock:
							{('Cultivos' -> CropsComponent).
							('Principios activos' -> ActiveIngredientComponent).
							('Fitosanitarios y fertilizantes' -> SubstancesComponent).
							('Resoluciones SENASA' -> SenasaCatalogueComponent)}
						heading: 'Catálogos'
						on: html.
					self
						renderMenuBlock: {('Exportar' -> ExpertExportComponent)}
						heading: 'Administración'
						on: html.
					self renderRolesMenuBlockOn: html ] ]
]

{ #category : #rendering }
ExpertHomeComponent >> renderRolesMenuBlockOn: html [
	html div
		class: 'left-menu-heading';
		with: 'Otros roles'.
	html listGroupLinkedItem
		callback: [ self call: FarmerHomeComponent new ];
		with: 'Agricultor'.
	self session user isAdmin
		ifTrue: [ html listGroupLinkedItem
				callback: [ self call: GAFAdminComponent new ];
				target: 'gaf-admin';
				with: 'Administrador' ]
]
