Class {
	#name : #GAFDeployer,
	#superclass : #Object,
	#instVars : [
		'adminEmail',
		'application'
	],
	#classVars : [
		'DemoMode',
		'EnableTestDataLoaders'
	],
	#category : #'GapAFarm-deployment'
}

{ #category : #demo }
GAFDeployer class >> demoMode [
	^ DemoMode ifNil: [ DemoMode := false ]
]

{ #category : #demo }
GAFDeployer class >> demoMode: aBoolean [
	DemoMode := aBoolean
]

{ #category : #demo }
GAFDeployer class >> enableTestDataLoaders [
	^ EnableTestDataLoaders ifNil: [ EnableTestDataLoaders := false ]
]

{ #category : #demo }
GAFDeployer class >> enableTestDataLoaders: aBoolean [
	EnableTestDataLoaders := aBoolean
]

{ #category : #deploying }
GAFDeployer >> addLibraries [
	application
		addLibrary: JQDeploymentLibrary;
		addLibrary: JQUiDeploymentLibrary;
		addLibrary: SBSDeploymentLibrary 
]

{ #category : #accessing }
GAFDeployer >> adminEmail [
	^ adminEmail
]

{ #category : #accessing }
GAFDeployer >> adminEmail: anObject [
	adminEmail := anObject
]

{ #category : #accessing }
GAFDeployer >> database: anId [
	GAFStorage mongoLocalAt: anId
]

{ #category : #deploying }
GAFDeployer >> deploy [
	adminEmail ifNil: [ self error: 'Missing admin email' ].
	application := WAAdmin
		register: GAFLandingComponent
		asApplicationAt: GAFLandingComponent applicationName.
	self addLibraries.
	application sessionClass: GAFSession.
	application configuration addParent: GAFConfiguration instance.
	application preferenceAt: #adminEmail put: adminEmail
]
