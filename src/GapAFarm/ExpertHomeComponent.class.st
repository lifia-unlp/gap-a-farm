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
							('Noticias' -> BlogPostsComponent)}
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
	| roles |
	html div
		class: 'left-menu-heading';
		with: 'Otros roles'.
	roles := OrderedCollection
		with: 'Agricultor' -> [ self call: FarmerHomeComponent new ].
	self session user isAdmin
		ifTrue: [ roles add: 'Administrador' -> [ self call: GAFAdminComponent new ] ].
	roles
		do: [ :ass | 
			html listGroupLinkedItem
				callback: ass value;
				with: ass key ]
]
