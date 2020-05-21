Class {
	#name : #GAFAdminComponent,
	#superclass : #GAFAbstractComponent,
	#category : #'GapAFarm-ui-common'
}

{ #category : #rendering }
GAFAdminComponent >> renderContentOn: html [
	html
		container: [ html heading: 'Panel de administración'.
			self renderPermissionSwitchsOn: html.
			self renderFarmSwithOn: html.
			self renderReturnButtonOn: html ]
]

{ #category : #rendering }
GAFAdminComponent >> renderFarmSelectorFor: each on: html [
	self session farm = each
		ifFalse: [ html anchor
				callback: [ self session farm: each ];
				with: [ html formButton
						bePrimary;
						with: 'Utilizar' ] ]
]

{ #category : #rendering }
GAFAdminComponent >> renderFarmSwithOn: html [
	html heading
		level4;
		with: 'Cambiar de granja'.
	html table
		class: 'table table-hover';
		with: [ html
				tableHead: [ html
						tableRow: [ html
								tableData: 'Granja';
								tableData: 'Acción' ] ].
			html
				tableBody: [ self session gapAFarm farms
						do: [ :each | 
							html
								tableRow: [ html tableData: [ html text: each name ].
									html tableData: [ self renderFarmSelectorFor: each on: html ] ] ] ] ]
]

{ #category : #rendering }
GAFAdminComponent >> renderPermissionSwitchsOn: html [
	html heading
		level4;
		with: 'Permisos'.
	html table
		class: 'table table-hover';
		with: [ html
				tableHead: [ html
						tableRow: [ html
								tableData: 'Correo del usuario';
								tableData: 'Permisos' ] ].
			html
				tableBody: [ self session gapAFarm users
						do: [ :each | 
							html
								tableRow: [ html tableData: [ html text: each email ].
									html
										tableData: [ self renderToggleExpertFor: each on: html.
											html space.
											self renderToggleAdminFor: each on: html.
											html space.
											self renderResetPasswordFor: each on: html ] ] ] ] ]
]

{ #category : #rendering }
GAFAdminComponent >> renderResetPasswordFor: each on: html [
	html anchor
		callback: [ self resetPasswordFor: each ];
		with: [ html formButton
				beSecondary;
				with: 'Establecer contraseña' ]
]

{ #category : #rendering }
GAFAdminComponent >> renderReturnButtonOn: html [
	^ html anchor
		callback: [ self answer ];
		with: [ html formButton
				bePrimary;
				with: 'Volver' ]
]

{ #category : #rendering }
GAFAdminComponent >> renderToggleAdminFor: each on: html [
	^ each isAdmin
		ifTrue: [ html anchor
				callback: [ each
						isAdmin: false;
						save ];
				with: [ html formButton
						beWarning;
						with: 'Quitar admin' ] ]
		ifFalse: [ html anchor
				callback: [ each
						isAdmin: true;
						save ];
				with: [ html formButton
						bePrimary;
						with: 'Otorgar admin' ] ]
]

{ #category : #rendering }
GAFAdminComponent >> renderToggleExpertFor: each on: html [
	^ each isExpert
		ifTrue: [ html anchor
				callback: [ each
						isExpert: false;
						save ];
				with: [ html formButton
						beWarning;
						with: 'Quitar experto' ] ]
		ifFalse: [ html anchor
				callback: [ each
						isExpert: true;
						save ];
				with: [ html formButton
						bePrimary;
						with: 'Otorgar experto' ] ]
]

{ #category : #rendering }
GAFAdminComponent >> resetPasswordFor: each [
	| newPassword |
	newPassword := self request: 'Indique una contraseña temporal.'.
	newPassword ifNil: [ ^ self ].
	self session user
		hashedPassword: (SHA256 new hashMessage: newPassword asByteArray) asString.
	self session user save
]
