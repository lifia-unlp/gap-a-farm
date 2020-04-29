Class {
	#name : #WAPluggableEditor,
	#superclass : #WAComponent,
	#instVars : [
		'subject',
		'parent'
	],
	#category : #'GapAFarm-ui-editors'
}

{ #category : #'instance creation' }
WAPluggableEditor class >> subject: anObject [
	^ self new
		subject: anObject;
		yourself
]

{ #category : #callbacks }
WAPluggableEditor >> accept [
	(self children anySatisfy: [ :each | each hasProblems ])
		ifTrue: [ ^ self ].
	self children do: #accept.
	
	"this last part only makes sense for embedded editors - are we using it?"
	parent
		ifNil: [ self answer: subject ]
		ifNotNil: [ :it | it answer: subject ]
]

{ #category : #callbacks }
WAPluggableEditor >> cancel [
	self children do: #cancel.
	parent ifNil: [ self answer: nil ] ifNotNil: [ :it | it answer: nil ]
]

{ #category : #'subclass-responsibility' }
WAPluggableEditor >> children [
	"Return all property editors in this editor, in the order you want them to be rendered"

	^ self subclassResponsibility
]

{ #category : #'subclass-responsibility' }
WAPluggableEditor >> initializeComponents [
	"Initialize all property components"

	^ self subclassResponsibility
]

{ #category : #accessing }
WAPluggableEditor >> parent [
	^ parent
]

{ #category : #accessing }
WAPluggableEditor >> parent: anObject [
	parent := anObject
]

{ #category : #rendering }
WAPluggableEditor >> renderButtonsOn: html [
	html
		paragraph: [ html formButton
			   id: 'accept-button';
				bePrimary;
				callback: [ self accept ];
				with: 'Aceptar'.
			html space.
			html anchor
			   id: 'cancel-anchor';
				class: 'btn btn-secondary';
				callback: [ self cancel ];
				with: 'Cancelar' ]
]

{ #category : #rendering }
WAPluggableEditor >> renderChildrenOn: html [
	self children do: [ :each | html render: each ]
]

{ #category : #rendering }
WAPluggableEditor >> renderContentOn: html [
	html
		form: [ self renderChildrenOn: html.
			self renderProblemsOn: html.
			self renderButtonsOn: html ]
]

{ #category : #rendering }
WAPluggableEditor >> renderProblemsOn: html [
	(self children flatCollect: #problems)
		do: [ :each | 
			html alert
				beDanger;
				with: each ]
]

{ #category : #rendering }
WAPluggableEditor >> rendererClass [
	^ SBSHtmlCanvas
]

{ #category : #accessing }
WAPluggableEditor >> subject [
	^ subject
]

{ #category : #accessing }
WAPluggableEditor >> subject: anObject [
	subject := anObject.
	self initializeComponents
]
