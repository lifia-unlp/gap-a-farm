Class {
	#name : #ExampleDataLoaderToStressTest,
	#superclass : #Object,
	#instVars : [
		'session',
		'lastDay'
	],
	#category : #'GapAFarm-example-data'
}

{ #category : #constants }
ExampleDataLoaderToStressTest >> activeIngredients [
	^ ( '6 bencil adenina.Acefato.Aceite de arbol del te.Aceite de creosota.Aceite de soja.Aceite escencial de ajo.Acequinocyl.Acetamiprid.Acetato de amonio.Acetoclor.Acido arsanilico.Acido beta naftoxiacetico.Acido borico.Acido cacodilico.Acido citrico.Acido fosforico.Acido graso metacloro.Acido indol 3 butírico.Acido ortofosforico.Acido propionico.Acirfluorfen sodico.Aclonifen.Acrinatrina.Acroleina.Alaclor.Alcohol alcoxilado.Alcohol etoxilado.Alcoholes grasos.Alfa naftalen acetato de sodio.Alquil fenol etoxilado.Ametoctradin.Ametrina.Amicarbazone.Amina grasa etoxilada.Aminoetoxivinilglicina.Aminopyralid.Aminotriazol.Amisulbron.Amitraz.Amonio cuaternario.Asulam.Atrazina.Azadiractina.Azoxistrobina.Azufre.Bacillus subtilis.Bacillus thuringiensis.Beauveria bassiana.Benalaxil.Benazolin etil.Benfuracarb.Benomil.Bentazon.Benzoato de emamectina.Benzovindiflupir.Betaciflutrin.Betacipermetrina.Biciclopirona.Bifenazate.Bifentrin.Bispiribac  sodico.Bistriflurón.Bixafen.Boscalid.Brodifacoum.Bromacil.Bromadiolone.Bromopropilato.Bromoxinil.Bromuro de metilo.Bupirimato.Buprofezin.Butafenacil.Butralin.Caolin.Caolinita.Captan.Carbaril.Carbendazim.Carbofuran.Carbonato basico de cu.Carboxin.Carfentrazone etil.Cartap.Cialofop butil.Cianamida hidrogenada.Cipermetrina.Cletodim.Clodinafop  propargil.Clofentezine.Clomazone.Clopiralid.Cloquintocet mexyl.Cloransulam  metil.Clorantraniliprole.Clorfenapir.Clorfluazuron.Clorimuron  etil.Cloromecuato.Cloropicrina.Clorotalonil.Clorpirifos  metil.Clorsulfuron.Clothianidin.Contiene sucroglicéridos.Cumetetralil.Cyantraniliprole (cyazypyr).Cyazofamid.Cyclanilide.Cyflumetofen.Cyhexatin.Cymoxanil.Cyproconazole.Cyprodinil.Cyprosulfamide.Daminozine.Dazomet.Dialurin ester + poliet.Dicamba.Diclofo  metil.Diclofop  metil.Diclosulam.Difenilamina.Difenoconazole.Difetialone.Diflubenzuron.Diflufenican.Dimetenamida.Dimetil disulfuro.Dimetiphin.Dimetoato.Dimetomorf.Dimoxistrobin.Diniconazole.Dinotefuran.Diquat dibromuro.Ditianon.Diuron.Dodecadienol.Dodecenilacetato.Dodecil benceno sulf trietanolamida.Epoxiconazole.Esfenvalerato.Ester metilico de aceites vegetales.Ester poliglicol de acidos grasos.Etefon.Ethaboxam.Ethiprole.Etion.Extracto de ajo.Famoxadone.Fenamifos.Fenarimol.Fenazaquin.Fenbuconazole.Fenbutatin oxido.Fenhexamid.Fenitrotion.Fenmedifan.Fenoxaprop etil.Fenpiroximato.Fenpropatrina.Fention.Fentoato.Fenvalerato.Ferbam.Fipronil.Flazasulfuron.Flonicamid.Florpyrauxifen etil.Fluazifop- p- butil.Fluazinam.Flubendiamide.Flucarbazone.Fludioxonil.Flufenacet.Flufenoxuron.Flumetralin.Flumetsulam.Flumiclorac pentil.Flumioxazim.Fluometuron.Fluopicolide.Fluorocloridona.Fluoxastrobin.Fluquinconazole.Fluroxipir.Flusilazole.Flutriafol.Fluxapyroxad.Fluxofenim.Folcisteina.Folpet.Fomesafen.Foramsulfuron.Formetanato.Fosetil aluminio.Fosfina.Fosmet.Fostiazate.Giberelinas a4 a7.Glandlure.Glicol ester.Glufosinato de amonio.Guazatine.Halosulfuron.Halosulfuron metil.Haloxyfop-p- metil  ester.Heptametiltrisiloxano.Hexaconazole.Hexazinona.Hexitiazox.Hidrazida maleica.Hidroxicloruro de trimetilamina.Hidroxido de cobre.Imazalil.Imazamox.Imazapic.Imazapir.Imazaquin.Imazetapir.Imidacloprid.Indaziflam.Indoxacarb.Iodosulfuron  metil sodio.Ioxinil octanoato.Ipoconazole.Iprodione.Iprovalicarb.Isopyrazam.Isoxaflutole.Kasugamicina.Kinetina.Kresoxim  metil.Lactofen.Lecitina de soja.Lenacil.Lignosulfonato de calcio.Linuron.Lufenuron.Mancozeb.Mandipropamid.Mepiquat cloruro.Meptyl dinocap.Mesotrione.Metabenztiazuron.Metaflumizone.Metalaxil.Metalaxil – m -isomero.Metaldehido.Metam potasio.Metam sodio.Metamitron.Metconazole.Metidation.Metil tiofanato.Metilciclopropeno.Metiram.Metomil.Metominostrobin.Metoxifenocide.Metrafenone.Metribuzin.Metsulfuron   metil.Mezcla de esteres de acidos grasos de aceites vegetales.Mezcla de esteres de alquil fenol y polietilenglicol.Mezcla de esteres y jabones provenientes de ácidos grasos de aceites vegetales trans-esterificados con glicerina.Molinate.Myclobutanil.Nafteno de zinc.Napropamida.Naptalan.Nonil fenol etoxilado.Novaluron.Octifenol y polietilenglicol.Oleato de etilo.Oleato de potasio.Ortofenilfenato  de sodio.Oryzalin.Oxadiazon.Oxasulfuron.Oxathiapiprolin.Oxicloruro de cobre.Oxido cuproso.Oxido de cocoamida propil.Oxifluorfen.Oxitetraciclina.Oxitetraciclina clorhidrato.Paraquat  (dicloruro).Penconazole.Pencycuron.Pendimetalin.Penoxulam.Pentiopirad.Permetrina.Picloran.Picoxystrobin.Pinoxaden.Piraflufen etil.Piretrinas.Piridafention.Pirimicarb.Pirimifos  metil.Piroxasulfone.Polioxi ester amino graso.Polisulfuro de calcio.Polyphase.Primisulfuron.Procimidone.Procloraz.Profenofos.Prometrina.Propamocarb  clorhidrato.Propanil.Propaquizafop.Propargite.Propiconazole.Propineb.Propizamida.Prosulfuron.Prothioconazole.Pydiflumetofen.Pymetrozine.Pyraclostrobin.Pyrimetanil.Pyriproxyfen.Pyrldaben.Pyroxsulam.Quinclorac.Quinoxyfen.Quitosano.Quizalofop- p- tefuril.Rianodina.Rimsulfuron.Saflufenacil.Sales cca.Saponinas.Sedaxane.Serricornin.Sethoxidim.Simazina.Spinetoram.Spinosad.Spirodiclofen.Spiromesifen.Spirotetramat.Sulfato cuprico pentahidratado.Sulfato de amonio.Sulfato de estreptomicina.Sulfato de gentamicina.Sulfato neutro de oxiquinol.Sulfato tetracupico tricalcico.Sulfato tribásico de cobre.Sulfentrazone.Sulfluramida.Sulfometurón metil.Sulfoxaflor.Tebufenozide.Tebutiuron.Teflubenzuron.Teflutrina.Tembotrione.Terbacil.Terbutilazina.Terbutrina.Tetraconazole.Tetradifon.Thiencarbazone metil.Tiabendazol.Tiacloprid.Tiadiazuron.Tiametoxam.Tierra de diatomeas.Tifensulfuron metil.Tiodicarb.Tiram.Tolcloros metil.Tolpyralate.Tolyfluanid.Topramezone.Tralkoxydim.Triadimefon.Triadimenol.Triasulfuron.Tribromo fenato de sodio.Tribromo fenol.Tribufos.Trichoderma.Triclopyr.Trifenil acetato de estaño.Trifloxistrobin.Trifloxisulfuron.Triflumuron.Trifluralina.Triforine.Trinexapac etil.Triticonazole.Valiphenal.Virus de la granulosis de cydia.Zetametrina.Zineb.Ziram.Zoxamide'
		splitOn: '.')
		collect: [ :tradeName | 
			ActiveIngredient new
				tradeName: tradeName ;
				yourself ]
]

{ #category : #loading }
ExampleDataLoaderToStressTest >> addDemoApplicationToPlot: aPlot [
	| application time type substance |
	lastDay := lastDay addDays: (1 to: 10) atRandom.
	time := {'8:00' . '10:00' . '14:00' . '16:00' . '18:00'} atRandom asTime.
	type := {'Peste' . 'Enfermedad'} atRandom.
	substance := session gapAFarm substances atRandom. 
	application := Application new
		reason: 'Una ' , type , ' muy grave';
		substance: substance;
		dose: '200mg/ha';
		machine: 'Dosificador 1';
		date: lastDay;
		time: time;
		plot: aPlot;
		yourself.
	aPlot addEvent: application.
	application save.
	aPlot save
]

{ #category : #loading }
ExampleDataLoaderToStressTest >> addDemoEventsToPlot: aPlot [
	lastDay := '1/1/1980' asDate.
   20
		timesRepeat: [ self addDemoSowingToPlot: aPlot.
			self addDemoProblemToPlot: aPlot.
			self addDemoApplicationToPlot: aPlot.
			self addDemoHarvestingToPlot: aPlot ]
]

{ #category : #loading }
ExampleDataLoaderToStressTest >> addDemoHarvestingToPlot: aPlot [
	| harvesting time  |
	lastDay := lastDay addDays: (1 to: 10) atRandom.
	time := {'8:00' . '10:00' . '14:00' . '16:00' . '18:00'} atRandom asTime.
	harvesting := Harvesting new
		crop: aPlot lastestSowing crop;
		date: lastDay;
		time: time;
		plot: aPlot;
		quantity: 3000 atRandom;
		otherUnit:
			(Measurement
				magnitude: 300 atRandom
				unit: {'Canastos' . 'Razos' . 'Paquetes'} atRandom);
		yourself.
	aPlot addEvent: harvesting.
	harvesting save.
	aPlot save
]

{ #category : #loading }
ExampleDataLoaderToStressTest >> addDemoPlots [
	^ self plots
		do: [ :plot | 
			plot save.
			session farm addPlot: plot.
			session farm save ]
]

{ #category : #loading }
ExampleDataLoaderToStressTest >> addDemoProblemToPlot: aPlot [
	| problem time type |
	lastDay := lastDay addDays: (1 to: 10) atRandom.
	time := {'8:00' . '10:00' . '14:00' . '16:00' . '18:00'} atRandom asTime.
	type := {'Peste' . 'Enfermedad'} atRandom.
	problem := AdversityReport new
		name: 'Una ' , type , ' muy grave';
		type: type;
		date: lastDay;
		time: time;
		plot: aPlot;
		yourself.
	aPlot addEvent: problem.
	problem save.
	aPlot save
]

{ #category : #loading }
ExampleDataLoaderToStressTest >> addDemoSowingToPlot: aPlot [
	| sowing time crop |
	lastDay := lastDay addDays: (1 to: 10) atRandom.
	time := {'8:00' . '10:00' . '14:00' . '16:00' . '18:00'} atRandom asTime.
	crop := session gapAFarm crops atRandom.
	sowing := Sowing new
		crop: crop;
		date: lastDay;
		time: time;
		plot: aPlot;
		quantity: (Measurement magnitude: 1000 unit: 'Plantas');
		timeToHarvest: 90;
		harvestDuration: 60;
		expectedYield: 2000;
		yourself.
	aPlot addEvent: sowing.
	sowing save.
	aPlot save. 
]

{ #category : #loading }
ExampleDataLoaderToStressTest >> addExpertDemoData [
	session gapAFarm crops ifEmpty: [ self crops do: #save ].
	session gapAFarm activeIngredients
		ifEmpty: [ self activeIngredients do: #save ].
	session gapAFarm substances ifEmpty: [ self substances do: #save ]
]

{ #category : #loading }
ExampleDataLoaderToStressTest >> addFarmerDemoData [
	session gapAFarm crops ifEmpty: [ self addExpertDemoData ].
	session farm plots
		ifEmpty: [ self addDemoPlots.
			session farm plots do: [ :aPlot | self addDemoEventsToPlot: aPlot ] ]
]

{ #category : #constants }
ExampleDataLoaderToStressTest >> crops [
	^ {'Acelga' . 'Achicoria' . 'Ají' . 'Ajo' . 'Ajo (bulbo)' . 'Albahaca'.
	'Apio' . 'Batata' . 'Berenjena' . 'Berro' . 'Brócoli' . 'Calabaza'.
	'Cardo' . 'Cebolla' . 'Chaucha' . 'Cilantro' . 'Col' . 'Coliflor'.
	'Colinabo' . 'Colza' . 'Endivia' . 'Eneldo' . 'Escarola' . 'Espárrago'.
	'Espinaca' . 'Frutilla' . 'Hinojo' . 'Lechuga' . 'Menta' . 'Nabo'.
	'Orégano' . 'Papa' . 'Pepino' . 'Pera' . 'Perejil' . 'Pimiento'.
	'Puerro' . 'Rábano' . 'Radiccio' . 'Radicheta' . 'Remolacha'.
	'Repollito de Bruselas' . 'Repollo' . 'Romero' . 'Rúcula' . 'Salvia'.
	'Sandía' . 'Tomate' . 'Tomillo' . 'Zanahoria' . 'Zapallito de tronco'.
	'Zapallo'}
		collect: [ :vulgarName | 
			Crop new
				vulgarName: vulgarName;
				yourself ]
]

{ #category : #constants }
ExampleDataLoaderToStressTest >> plots [
	^ (1 to: 20)
		collect: [ :each | Plot id: 'A' , each asString surface: 1000 ]
]

{ #category : #utility }
ExampleDataLoaderToStressTest >> randomCrops: aNumber [
	| allCrops selectedCrops |
	allCrops := session gapAFarm crops.
	selectedCrops := Set new.
	[ selectedCrops size < (aNumber min: allCrops size / 2) ]
		whileTrue: [ selectedCrops add: allCrops atRandom ].
	^ selectedCrops
]

{ #category : #accessing }
ExampleDataLoaderToStressTest >> session [
	^ session
]

{ #category : #accessing }
ExampleDataLoaderToStressTest >> session: anObject [
	session := anObject
]

{ #category : #constants }
ExampleDataLoaderToStressTest >> substances [
	^ session gapAFarm activeIngredients
		collect: [ :ingredient | 
			| substance |
			substance := Substance new
				comercialName: 'Preparado de ' , ingredient tradeName;
				addActiveIngredient: ingredient.
			(self randomCrops: 4)
				do: [ :crop | 
					substance
						addWithdrawalRecommendation:
							(WithdrawalRecommendation
								daysToWait: {1 . 3 . 7 . 21} atRandom
								crop: crop
								referenceUrl: '') ].
			substance ]
]
