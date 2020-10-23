Class {
	#name : #FarmsAdminComponent,
	#superclass : #GAFAbstractTableWithFilterAndActionsComponent,
	#category : #'GapAFarm-ui-admin'
}

{ #category : #initialization }
FarmsAdminComponent >> columnHeadings [
	^ {'Nombre'}
]

{ #category : #initialization }
FarmsAdminComponent >> columnValuesFor: aFarm [
	^ {(self session farm = aFarm
		ifTrue: [ self session farm == self session user farms first
				ifFalse: [ '<b style="color:red">' , aFarm name , ' (en esta sesión)</b>' ]
				ifTrue: [ '<b>' , aFarm name , ' (propia - en esta sesión)</b>' ] ]
		ifFalse: [ aFarm == self session user farms first
				ifTrue: [ '<b>' , aFarm name , ' (propia)</b>' ]
				ifFalse: [ aFarm name ] ])}
]

{ #category : #hooks }
FarmsAdminComponent >> elementClass [
	"Returns the class of elements to edit and add"

	^ Farm
]

{ #category : #initialization }
FarmsAdminComponent >> elements [
	^ self session gapAFarm farms
]

{ #category : #initialization }
FarmsAdminComponent >> initialize [
	super initialize.
	viewEnabled := true.
	addEnabled := false.
	duplicateEnabled := false.
	editEnabled := false
]

{ #category : #initialization }
FarmsAdminComponent >> renderContentOn: html [
	html
		container: [ html heading: 'Granjas'.
			super renderContentOn: html ]
]

{ #category : #hooks }
FarmsAdminComponent >> renderSpecificActionsFor: aFarm on: html [
	self session farm == aFarm
		ifTrue: [ ^ self ].
	html div class: 'dropdown-divider'.
	html anchor
		class: 'dropdown-item';
		callback: [ self session farm: aFarm ];
		with: 'Usar en esta sessión'
]

{ #category : #hooks }
FarmsAdminComponent >> viewElement: aFarm [
	self
		call:
			(FarmSnapshotComponent new
				farm: aFarm;
				yourself)
]
