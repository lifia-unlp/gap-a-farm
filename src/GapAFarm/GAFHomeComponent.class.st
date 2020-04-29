"
""This is part of the initialize method on the class side""

| app |
  app := WAAdmin register: FOMHomeComponent  asApplicationAt: 'huertas'.
  app 	addLibrary: JQDeploymentLibrary;
		addLibrary: JQUiDeploymentLibrary;
		addLibrary: SBSDeploymentLibrary. 
  app sessionClass: FOMSession.
"
Class {
	#name : #GAFHomeComponent,
	#superclass : #GAFAbstractComponent,
	#instVars : [
		'selectedComponent'
	],
	#category : #'GapAFarm-ui-common'
}

{ #category : #accessing }
GAFHomeComponent class >> applicationName [
	^'huertas'
]

{ #category : #rendering }
GAFHomeComponent >> barBrand [
	"return a string for the Bar brand"

	^ self subclassResponsibility
]

{ #category : #'accessing-children' }
GAFHomeComponent >> children [
	^ selectedComponent ifNil: [ {} ] ifNotNil: [ {selectedComponent} ]
]

{ #category : #rendering }
GAFHomeComponent >> dashboardComponentClass [
	^ self subclassResponsibility
]

{ #category : #initialization }
GAFHomeComponent >> initialize [
	super initialize.
	selectedComponent := self dashboardComponentClass new
]

{ #category : #rendering }
GAFHomeComponent >> loadDemoData [
	^self subclassResponsibility 
]

{ #category : #'rendering-login' }
GAFHomeComponent >> loginUrl [
	^ GAFLandingComponent  url
]

{ #category : #callbacks }
GAFHomeComponent >> logout [
	^ self session logout
]

{ #category : #rendering }
GAFHomeComponent >> renderBodyOn: html [
	| menuColumn |
	^ html
		row: [ menuColumn := html column.
			self session farm ~= self session user farms first
				ifTrue: [ menuColumn style: 'background-color: red;' ].
			menuColumn
				mediumSize: 2;
				with: [ self renderLeftMenuOn: html ].
			html column: [ html render: selectedComponent ] mediumSize: 10 ]
]

{ #category : #rendering }
GAFHomeComponent >> renderContentOn: html [
	GAFDeployer demoMode
		ifTrue: [ self renderDemoStampOn: html ].
	html
		container: [ self session loginRequired
				ifTrue: [ self renderLoginRequiredMessageOn: html ]
				ifFalse: [ self renderNavbarOn: html.
					self renderBodyOn: html.
					self renderFooterOn: html ] ]
]

{ #category : #rendering }
GAFHomeComponent >> renderDemoDataButtonOn: html [
	GAFDeployer enableTestDataLoaders
		ifFalse: [ ^ self ].
	html outlineButton beDanger beSmall
		callback: [ self loadStressTestDemoData ];
		with: 'Load stress test data'.
	html space.
	html outlineButton beDanger beSmall
		callback: [ self loadDashboardShowcaseDemoData ];
		with: 'Load data to showcase dashboard'.
	html space
]

{ #category : #rendering }
GAFHomeComponent >> renderFooterOn: html [
	html
		footer: [ html horizontalRule.
			self renderFooterNoteOn: html ]
]

{ #category : #rendering }
GAFHomeComponent >> renderLeftMenuOn: html [
	self subclassResponsibility
]

{ #category : #'rendering-login' }
GAFHomeComponent >> renderLoginRequiredMessageOn: html [
	html alert
		beWarning;
		with: [ html
				paragraph: [ html
						text: 'Su sesión ya expiró. En unos segundos lo redirigiremos a la '.
					html anchor
						url: self loginUrl;
						with: ' página de inicio. ' ] ]
]

{ #category : #rendering }
GAFHomeComponent >> renderLogoutButtonOn: html [
	^ html outlineButton bePrimary beSmall
		callback: [ self logout ];
		with: 'Salir'
]

{ #category : #rendering }
GAFHomeComponent >> renderMenuBlock: associations heading: head on: html [
	| item |
	html div
		class: 'left-menu-heading';
		with: head.
	associations
		do: [ :ass | 
			item := html listGroupLinkedItem.
			selectedComponent species = ass value
				ifTrue: [ item beActive ].
			item id: ass key asCamelCase.
			item
				callback: [ selectedComponent := ass value parent: self ];
				with: ass key ]
]

{ #category : #rendering }
GAFHomeComponent >> renderNavbarOn: html [
	| bar |
	bar := html navigationBar.
	bar beLight.
	bar
		with: [ html navigationBarBrand with: self barBrand.
			html
				form: [ self renderDemoDataButtonOn: html.
					self renderLogoutButtonOn: html ] ]
]

{ #category : #style }
GAFHomeComponent >> style [
	^ '.left-menu-heading {
         position: relative;
         display: block;
         padding: .75rem 1.25rem;
         margin-bottom: -1px;
         background-color: #eae6e6;
         border: 1px solid rgba(0,0,0,.125);
      }'
]

{ #category : #redirecting }
GAFHomeComponent >> updateRoot: aWARoot [
	super updateRoot: aWARoot.
	self session loginRequired
		ifTrue: [ aWARoot meta
				attributeAt: 'http-equiv' put: 'Refresh';
				content: '5;URL=''' , GAFLandingComponent url , '''' ]
]
