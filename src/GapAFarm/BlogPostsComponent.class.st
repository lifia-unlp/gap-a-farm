Class {
	#name : #BlogPostsComponent,
	#superclass : #GAFAbstractTableWithFilterAndActionsComponent,
	#category : #'GapAFarm-ui-expert'
}

{ #category : #rendering }
BlogPostsComponent >> columnHeadings [
	^ {'Fecha' . 'Visibilidad' . 'Texto' . 'Me gusta'}
]

{ #category : #rendering }
BlogPostsComponent >> columnValuesFor: element [
	^ {element date asDate ddmmyyyy.
	(self visibilityStringFor: element).
	element text.
	element likes printString}
]

{ #category : #hooks }
BlogPostsComponent >> elementClass [
	"Returns the class of elements to edit and add"

	^ BlogPost
]

{ #category : #hooks }
BlogPostsComponent >> elementEditorClass [
	"Returns the class of editor used to edit elements"

	^ BlogPostEditorComponent
]

{ #category : #accessing }
BlogPostsComponent >> elements [
	^ self session gapAFarm blogPosts
]

{ #category : #initialization }
BlogPostsComponent >> initialize [
	super initialize.
	duplicateEnabled := false.
	removeEnabled := true.
	viewEnabled := false.
	editEnabled := true.
]

{ #category : #callbacks }
BlogPostsComponent >> removeElement: element [
	^ element remove
]

{ #category : #rendering }
BlogPostsComponent >> visibilityStringFor: element [
	^ String
		streamContents: [ :stream | 
			element visibleThrough
				ifNotNil: [ :it | 
					stream
						nextPutAll: 'Hasta el: ';
						nextPutAll: it asDate ddmmyyyy;
						nextPutAll: '. ' ].
			element crops , element adversityTypes
				ifNotEmpty: [ :they | 
					stream
						nextPutAll: 'Para: ';
						nextPutAll: they asCommaString;
						nextPutAll: '. ' ] ]
]
