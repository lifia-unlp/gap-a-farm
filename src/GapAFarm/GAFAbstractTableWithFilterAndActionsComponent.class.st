Class {
	#name : #GAFAbstractTableWithFilterAndActionsComponent,
	#superclass : #GAFAbstractTableComponent,
	#instVars : [
		'editEnabled',
		'removeEnabled',
		'addEnabled',
		'duplicateEnabled',
		'viewEnabled',
		'filterComponent'
	],
	#category : #'GapAFarm-ui-common'
}

{ #category : #rendering }
GAFAbstractTableWithFilterAndActionsComponent >> actionsEnabled [
	^ removeEnabled | duplicateEnabled | editEnabled | viewEnabled
]

{ #category : #callbacks }
GAFAbstractTableWithFilterAndActionsComponent >> addElement [
	| element |
	element := self
		call: (self elementEditorClass subject: self elementClass new).
	element ifNotNil: [ :it | self saveAddedElement: it ].
	^ element
]

{ #category : #testing }
GAFAbstractTableWithFilterAndActionsComponent >> addEnabled [
	^ addEnabled
]

{ #category : #hooks }
GAFAbstractTableWithFilterAndActionsComponent >> duplicate: element [
	^ element copy
]

{ #category : #callbacks }
GAFAbstractTableWithFilterAndActionsComponent >> duplicateElement: element [
	(self call: (self elementEditorClass subject: (self duplicate: element)))
		ifNotNil: [ :it | self saveAddedElement: it ]
]

{ #category : #testing }
GAFAbstractTableWithFilterAndActionsComponent >> duplicateEnabledFor: element [
	^ duplicateEnabled
]

{ #category : #callbacks }
GAFAbstractTableWithFilterAndActionsComponent >> editElement: element [
	(self
		call: (self elementEditorClass subject: element))
		ifNotNil: [ :it | self saveEditedElement: it ]
]

{ #category : #testing }
GAFAbstractTableWithFilterAndActionsComponent >> editEnabledFor: element [
	^ editEnabled
]

{ #category : #hooks }
GAFAbstractTableWithFilterAndActionsComponent >> elementClass [
	"Returns the class of elements to edit and add"

	^ self subclassResponsibility
]

{ #category : #hooks }
GAFAbstractTableWithFilterAndActionsComponent >> elementEditorClass [
	"Returns the class of editor used to edit elements"

	^ self subclassResponsibility
]

{ #category : #initialization }
GAFAbstractTableWithFilterAndActionsComponent >> filterComponent [
	^ filterComponent
		ifNil: [ filterComponent := TableFilterComponent
				columns: (self columnHeadings copyWithout: 'Acciones') ]
]

{ #category : #accessing }
GAFAbstractTableWithFilterAndActionsComponent >> filteredElements [
	| allElements |
	allElements := self elements.
	self filterComponent shouldFilter
		ifFalse: [ ^ allElements ].
	^ allElements
		select: [ :each | 
			((self columnValuesFor: each)
				at: (self columnHeadings indexOf: self filterComponent column))
				asLowercase
				includesSubstring: self filterComponent filter asLowercase ]
]

{ #category : #initialization }
GAFAbstractTableWithFilterAndActionsComponent >> initialize [
	super initialize.
	viewEnabled := false.
	editEnabled := true.
	removeEnabled := false.
	addEnabled := true.
	duplicateEnabled := true.

]

{ #category : #accessing }
GAFAbstractTableWithFilterAndActionsComponent >> parent: anObject [
	parent := anObject
]

{ #category : #callbacks }
GAFAbstractTableWithFilterAndActionsComponent >> removeElement: element [
	^ self subclassResponsibility
]

{ #category : #testing }
GAFAbstractTableWithFilterAndActionsComponent >> removeEnabledFor: element [
	^ removeEnabled
]

{ #category : #rendering }
GAFAbstractTableWithFilterAndActionsComponent >> renderActionMenuFor: element on: html [
	html dropdown
		with: [ html formButton
				id: 'dropdownMenuButton';
				class: 'fa fa-ellipsis-v';
				dataToggle: 'dropdown'.
			html div
				class: 'dropdown-menu';
				attributeAt: 'aria-labelledby' put: 'dropdownMenuButton';
				with: [ (self viewEnabledFor: element)
						ifTrue: [ html anchor
								class: 'dropdown-item';
								callback: [ self viewElement: element ];
								with: 'Ver' ].
					(self editEnabledFor: element)
						ifTrue: [ html anchor
								class: 'dropdown-item';
								callback: [ self editElement: element ];
								with: 'Modificar' ].
					(self duplicateEnabledFor: element)
						ifTrue: [ html anchor
								class: 'dropdown-item';
								callback: [ self duplicateElement: element ];
								with: 'Duplicar' ].
					(self removeEnabledFor: element)
						ifTrue: [ html anchor
								class: 'dropdown-item';
								callback: [ self removeElement: element ];
								with: 'Eliminar' ].
					self renderSpecificActionsFor: element on: html ] ]
]

{ #category : #rendering }
GAFAbstractTableWithFilterAndActionsComponent >> renderAddButtonOn: html [
	addEnabled
		ifTrue: [ html
				paragraph: [ html anchor
					   id: 'add-button';
						callback: [ self addElement ];
						with: [ html formButton
								bePrimary;
								with: 'Agregar' ] ] ]
]

{ #category : #rendering }
GAFAbstractTableWithFilterAndActionsComponent >> renderContentOn: html [
	html render: self filterComponent.
	super renderContentOn: html.
	self renderAddButtonOn: html
]

{ #category : #rendering }
GAFAbstractTableWithFilterAndActionsComponent >> renderElementRowFor: element class: aCssClass on: html [
	| td |
	super renderElementRowFor: element class: aCssClass on: html.
	self actionsEnabled
		ifFalse: [ ^ self ].
	td := html tableData.
	aCssClass ifNotNil: [ td class: aCssClass ].
	td with: [ self renderActionMenuFor: element on: html ]
]

{ #category : #rendering }
GAFAbstractTableWithFilterAndActionsComponent >> renderHeadingRowOn: html [
	super renderHeadingRowOn: html.
	self actionsEnabled
		ifTrue: [ html tableHeading: '' ]
]

{ #category : #rendering }
GAFAbstractTableWithFilterAndActionsComponent >> renderSpecificActionsFor: element on: html [
	^ self
]

{ #category : #hooks }
GAFAbstractTableWithFilterAndActionsComponent >> saveAddedElement: anElement [
	anElement save.
	
]

{ #category : #hooks }
GAFAbstractTableWithFilterAndActionsComponent >> saveEditedElement: anElement [
	anElement save
]

{ #category : #callbacks }
GAFAbstractTableWithFilterAndActionsComponent >> viewElement: element [
	^ self
]

{ #category : #testing }
GAFAbstractTableWithFilterAndActionsComponent >> viewEnabledFor: element [
	^ viewEnabled
]
