Class {
	#name : #GAFAdminComponent,
	#superclass : #GAFAbstractComponent,
	#instVars : [
		'selectedComponent'
	],
	#category : #'GapAFarm-ui-admin'
}

{ #category : #rendering }
GAFAdminComponent >> initialize [
	super initialize.
	selectedComponent := ConfigurationEditor subject: self session persistentConfiguration
]

{ #category : #rendering }
GAFAdminComponent >> renderContentOn: html [
	html container
		style: 'padding-top: 10px';
		with: [ self renderNavBarOn: html ].
	html render: selectedComponent
]

{ #category : #rendering }
GAFAdminComponent >> renderNavBarOn: html [
	html anchor
		callback: [ selectedComponent := ConfigurationEditor
				subject: self session persistentConfiguration ];
		with: [ html formButton bePrimary with: 'Configuración' ].
	html space.
	html anchor
		callback: [ selectedComponent := UsersAdminComponent new ];
		with: [ html formButton bePrimary with: 'Usuarios' ].
	html space.
	html anchor
		callback: [ selectedComponent := FarmsAdminComponent new ];
		with: [ html formButton bePrimary with: 'Granjas' ]
]
