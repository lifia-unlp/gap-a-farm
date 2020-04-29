Class {
	#name : #PropertyEditorComponent,
	#superclass : #WAComponent,
	#instVars : [
		'id',
		'label',
		'readOnly',
		'required',
		'problems',
		'bufferedValue',
		'instructions',
		'setBlock',
		'getBlock',
		'subject'
	],
	#category : #'GapAFarm-widgets'
}

{ #category : #'instance creation' }
PropertyEditorComponent class >> id: anId subject: anObject getBlock: aGetBlock setBlock: aSetBlock label: aLabel required: aBoolean [
	^ self new
		id: anId
			subject: anObject
			getBlock: aGetBlock
			setBlock: aSetBlock
			label: aLabel
			required: aBoolean;
		yourself
]

{ #category : #'instance creation' }
PropertyEditorComponent class >> id: anId subject: anObject selector: aMessageSelector label: aLabel required: aBoolean [
	^ self new
		id: anId
			subject: anObject
			selector: aMessageSelector
			label: aLabel
			required: aBoolean;
		yourself
]

{ #category : #api }
PropertyEditorComponent >> accept [
	setBlock value: subject value: bufferedValue.
	problems := OrderedCollection new
]

{ #category : #accessing }
PropertyEditorComponent >> addProblem: aProblemString [
	problems add: aProblemString
]

{ #category : #accessing }
PropertyEditorComponent >> bufferedValue [
	^ bufferedValue
]

{ #category : #accessing }
PropertyEditorComponent >> bufferedValue: anObject [
	^ bufferedValue := anObject
]

{ #category : #api }
PropertyEditorComponent >> cancel [
	bufferedValue := getBlock value: subject.
	problems := OrderedCollection new
]

{ #category : #accessing }
PropertyEditorComponent >> getBlock [
	^ getBlock
]

{ #category : #accessing }
PropertyEditorComponent >> getBlock: anObject [
	getBlock := anObject
]

{ #category : #rendering }
PropertyEditorComponent >> handleCallbackWith: aString [
	problems := OrderedCollection new.
	aString isEmpty & required
		ifTrue: [ problems add: label , ' es un dato obligatorio.'.
			^ self ].
	bufferedValue := self obtainValueFromString: aString
]

{ #category : #api }
PropertyEditorComponent >> hasProblems [
	^ problems notEmpty
]

{ #category : #accessing }
PropertyEditorComponent >> id [
	^ id
		ifNil: [ label
				ifNotNil: [ id := label asCamelCase asValidSelector ]
				ifNil: [ id := Time millisecondClockValue asString ] ]
]

{ #category : #initialization }
PropertyEditorComponent >> id: anId subject: anObject getBlock: aGetBlock setBlock: aSetBlock label: aLabel required: aBoolean [
	id := anId.
	subject := anObject.
	getBlock := aGetBlock.
	setBlock := aSetBlock.
	label := aLabel.
	required := aBoolean.
	problems := OrderedCollection new.
	bufferedValue := getBlock value: subject.
	readOnly := false
]

{ #category : #initialization }
PropertyEditorComponent >> id: anId subject: anObject selector: aMessageSelector label: aLabel required: aBoolean [
	self
		id: anId
		subject: anObject
		getBlock: [ :theSubject | theSubject perform: aMessageSelector ]
		setBlock:
			[ :theSubject :value | theSubject perform: aMessageSelector asMutator with: value ]
		label: aLabel
		required: aBoolean
]

{ #category : #accessing }
PropertyEditorComponent >> instructions [
	^ instructions
]

{ #category : #accessing }
PropertyEditorComponent >> instructions: anObject [
	instructions := anObject
]

{ #category : #accessing }
PropertyEditorComponent >> label: anObject [
	label := anObject
]

{ #category : #hooks }
PropertyEditorComponent >> obtainValueFromString: value [
	^ value
]

{ #category : #accessing }
PropertyEditorComponent >> problems [
	^ problems
]

{ #category : #accessing }
PropertyEditorComponent >> problems: anObject [
	problems := anObject
]

{ #category : #accessing }
PropertyEditorComponent >> readOnly: anObject [
	readOnly := anObject
]

{ #category : #rendering }
PropertyEditorComponent >> renderContentOn: html [
	html
		formGroup: [ self renderLabelOn: html.
			self renderInputOn: html.
			self renderInstructionsOn: html ]
]

{ #category : #hooks }
PropertyEditorComponent >> renderInputOn: html [
	^ self subclassResponsibility
]

{ #category : #rendering }
PropertyEditorComponent >> renderInstructionsOn: html [
	readOnly
		ifTrue: [ ^ self ].
	instructions
		ifNotNil: [ html small
				id: id , 'HelpBlock';
				class: 'form-text text-muted';
				with: instructions ]
]

{ #category : #rendering }
PropertyEditorComponent >> renderLabelOn: html [
	html label
		for: self id;
		with: [ html text: label.
			required
				ifTrue: [ html span
						style: 'color: red; ';
						with: ' *' ].
 ]
]

{ #category : #rendering }
PropertyEditorComponent >> rendererClass [
	^ SBSHtmlCanvas
]

{ #category : #accessing }
PropertyEditorComponent >> required [
	^ required
]

{ #category : #accessing }
PropertyEditorComponent >> required: anObject [
	required := anObject
]

{ #category : #accessing }
PropertyEditorComponent >> setBlock [
	^ setBlock
]

{ #category : #accessing }
PropertyEditorComponent >> setBlock: anObject [
	setBlock := anObject
]

{ #category : #initialization }
PropertyEditorComponent >> setDefault: aValue [
	bufferedValue := aValue
]

{ #category : #updating }
PropertyEditorComponent >> updateRoot: aWARoot [
	super updateRoot: aWARoot.
	JQBaseTheme default updateRoot: aWARoot
]
