Class {
	#name : #GAFAbstractTableComponent,
	#superclass : #GAFAbstractComponent,
	#instVars : [
		'paginator'
	],
	#category : #'GapAFarm-ui-common'
}

{ #category : #rendering }
GAFAbstractTableComponent >> columnHeadings [
	^ {}
]

{ #category : #rendering }
GAFAbstractTableComponent >> columnValuesFor: element [
	^ {}
]

{ #category : #accessing }
GAFAbstractTableComponent >> elements [
	^ self subclassResponsibility
]

{ #category : #accessing }
GAFAbstractTableComponent >> filteredElements [ 
	^self elements
]

{ #category : #initialization }
GAFAbstractTableComponent >> initialize [
	super initialize.
	paginator := Paginator subject: self selector: #filteredElements pageSize: 10.

]

{ #category : #accessing }
GAFAbstractTableComponent >> paginator: anObject [
	paginator := anObject
]

{ #category : #accessing }
GAFAbstractTableComponent >> parent [
	^ parent
]

{ #category : #rendering }
GAFAbstractTableComponent >> renderContentOn: html [
	self renderElementsTableOn: html.
	paginator renderPaginationOn: html
]

{ #category : #rendering }
GAFAbstractTableComponent >> renderElementRowFor: element class: aCssClass on: html [
	(self columnValuesFor: element)
		do: [ :value | 
			| td |
			td := html tableData.
			aCssClass ifNotNil: [ td class: aCssClass ].
			td with: [ html html: value ] ]
]

{ #category : #rendering }
GAFAbstractTableComponent >> renderElementsTableOn: html [
	html table
		class: 'table table-hover table-sm';
		with: [ self tableHeadingOn: html.
				  self renderTableBodyOn: html ]
]

{ #category : #rendering }
GAFAbstractTableComponent >> renderExtraRowValue: element On: html [
	^nil
]

{ #category : #rendering }
GAFAbstractTableComponent >> renderHeadingRowOn: html [
	^ self columnHeadings do: [ :heading | html tableHeading: heading ]
]

{ #category : #rendering }
GAFAbstractTableComponent >> renderTableBodyOn: html [
	html
		tableBody: [ (paginator selectElementsIn: self filteredElements)
				do: [ :element | 
					html tableRow:
						[ self renderElementRowFor: element class: nil on: html ] ] ]
]

{ #category : #rendering }
GAFAbstractTableComponent >> tableHeadingOn: html [
	html tableHead:
		[ html tableRow: [ self renderHeadingRowOn: html ] ]
]
