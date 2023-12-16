Class {
	#name : #GAFAdminComponent,
	#superclass : #GAFAbstractComponent,
	#instVars : [
		'selectedComponent',
		'telegramAdminComponent'
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
		callback: [
			selectedComponent := ConfigurationEditor subject:
					                     self session persistentConfiguration ];
		with: [ html formButton bePrimary with: 'Configuración' ].
	html space.
	html anchor
		callback: [ selectedComponent := UsersAdminComponent parent: self ];
		with: [ html formButton bePrimary with: 'Usuarios' ].
	html space.
	html anchor
		callback: [ selectedComponent := FarmsAdminComponent new ];
		with: [ html formButton bePrimary with: 'Granjas' ].
	html space.
	html anchor
		callback: [
			selectedComponent := TelegramConfigurationEditor new
				                     persistentConfiguration:
					                     self session persistentConfiguration;
				                     yourself ];
		with: [ html formButton bePrimary with: 'Telegram bot' ]
]
