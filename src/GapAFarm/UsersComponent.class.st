Class {
	#name : #UsersComponent,
	#superclass : #GAFAbstractTableWithFilterAndActionsComponent,
	#category : #'GapAFarm-ui-admin'
}

{ #category : #hooks }
UsersComponent >> columnHeadings [
	^ {'Nombre completo' . 'Correo electrónico' . 'Notas' . 'Permisos'.
	'Estado'}
]

{ #category : #hooks }
UsersComponent >> columnValuesFor: aGAFUser [
	^ {aGAFUser fullname.
	aGAFUser email.
	(self shorten: aGAFUser comment to: 50).
	(self permissionsFor: aGAFUser).
	(self statusOf: aGAFUser)} , (super columnValuesFor: aGAFUser)
]

{ #category : #hooks }
UsersComponent >> elementClass [
	"Returns the class of elements to edit and add"

	^ GAFUser
]

{ #category : #accessing }
UsersComponent >> elements [
	^ self session gapAFarm users
]

{ #category : #rendering }
UsersComponent >> initialize [
	super initialize.
	duplicateEnabled := false
]

{ #category : #hooks }
UsersComponent >> permissionsFor: aGAFUser [
	| permissions |
	permissions := OrderedCollection new.
	aGAFUser isExpert
		ifTrue: [ permissions add: 'Expert' ].
	aGAFUser isAdmin
		ifTrue: [ permissions add: 'Admin' ].
	^ permissions asCommaString
]

{ #category : #rendering }
UsersComponent >> renderContentOn: html [
	html
		container: [ html heading: 'Usuarios'.
			super renderContentOn: html ]
]

{ #category : #hooks }
UsersComponent >> renderSpecificActionsFor: user on: html [
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

{ #category : #hooks }
UsersComponent >> statusOf: aGAFUser [
	^ aGAFUser enabled
		ifTrue: [ 'activo' ]
		ifFalse: [ '<span style="color:red">inactivo</span>' ]
]

{ #category : #callbacks }
UsersComponent >> toggleAdminFor: user [
	user isAdmin: user isAdmin not.
	user save
]

{ #category : #callbacks }
UsersComponent >> toggleEnabledFor: user [
	user enabled: user enabled not.
	user save
]

{ #category : #callbacks }
UsersComponent >> toggleExpertFor: user [
	user isExpert: user isExpert not.
	user save
]
