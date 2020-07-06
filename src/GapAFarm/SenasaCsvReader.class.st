"
-
"
Class {
	#name : #SenasaCsvReader,
	#superclass : #Object,
	#category : #'GapAFarm-senasa'
}

{ #category : #constants }
SenasaCsvReader class >> autoCorrectionDictionary [
	^ Dictionary new
		at: 'funguicida' put: 'fungicida';
		at: 'antidoto de herbicida' put: 'antídoto de herbicida';
		at: 'trat de suelos' put: 'tratamiento de suelos';
		at: 'tratamiento semillas' put: 'tratamiento de semillas';
		at: 'tormiquicida' put: 'tormiguicida';
		at: 'hidroxido de cobre' put: 'hidróxido de cobre';
		at: '1,3 diclopropeno' put: '1,3 dicloropropeno';
		at: '2,4 -  db' put: '2,4-DB';
		at: '2,4-d' put: '2,4-D';
		at: 'Alfafla' put: 'Alfalfa';
		at: 'R. de bruselas' put: 'Repollito de bruselas';
		at: 'pyriproxifen' put: 'pyriproxyfen';
		yourself
]

{ #category : #constants }
SenasaCsvReader class >> normalizedApplicabilities [
	^ {('tt' -> 'tratamiento de semillas').
	('ah' -> 'antídoto de herbicidas').
	('ba' -> 'bactericida').
	('fr' -> 'fitorreguladores').
	('he' -> 'herbicida').
	('fu' -> 'fungicida').
	('in' -> 'insecticida').
	('ac' -> 'acaricida').
	('ne' -> 'nematicida').
	('go' -> 'gorgojicida').
	('rd' -> 'rodenticida').
	('mo' -> 'molusquicida').
	('tu' -> 'tucuricida').
	('ma' -> 'matababosas y caracoles').
	('pm' -> 'preservador de madera').
	('ho' -> 'hormiguicida')} asDictionary
]

{ #category : #data }
SenasaCsvReader class >> res608year12 [
	^ self new
		fromRes608Year2012Stream: GAFLibrary new res60812anexoCsv readStream
]

{ #category : #data }
SenasaCsvReader class >> res934year10 [
	^ self new
		fromRes934Year2010Stream: GAFLibrary new res93410anexoCsv readStream
]

{ #category : #'934Year10' }
SenasaCsvReader >> applicabilitiesFor934Value: aString [
	| applicabilitiesInString |
	applicabilitiesInString := (aString copyWithoutAll: {$( . $)})
		splitOn:
			{$-.
			Character space}.
	applicabilitiesInString := applicabilitiesInString
		collect: [ :each | 
			self
				fixTyposIn: (self expand934AbbreviationsIn: each asLowercase trimBoth) ].
	^ applicabilitiesInString
]

{ #category : #'608Year12' }
SenasaCsvReader >> applicability608For: aString [
	^ Set
		with: (self problems608ToApplicabilitiesMapping at: aString asLowercase)
]

{ #category : #'934Year10' }
SenasaCsvReader >> expand934AbbreviationsIn: aString [
	^ self class normalizedApplicabilities
		at: aString
		ifAbsent: [ aString ]
]

{ #category : #common }
SenasaCsvReader >> fixTyposIn: aString [
	^ self class autoCorrectionDictionary
		at: aString
		ifAbsent: [ aString ]
]

{ #category : #'608Year12' }
SenasaCsvReader >> fromRes608Year2012Stream: aReadStream [
	"Produce jSon from an untouched CSV file corresponding to resolucion 608 of 2012 (minor crops)"

	| rows all withoutDuplicates |
	rows := (NeoCSVReader on: aReadStream)
		skip;
		skip;
		upToEnd.
	all := rows
		flatCollect: [ :row | self recordsFrom608Year2012Row: row ].
	withoutDuplicates := all asSet.
	^ withoutDuplicates
]

{ #category : #'934Year10' }
SenasaCsvReader >> fromRes934Year2010Stream: aReadStream [
	"Produce jSon from an untouched CSV file corresponding to resolucion 934 of 2010"

	| rows |
	rows := (NeoCSVReader on: aReadStream)
		skip;
		upToEnd.
	^ rows collect: [ :row | self recordFrom934Year2010Row: row ]
]

{ #category : #'608Year12' }
SenasaCsvReader >> problems608ToApplicabilitiesMapping [
	^ {('mosca blanca' -> 'insecticida').
	('pulgones' -> 'insecticida').
	('arañuelas' -> 'acaricida').
	('lyriomiza' -> 'insecticida').
	('sclerotinia  ' -> 'fungicida').
	('botrytis cinerea' -> 'fungicida').
	('trips' -> 'insecticida').
	('orugas ' -> 'insecticida').
	('orugas defoliadoras' -> 'insecticida').
	('mildew' -> 'fungicida').
	('oidio' -> 'fungicida').
	('tizón' -> 'fungicida').
	('bacteriosis' -> 'fungicida').
	('vaquita de las coles' -> 'insecticida').
	('cercospora sp.' -> 'fungicida').
	('g. cortadores' -> 'insecticida').
	('peronospora' -> 'fungicida').
	('phythium' -> 'insecticida').
	('fusarium sp,' -> 'fungicida').
	('orugas' -> 'insecticida').
	('sclerotinia sp,' -> 'fungicida').
	('acaros' -> 'acaricida').
	('alternaria sp.' -> 'fungicida').
	('sclerotinia' -> 'fungicida').
	('antracnosis' -> 'fungicida').
	('spodoptera' -> 'insecticida').
	('chinches' -> 'insecticida').
	('hormigas' -> 'hormiguicida').
	('gusanos de suelo' -> 'insecticida').
	('gusano de la fruta' -> 'insecticida')} asDictionary
]

{ #category : #'934Year10' }
SenasaCsvReader >> recordFrom934Year2010Row: row [
	^ SenasaRecord new
		cropVulgarName:
			(self
				fixTyposIn:
					(row third
						ifNil: [ '' ]
						ifNotNil: [ :it | it asLowercase trimBoth capitalized ]));
		activeIngredientTradeName:
			(self
				fixTyposIn: (row first ifNil: [  ] ifNotNil: [ :it | it asLowercase trimBoth ]));
		applicabilities:
			(row second
				ifNil: [ #() ]
				ifNotNil: [ :it | self applicabilitiesFor934Value: it ]);
		residue: (self residueFromString: row fourth);
		source: 'RESOLUCIÓN-934-2010-SENASA';
		yourself
]

{ #category : #'608Year12' }
SenasaCsvReader >> recordsFrom608Year2012Row: row [
	| activePrinciples records residues |
	records := OrderedCollection new.
	activePrinciples := (row third splitOn: $+)
		collect: [ :each | each asLowercase trimBoth ].
	residues := ((row at: 10) splitOn: $+)
		collect: [ :each | self residueFromString: each ].
	activePrinciples
		with: residues
		do: [ :principle :residue | 
			records
				add:
					(SenasaRecord new
						cropVulgarName: row first trimBoth asLowercase capitalized;
						activeIngredientTradeName: (self fixTyposIn: principle);
						applicabilities: (self applicability608For: row second);
						residue: residue;
						source: 'RESOLUCIÓN-608-2012-SENASA';
						yourself) ].
	^ records
]

{ #category : #common }
SenasaCsvReader >> residueFromString: each [
	^ [ each asLowercase trimBoth asNumber ]
		on: Error
		do: [ nil ]
]
