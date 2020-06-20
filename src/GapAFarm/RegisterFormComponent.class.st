Class {
	#name : #RegisterFormComponent,
	#superclass : #LoginFormComponent,
	#instVars : [
		'repeatEmail',
		'repeatEmailComponent',
		'fullname',
		'fullnameComponent'
	],
	#category : #'GapAFarm-ui-login'
}

{ #category : #callbacks }
RegisterFormComponent >> accept [
	(self children anySatisfy: [ :each | each hasProblems ])
		ifTrue: [ ^ self ].
	self children do: #accept.
	self emailsMatch
		ifFalse: [ problem := 'Los correos electronicos no coinciden.'.
			^ self ].
	self parent
		register: email greaseString trimBoth
		withHashedPassword: hashedPassword
		andName: fullname.
		
]

{ #category : #'subclass-responsibility' }
RegisterFormComponent >> children [
	^ {fullnameComponent.
	emailComponent.
	repeatEmailComponent.
	passwordComponent}
]

{ #category : #rendering }
RegisterFormComponent >> emailsMatch [
	^ email greaseString = repeatEmail greaseString
]

{ #category : #accessing }
RegisterFormComponent >> fullname [
	^ fullname
]

{ #category : #accessing }
RegisterFormComponent >> fullname: anObject [
	fullname := anObject
]

{ #category : #initialization }
RegisterFormComponent >> initialize [
	super initialize.
	repeatEmailComponent := EmailPropertyEditorComponent
	   id: 'repeatEmail'
		subject: self
		selector: #repeatEmail
		label: 'Repita el correo electrónico (e-mail)'
		required: true.
	fullnameComponent := TextLinePropertyEditorComponent
	   id: 'fullname'
		subject: self
		selector: #fullname
		label: 'Nombre completo'
		required: true.
	problem := nil
]

{ #category : #accessing }
RegisterFormComponent >> repeatEmail [
	^ repeatEmail
]

{ #category : #accessing }
RegisterFormComponent >> repeatEmail: anObject [
	repeatEmail := anObject
]
