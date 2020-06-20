Class {
	#name : #UsersAdminComponent,
	#superclass : #GAFAbstractTableWithFilterAndActionsComponent,
	#category : #'GapAFarm-ui-admin'
}

{ #category : #hooks }
UsersAdminComponent >> columnHeadings [
	^ {'Nombre completo' . 'Correo electrónico' . 'Notas' . 'Permisos'.
	'Estado'}
]

{ #category : #hooks }
UsersAdminComponent >> columnValuesFor: aGAFUser [
	^ {aGAFUser fullname.
	aGAFUser email.
	(self shorten: aGAFUser comment to: 50).
	(self permissionsFor: aGAFUser).
	(self statusOf: aGAFUser)} , (super columnValuesFor: aGAFUser)
]

{ #category : #hooks }
UsersAdminComponent >> elementClass [
	"Returns the class of elements to edit and add"

	^ GAFUser
]

{ #category : #accessing }
UsersAdminComponent >> elements [
	^ self session gapAFarm users
]

{ #category : #rendering }
UsersAdminComponent >> initialize [
	super initialize.
	duplicateEnabled := false
]

{ #category : #hooks }
UsersAdminComponent >> permissionsFor: aGAFUser [
	| permissions |
	permissions := OrderedCollection new.
	aGAFUser isExpert
		ifTrue: [ permissions add: 'Expert' ].
	aGAFUser isAdmin
		ifTrue: [ permissions add: 'Admin' ].
	^ permissions asCommaString
]

{ #category : #rendering }
UsersAdminComponent >> renderContentOn: html [
	html
		container: [ html heading: 'Usuarios'.
			super renderContentOn: html ]
]

{ #category : #hooks }
UsersAdminComponent >> renderSpecificActionsFor: user on: html [
	html div class: 'dropdown-divider'.
	html anchor
		class: 'dropdown-item';
		callback: [ self toggleAdminFor: user ];
		with:
			(user isAdmin
				ifTrue: [ 'Quitar admin' ]
				ifFalse: [ 'Otorgar admin' ]).
	html anchor
		class: 'dropdown-item';
		callback: [ self toggleExpertFor: user ];
		with:
			(user isExpert
				ifTrue: [ 'Quitar experto' ]
				ifFalse: [ 'Otorgar experto' ]).
	html anchor
		class: 'dropdown-item';
		callback: [ self resetPasswordFor: user ];
		with: 'Cambiar contraseña'.
	user isAdmin
		ifTrue: [ ^ self ].
	html anchor
		class: 'dropdown-item';
		callback: [ self toggleEnabledFor: user ];
		with:
			(user enabled
				ifTrue: [ 'Desactivar' ]
				ifFalse: [ 'Activar' ])
]

{ #category : #callbacks }
UsersAdminComponent >> resetPasswordFor: each [
	| newPassword |
	newPassword := self request: 'Indique una nueva contraseña.'.
	newPassword ifNil: [ ^ self ].
	each
		hashedPassword: (SHA256 new hashMessage: newPassword asByteArray) asString.
	each save
]

{ #category : #hooks }
UsersAdminComponent >> statusOf: aGAFUser [
	^ aGAFUser enabled
		ifTrue: [ 'activo' ]
		ifFalse: [ '<span style="color:red">inactivo</span>' ]
]

{ #category : #callbacks }
UsersAdminComponent >> toggleAdminFor: user [
	user isAdmin: user isAdmin not.
	user save
]

{ #category : #callbacks }
UsersAdminComponent >> toggleEnabledFor: user [
	user enabled: user enabled not.
	user save
]

{ #category : #callbacks }
UsersAdminComponent >> toggleExpertFor: user [
	user isExpert: user isExpert not.
	user save
]
