Extension { #name : #String }

{ #category : #'*GapAFarm' }
String >> waTranslatedIn: aWAComponent [
	"translates the receiver to the domain and locale of aWAComponent"

	^ self
		translatedInDomain: aWAComponent session translationDomain
		locale: aWAComponent session translationLocale
]
